import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:calculator/tools/logging.dart';

DebugPrintCallback debugPrint = customDebugPrint("Bugger", true);
bool enableBadUI = true;
bool enableDelay = false;
bool enableIgnore = false;

enum Severity {
  light(0.3, 0.35645488, delayMax: 1.0),
  normal(0.6, 0.48242367),
  high(0.8, 0.7336255, delayMax: 1.7, boolDistribution: [1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);

  final double delayMin;
  final double delayMax;
  final double normSigma;
  final double normMean;
  final List<int> boolDistribution;
  const Severity(
    this.normMean,
    this.normSigma, {
    this.delayMin = 0.0,
    this.delayMax = 1.4,
    this.boolDistribution = const [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  });
}

// The delay returned is a number from a normal distribution with [normMean] as mean and [normSigma] as standard dev
// This standard deviation is to get a 15% of chance to get a delay of 0 seconds
//
// These values were calculated as follows:
// ```python
// from scipy.stats import norm
// normMean = 0.5
// targetChanceAtZero = 0.15
// normSigma = (0 - normMean) / norm.ppf(targetChanceAtZero)
// ```

// 15% change of getting a delay of 0
var normSigma = Severity.normal.normSigma;
var normMean = Severity.normal.normMean;
var delayMin = Severity.normal.delayMin;
var delayMax = Severity.normal.delayMax;
NormalRandom normalRandom = NormalRandom(mean: normMean, stdDev: normSigma);

// 15% of the time, is true
var currentBiasedCoinFlip = Severity.normal.boolDistribution;

void setSeverityParameters(Severity severity) {
  currentBiasedCoinFlip = severity.boolDistribution;
  delayMin = severity.delayMin;
  delayMax = severity.delayMax;
  normMean = severity.normMean;
  normSigma = severity.normSigma;
  normalRandom = NormalRandom(mean: normMean, stdDev: normSigma);
}

class NormalRandom {
  final double mean;
  final double stdDev;
  final Random _rand;

  NormalRandom({this.mean = 0.0, this.stdDev = 1.0, Random? rng}) : _rand = rng ?? Random();

  double next() {
    // Box-Muller transform
    double u1 = _rand.nextDouble();
    double u2 = _rand.nextDouble();
    double z0 = sqrt(-2.0 * log(u1)) * cos(2 * pi * u2);
    return z0 * stdDev + mean;
  }
}

double getTimeDelay() {
  const maxRetries = 100;
  var i = 0;
  double sample = 0;
  do {
    sample = normalRandom.next();
    i++;
  } while (i < maxRetries && (sample < delayMin || sample > delayMax));
  return sample;
}

Duration randomDuration() {
  final delay = getTimeDelay();
  final secs = delay.truncate();
  final mils = ((delay - secs) * 1000).truncate();
  return Duration(seconds: secs, milliseconds: mils);
}

Future<void> randomDelay() async {
  if (!enableDelay) {
    return;
  }
  final randDuration = randomDuration();
  debugPrint("Delaying execution by: $randDuration");
  await Future.delayed(randDuration);
}

bool randomIgnore() {
  if (!enableIgnore) {
    return false;
  }
  final ignore = currentBiasedCoinFlip[Random().nextInt(currentBiasedCoinFlip.length)] == 1;
  debugPrint("Should ignore button press? $ignore");
  return ignore;
}

Future<bool> randomBug() async {
  if (enableDelay && enableIgnore) {
    if (Random().nextBool()) {
      await randomDelay();
      return false;
    } else {
      var ignore = randomIgnore();
      return ignore;
    }
  } else if (!enableDelay && enableIgnore) {
    return randomIgnore();
  } else if (enableDelay && !enableIgnore) {
    await randomDelay();
    return false;
  }
  return false;
}

/// key: The expected output of an operation, value: whether if next operation has bugs turned on
const resultTogglers = {
  "97.0": false, // From here: UX with normal operation
  "6.5": false,
  "165.0": false,
  "43.0": false,
  "3.0": false,
  "41.0": false,
  "-135.0": false,
  "47.75": false,
  "140.0": false,
  "12.3": false,
  "1.0": false,
  "125.5": false,
  "40.25": false,
  "142.0": false,
  "20.0": false,
  "5.75": false, // From here: stressful UX operation's results, may be errors
  "424.0": false,
  "130.0": true,
  "-148.0": true,
  "31.4": true,
  "96.4": false,
  "66.0": false,
  "-1.0": true,
  "-738.0": true,
  "90.0": false,
  "43.75": false,
  "22.0": false,
  "122.0": true,
  "218.0": true,
  "71.0": false,
};
