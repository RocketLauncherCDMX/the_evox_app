// ignore_for_file: public_member_api_docs, sort_constructors_first,depend_on_referenced_packages
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import 'room_model.dart';

class HomeModel {
  final String homeId;
  final String name;
  final Map<String, dynamic> location;
  final List<String>? images;
  final List<RoomModel>? rooms;

  HomeModel({
    required this.homeId,
    required this.name,
    required this.location,
    required this.images,
    required this.rooms,
  });

  HomeModel copyWith({
    String? homeId,
    String? name,
    Map<String, String>? location,
    List<String>? images,
    List<RoomModel>? rooms,
  }) {
    return HomeModel(
      homeId: homeId ?? this.homeId,
      name: name ?? this.name,
      location: location ?? this.location,
      images: images ?? this.images,
      rooms: rooms ?? this.rooms,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'homeId': homeId,
      'name': name,
      'location': location,
      'images': images,
      'rooms': rooms?.map((x) => x.toFirestore()).toList(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      homeId: map['homeId'] as String,
      name: map['name'] as String,
      location: Map.from(map['location'] as Map<String, dynamic>),
      images: List<String>.from(map['images'] as List<dynamic>),
      rooms: (map['rooms'] != null)
          ? List<RoomModel>.from(
              (map['rooms'] as List).map<RoomModel>(
                (x) => RoomModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeModel(homeId: $homeId, name: $name, location: $location, images: $images, rooms: $rooms)';
  }

  //** **************** */
  //** Kind of toMap and fromMap adapted to Firestore structure
  //** **************** */

  factory HomeModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data = snapshot.data();

    return data!.values.first.map<HomeModel>(
      (x) =>
          HomeModel.fromIndexAndMap(data.keys.first, x as Map<String, dynamic>),
    );
    /*return HomeModel(
      homeId: data?['homeId'],
      name: data?['name'],
      location: data?['location'],
      images: data?['images'] is Iterable ? List.from(data?['images']) : null,
      rooms: (data?['rooms'] != null) //If there is atleast one room in home
          ? (data?['rooms'] is Iterable
              ? List.from(data?['devices']
                  .where((x) => {RoomModel.fromFirestore(x, null)}))
              : null)
          : null,
    );*/
  }

  factory HomeModel.fromIndexAndMap(String index, Map<String, dynamic> map) {
    return HomeModel(
      homeId: index,
      name: map['name'] as String,
      location: Map.from(map['location'] as Map<String, dynamic>),
      images: List<String>.from(map['images'] as List<dynamic>),
      rooms: (map['rooms'] != null)
          ? (map['rooms'] is Iterable
              ? List.from(
                  map['rooms'].where((x) => RoomModel.fromFirestore(x, null)))
              : null)
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      homeId: <String, dynamic>{
        'name': name,
        'location': location,
        'images': images,
        'rooms': (rooms != null) ? rooms!.map((x) => x.toFirestore()) : null,
      }
    };
  }

  @override
  bool operator ==(covariant HomeModel other) {
    if (identical(this, other)) return true;
    final collectionEquals = const DeepCollectionEquality().equals;

    return other.homeId == homeId &&
        other.name == name &&
        collectionEquals(other.location, location) &&
        collectionEquals(other.images, images) &&
        collectionEquals(other.rooms, rooms);
  }

  @override
  int get hashCode {
    return homeId.hashCode ^
        name.hashCode ^
        location.hashCode ^
        images.hashCode ^
        rooms.hashCode;
  }

  factory HomeModel.getTestObject() {
    return HomeModel(
        homeId: "01010101",
        name: "test home",
        location: {
          "address": "555 Oakroad, Winterforest",
          "coords": "19N 19W 19.19",
          "countryCode": "MX"
        },
        images: null,
        rooms: null);
  }
}
