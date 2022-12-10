import 'package:flutter_riverpod/flutter_riverpod.dart';

final roundnessProvider = Provider<double>((ref) {
  double roundness = 30.0;
  return roundness;
});

final squareButtonRoundnessProvider = Provider<double>((ref) {
  double roundness = 30.0;
  return roundness;
});
