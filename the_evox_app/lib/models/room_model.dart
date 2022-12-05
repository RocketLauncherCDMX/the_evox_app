// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import 'device_model.dart';

class RoomModel {
  final String roomId;
  final String name;
  final String picture;
  final double powerUsage;
  final List<DeviceModel>? devices;

  RoomModel({
    required this.roomId,
    required this.name,
    required this.picture,
    required this.powerUsage,
    required this.devices,
  });

  RoomModel copyWith({
    String? roomId,
    String? name,
    String? picture,
    double? powerUsage,
    List<DeviceModel>? devices,
  }) {
    return RoomModel(
      roomId: roomId ?? this.roomId,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      powerUsage: powerUsage ?? this.powerUsage,
      devices: devices ?? this.devices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'name': name,
      'picture': picture,
      'powerUsage': powerUsage,
      'devices': devices != null ? devices!.map((x) => x.toMap()).toList() : null,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] as String,
      name: map['name'] as String,
      picture: map['picture'] as String,
      powerUsage: map['powerUsage'] as double,
      devices: List<DeviceModel>.from(
        (map['devices'] as List).map<DeviceModel>(
          (x) => DeviceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomModel(roomId: $roomId, name: $name, picture: $picture, powerUsage: $powerUsage, devices: $devices)';
  }

  factory RoomModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return RoomModel(
      roomId: data?['roomId'],
      name: data?['name'],
      picture: data?['picture'],
      powerUsage: data?['powerUsage'],
      devices: (data?['rooms'] != null)
          ? (data?['devices'] is Iterable
              ? List.from(data?['devices'].where((x) => {DeviceModel.fromFirestore(x, null)}))
              : null)
          : null,
    );
  }

  //*! **************** */
  //*! Probably not necesary because of Firestore db.add() accepts .toMap results
  //*! **************** */
  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'roomId': roomId,
      'name': name,
      'picture': picture,
      'powerUsage': powerUsage,
      'devices': devices != null ? devices!.map((x) => x.toFirestore()).toList() : null,
    };
  }

  @override
  bool operator ==(covariant RoomModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.roomId == roomId &&
        other.name == name &&
        other.picture == picture &&
        other.powerUsage == powerUsage &&
        listEquals(other.devices, devices);
  }

  @override
  int get hashCode {
    return roomId.hashCode ^
        name.hashCode ^
        picture.hashCode ^
        powerUsage.hashCode ^
        devices.hashCode;
  }
}
