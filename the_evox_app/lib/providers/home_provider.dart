import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/models/home_model.dart';

// -----------------------------------------------------------------------------
// Provider List of houses for the current user

class HomeNotifier extends StateNotifier<List<HomeModel>> {
  HomeNotifier() : super([]);

  void addHome(HomeModel homeToAdd) {
    state = [...state, homeToAdd];
  }
}

final homesProvider = StateNotifierProvider((ref) => HomeNotifier());

// -----------------------------------------------------------------------------