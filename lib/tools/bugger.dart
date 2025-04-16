import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:calculator/tools/logging.dart';

DebugPrintCallback debugPrint = customDebugPrint("Bugger", true);

const enableDelay = true;

const delayMin = 0.0;
const delayMax = 3.0;
const normMean = 2.1;

// The delay returned is a number from a normal distribution with [normMean] as mean and [normSigma] as standard dev
// This standard deviation is to get a 3% of chance to get a delay of 0 seconds
//
// These values were calculated as follows:
// ```python
// from scipy.stats import norm
// normMean = 2.1
// targetChanceAtZero = 0.03
// normSigma = (0 - normSigma) / norm.ppf(targetChanceAtZero)
// ```
const normSigma = 1.11655;
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

Future<void> customDelay() async {
  if (!enableDelay) {
    return;
  }
  var delay = getTimeDelay();
  var secs = delay.truncate();
  var mils = ((delay - secs) * 1000).truncate();
  debugPrint("Delaying execution by: $secs.$mils");
  await Future.delayed(Duration(seconds: secs, milliseconds: mils));
}
