import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:the_evox_app/models/device_model.dart';

class DevicesRepository {
  final String userProfileDocId;

  late DocumentReference? dbUsrProfileDoc;

  bool status = false;
  String errorMessage = "";
  int? errorCode;

  DevicesRepository({
    required this.userProfileDocId,
  }) {
    dbUsrProfileDoc =
        FirebaseFirestore.instance.collection('users').doc(userProfileDocId);
  }

  //If insert succeed returns the timestamp of insertion, otherwise returns null
  Future<bool> createDevice(
      DeviceModel newDeviceData, String homeId, String roomId) async {
    DateTime currentDt = DateTime.now();

    final deviceMapped = newDeviceData.toFirestore();

    try {
      await dbUsrProfileDoc!.update({
        "homes.$homeId.rooms.$roomId.devices.${deviceMapped.keys.first}":
            deviceMapped.values.first,
        "modified": currentDt
      });
      _setRepositoryState(true, "", 0);
      return true;
    } on FirebaseException catch (e) {
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toString()}", 1);
      return false;
    }
  }

  //If user
  Future<bool> updateDevice(
      DeviceModel updatedDevice, String homeId, String roomId) async {
    DateTime currentDt = DateTime.now();

    final deviceMapped = updatedDevice.toFirestore();

    try {
      await dbUsrProfileDoc!.update({
        "homes.$homeId.rooms.$roomId.devices.${deviceMapped.keys.first}":
            deviceMapped.values.first,
        "modified": currentDt,
      });
      _setRepositoryState(true, "", 0);
      return true;
    } on FirebaseException catch (e) {
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toString()}", 1);
      return false;
    }
  }

  Future<bool> deleteDevice(
      String deviceToDeleteId, String homeId, String roomId) async {
    DateTime currentDt = DateTime.now();

    try {
      await dbUsrProfileDoc!.update({
        "homes.$homeId.rooms.$roomId.devices.$deviceToDeleteId":
            FieldValue.delete(),
        "modified": currentDt,
      });
      _setRepositoryState(true, "", 0);
      return true;
    } on FirebaseException catch (e) {
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toString()}", 1);
      return false;
    }
  }

// ignore_for_file: no_leading_underscores_for_local_identifiers
//This 'repository state setter' method must be used before every
//posible result of each method ends
//* @param _status true for success on method, false for fail on method
  void _setRepositoryState(
      bool _status, String _errorMessage, int? _errorCode) {
    status = _status;
    errorMessage = _errorMessage;
    errorCode = _errorCode;
  }
}
