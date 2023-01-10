import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/models/device_model.dart';
import 'package:the_evox_app/models/home_model.dart';
import 'package:the_evox_app/models/room_model.dart';

// -----------------------------------------------------------------------------
// Provider List of houses for the current user

class HomeNotifier extends StateNotifier<List<HomeModel>> {
  HomeNotifier() : super([]);

  String newHomeName = ''; // "Lake Home"
  String newHomeAddress = ''; // "555 Oakroad, Winterforest"
  String newHomeCoords = ''; // "19N 19W 19.19"
  String newHomecountryCode = ''; // "MX"

  void addHome(HomeModel homeToAdd) {
    state = [...state, homeToAdd];
  }
}

final homesProvider = StateNotifierProvider((ref) => HomeNotifier());

// -----------------------------------------------------------------------------