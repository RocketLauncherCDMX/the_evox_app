import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/models/device_model.dart';
import 'package:the_evox_app/models/home_model.dart';
import 'package:the_evox_app/models/room_model.dart';
import 'package:the_evox_app/models/user_profile_model.dart';
import 'package:the_evox_app/repositories/user_home_repository.dart';
import 'package:the_evox_app/repositories/user_profile_repository.dart';

var userProvider = Provider<UserProfile>((ref) {
  UserProfile signedUser = UserProfile(
      userId: 'R5KGw7KLu35LGKGu765',
      name: 'Fabian Alfonso',
      email: 'juanHdz@gmail.com',
      photo:
          'https://lh3.googleusercontent.com/a/ALm5wu2ko5wjQrKV20cc4TTZZTD8kwCN7JvOswVhgg61Tw=s288-p-rw-no',
      countryCode: 'MX',
      //authorizations: userAuthorizations,
      //homes: userHomes,
      //invites: ["03030303", "04040404"],
      //created: creationDt,
      //modified: creationDt,
      verified: true,
      profileDocId: '');
  return signedUser;
});

final List<RoomModel> myRooms = [];
final StateProvider<int> lengthProvider = StateProvider(((ref) => 0));

var userRoomProvider = Provider<RoomModel>((ref) {
  RoomModel myRoom = RoomModel(
      roomId: '4590854',
      type: 'living',
      name: 'LivingRoom',
      picture:
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/living-room-ideas-hbx060122inspoopener-004-1657042789.jpg?crop=0.858xw:1.00xh;0.0452xw,0&resize=980:*',
      powerUsage: 265,
      devices: null);
  return myRoom;
});

var userRoom2Provider = Provider<RoomModel>((ref) {
  RoomModel myRoom = RoomModel(
      roomId: '12345',
      type: 'kitchen',
      name: 'Kitchen',
      picture:
          'https://www.bhg.com/thmb/rfB_8xN37Df52T-zEulT16V2vMo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/white-kitchen-floating-shelves-232ac9fb-fad090ab1f73478589de35a4e9b3b1e9.jpg',
      powerUsage: 125,
      devices: null);
  return myRoom;
});

List userHomeRooms = [
  RoomModel(
      roomId: "a1a1a1a1",
      type: "living",
      name: "Living room",
      picture: "http://google.com/home1room1.jpg",
      powerUsage: 2535.0,
      devices: null),
];

/*
UserProfile _createTestFilledProfile(
      {String testName = "Juan Hernandez", String testAuthId = "0101010101"}) {
    var creationDt = DateTime.now();
    var userHomeRoomDevices = [
      DeviceModel(
          deviceId: "aa11aa11",
          name: "Main light",
          type: "Rgb Lamp",
          controller: {"parametro1": "valor1", "parametro2": "valor2"},
          powerMeasure: 100.0),
    ];
    var userHomeRooms = [
      RoomModel(
          roomId: "a1a1a1a1",
          name: "Living room",
          picture: "http://google.com/home1room1.jpg",
          powerUsage: 2535.0,
          devices: userHomeRoomDevices),
    ];
    var userHomes = [
      HomeModel(
          homeId: "AAAAAAAA",
          name: "Forest House",
          location: {
            "address": "555 Oakroad, Winterforest",
            "coords": "19N 19W 19.19",
            "countryCode": "MX"
          },
          images: [
            "http://google.com/home1.jpg",
            "http://google.com/home2.jpg"
          ],
          rooms: userHomeRooms),
    ];
    var userAuthorizations = [
      (AuthorizationModel(
          guestId: "02020202", homesAuthorized: ["AAAAAAAA", "BBBBBBBB"]))
    ];
    return UserProfile(
        userId: testAuthId,
        name: testName,
        email: "juan.hernandez@gmail.com",
        photo: "http://google.com",
        countryCode: "MX",
        authorizations: userAuthorizations,
        homes: userHomes,
        invites: ["03030303", "04040404"],
        created: creationDt,
        modified: creationDt,
        verified: false);
  }
  */