import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/models/home_model.dart';

class HomeNotifier extends StateNotifier<List<HomeModel>> {
  HomeNotifier() : super([]);

  void addHome(HomeModel homeToAdd) {
    state = [...state, homeToAdd];
  }
}

final HomeProvider = StateNotifierProvider((ref) => HomeNotifier());

final MyHomesProvider = Provider<List<HomeModel>>((ref) {
  var userHomes = [
    HomeModel(
        homeId: "AAAAAAAA",
        name: "Forest House",
        location: {
          "address": "555 Oakroad, Winterforest",
          "coords": "19N 19W 19.19",
          "countryCode": "MX"
        },
        images: ["http://google.com/home1.jpg", "http://google.com/home2.jpg"],
        rooms: null),
    HomeModel(
        homeId: "BBBBBBBB",
        name: "Forest House",
        location: {
          "address": "555 Oakroad, Winterforest",
          "coords": "19N 19W 19.19",
          "countryCode": "MX"
        },
        images: ["http://google.com/home1.jpg", "http://google.com/home2.jpg"],
        rooms: null),
  ];

  return userHomes;
});
