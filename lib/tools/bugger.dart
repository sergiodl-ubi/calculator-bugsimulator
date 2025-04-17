import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:calculator/tools/logging.dart';

DebugPrintCallback debugPrint = customDebugPrint("Bugger", true);

bool enableDelay = true;
bool enableIgnore = true;

const delayMin = 0.0;
const delayMax = 2.5;
const normMean = 1.0;

// The delay returned is a number from a normal distribution with [normMean] as mean and [normSigma] as standard dev
// This standard deviation is to get a 15% of chance to get a delay of 0 seconds
//
// These values were calculated as follows:
// ```python
// from scipy.stats import norm
// normMean = 1.0
// targetChanceAtZero = 0.15
// normSigma = (0 - normMean) / norm.ppf(targetChanceAtZero)
// ```
const normSigma = 1.048036;
NormalRandom normalRandom = NormalRandom(mean: normMean, stdDev: normSigma);

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

const boolDistribution = [1, 1, 1, 1, 0, 0, 0, 0, 0, 0]; // 40% of the time, is true
bool randomIgnore() {
  if (!enableIgnore) {
    return false;
  }
  final ignore = boolDistribution[Random().nextInt(boolDistribution.length)] == 1;
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
