import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/models/authorization_model.dart';
import 'package:the_evox_app/models/device_model.dart';
import 'package:the_evox_app/models/room_model.dart';
import 'package:the_evox_app/models/user_profile_model.dart';
import 'package:the_evox_app/repositories/user_home_repository.dart';

/*  // Creation of user in repotesting
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserProfileRepository _profileRepository = UserProfileRepository();
  UserHomeRepository? _homeRepository;
  UserProfile? signedProfile;
*/

/*var UserHomeRepositoryProvider = Provider<UserHomeRepository>((ref) {
  UserHomeRepository homeRepository;
  return homeRepository;
});*/

var creationDt = DateTime.now();
var userHomeRoomDevices = [
  DeviceModel(
      deviceId: "aa11aa11",
      name: "Main light",
      type: "Rgb Lamp",
      controller: {"parametro1": "valor1", "parametro2": "valor2"},
      powerMeasure: 100.0),
];

var userHomeRooms = <RoomModel>[
  RoomModel(
      roomId: "a1a1a1a1",
      type: "living",
      name: "Living room",
      picture: "http://google.com/home1room1.jpg",
      powerUsage: 2535.0,
      devices: userHomeRoomDevices),
];

final homeRepositoryProvider = StateProvider<UserHomeRepository?>((ref) {
  UserHomeRepository? userHomes;
  return userHomes;
});

/*final userHomesProvider = Provider<List<HomeModel>>((ref) {
  var userHomes = <HomeModel>[
    HomeModel(
        homeId: "AAAAAAAA",
        name: "my house",
        location: {
          "address": "555 Oakroad, Winterforest",
          "coords": "19N 19W 19.19",
          "countryCode": "MX"
        },
        images: ["http://google.com/home1.jpg", "http://google.com/home2.jpg"],
        rooms: userHomeRooms),
    HomeModel(
        homeId: "BBBBBBBB",
        name: "my house",
        location: {
          "address": "324 Snatoro, Wouldbingorf",
          "coords": "76N 37W 34.13",
          "countryCode": "MX"
        },
        images: ["http://google.com/home1.jpg", "http://google.com/home2.jpg"],
        rooms: userHomeRooms),
  ];
  return userHomes;
});*/

var userAuthorizations = [
  (AuthorizationModel(
      guestId: "02020202", homesAuthorized: ["AAAAAAAA", "BBBBBBBB"]))
];

var userStateProvider = StateProvider<UserProfile?>((ref) {
  UserProfile? signedUser;
  return signedUser;
});
