import 'package:flutter_riverpod/flutter_riverpod.dart';

final isHomeLockedProvider = StateProvider<bool>((ref) {
  bool isHomeLocked = false;
  return isHomeLocked;
});

final isHomeDisabledProvider = StateProvider<bool>((ref) {
  bool isHomeLocked = false;
  return isHomeLocked;
});

final isEnergyOffProvider = StateProvider<bool>((ref) {
  bool isHomeLocked = false;
  return isHomeLocked;
});

final RoomsProvider = StateProvider<String>((ref) {
  var roomName = '';
  return roomName;
});
