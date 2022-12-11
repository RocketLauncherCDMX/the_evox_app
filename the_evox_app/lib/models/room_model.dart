// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import 'device_model.dart';

class RoomModel {
  final String roomId;
  final String type;
  final String name;
  final String picture;
  final double powerUsage;
  late List<DeviceModel>? devices;

  RoomModel({
    required this.roomId,
    required this.type,
    required this.name,
    required this.picture,
    required this.powerUsage,
    this.devices,
  });

  RoomModel copyWith({
    String? roomId,
    String? type,
    String? name,
    String? picture,
    double? powerUsage,
    List<DeviceModel>? devices,
  }) {
    return RoomModel(
      roomId: roomId ?? this.roomId,
      type: type ?? this.type,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      powerUsage: powerUsage ?? this.powerUsage,
      devices: devices ?? this.devices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'type': type,
      'name': name,
      'picture': picture,
      'powerUsage': powerUsage,
      'devices':
          devices != null ? devices!.map((x) => x.toMap()).toList() : null,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] as String,
      type: map['type'] as String,
      name: map['name'] as String,
      picture: map['picture'] as String,
      powerUsage: map['powerUsage'] as double,
      devices: (map['devices'] != null)
          ? List<DeviceModel>.from(
              (map['devices'] as List).map<DeviceModel>(
                (x) => DeviceModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomModel(roomId: $roomId, type: $type, name: $name, picture: $picture, powerUsage: $powerUsage, devices: $devices)';
  }

  //** **************** */
  //** Kind of toMap and fromMap adapted to Firestore structure
  //** **************** */

  factory RoomModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data = snapshot.data();

    return data!.values.first.map<RoomModel>(
      (x) =>
          RoomModel.fromIndexAndMap(data.keys.first, x as Map<String, dynamic>),
    );
    /*return RoomModel(
      roomId: data?['roomId'],
      name: data?['name'],
      picture: data?['picture'],
      powerUsage: data?['powerUsage'],
      devices: (data?['devices'] != null)
          ? (data?['devices'] is Iterable
              ? List.from(data?['devices']
                  .where((x) => DeviceModel.fromFirestore(x, null)))
              : null)
          : null,
    );*/
  }

  factory RoomModel.fromIndexAndMap(String index, Map<String, dynamic> map) {
    List<DeviceModel>? devicesList;

    if (map['devices'] != null) {
      devicesList = [];
      map['devices'].forEach((key, value) {
        devicesList!.add(
            DeviceModel.fromIndexAndMap(key, value as Map<String, dynamic>));
      });
    }
    return RoomModel(
      roomId: index,
      type: map['type'] as String,
      name: map['name'] as String,
      picture: map['picture'] as String,
      powerUsage: map['powerUsage'] as double,
      devices: devicesList,
    );
  }

  Map<String, dynamic> toFirestore() {
    late Map<String, dynamic>? devicesToFirestore;
    if (devices != null) {
      devicesToFirestore = {};
      for (var deviceItem in devices!) {
        devicesToFirestore.addAll(deviceItem.toFirestore());
      }
    } else {
      devicesToFirestore = null;
    }
    return <String, dynamic>{
      roomId: <String, dynamic>{
        'name': name,
        'type': type,
        'picture': picture,
        'powerUsage': powerUsage,
        'devices': devicesToFirestore,
      }
    };
  }

  @override
  bool operator ==(covariant RoomModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.roomId == roomId &&
        other.type == type &&
        other.name == name &&
        other.picture == picture &&
        other.powerUsage == powerUsage &&
        listEquals(other.devices, devices);
  }

  @override
  int get hashCode {
    return roomId.hashCode ^
        type.hashCode ^
        name.hashCode ^
        picture.hashCode ^
        powerUsage.hashCode ^
        devices.hashCode;
  }
}
