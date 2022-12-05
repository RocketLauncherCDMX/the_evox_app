// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class DeviceModel {
  final String deviceId;
  final String name;
  final String type;
  final Map<String, dynamic> controller;
  final double powerMeasure;
  DeviceModel({
    required this.deviceId,
    required this.name,
    required this.type,
    required this.controller,
    required this.powerMeasure,
  });

  DeviceModel copyWith({
    String? deviceId,
    String? name,
    String? type,
    Map<String, dynamic>? controller,
    double? powerMeasure,
  }) {
    return DeviceModel(
      deviceId: deviceId ?? this.deviceId,
      name: name ?? this.name,
      type: type ?? this.type,
      controller: controller ?? this.controller,
      powerMeasure: powerMeasure ?? this.powerMeasure,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceId': deviceId,
      'name': name,
      'type': type,
      'controller': controller,
      'powerMeasure': powerMeasure,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      deviceId: map['deviceId'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      controller: Map<String, dynamic>.from(
          (map['controller'] as Map<String, dynamic>)),
      powerMeasure: map['powerMeasure'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) =>
      DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeviceModel(deviceId: $deviceId, name: $name, type: $type, controller: $controller, powerMeasure: $powerMeasure)';
  }

  factory DeviceModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DeviceModel(
      deviceId: data?['deviceId'],
      name: data?['name'],
      type: data?['type'],
      controller: Map.from(data?['controller']),
      powerMeasure: data?['powerMeasure'],
    );
  }

  //*! **************** */
  //*! Probably not necesary because of Firestore db.add() accepts .toMap results
  //*! **************** */
  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'deviceId': deviceId,
      'name': name,
      'type': type,
      'controller': controller,
      'powerMeasure': powerMeasure,
    };
  }

  @override
  bool operator ==(covariant DeviceModel other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other.deviceId == deviceId &&
        other.name == name &&
        other.type == type &&
        mapEquals(other.controller, controller) &&
        other.powerMeasure == powerMeasure;
  }

  @override
  int get hashCode {
    return deviceId.hashCode ^
        name.hashCode ^
        type.hashCode ^
        controller.hashCode ^
        powerMeasure.hashCode;
  }
}
