import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:the_evox_app/models/home_model.dart';

class UserHomeRepository {
  final String userProfileDocId;

  late DocumentReference? dbUsrProfileDoc;

  bool status = false;
  String errorMessage = "";
  int? errorCode;

  UserHomeRepository({
    required this.userProfileDocId,
  }) {
    dbUsrProfileDoc =
        FirebaseFirestore.instance.collection('users').doc(userProfileDocId);
  }

  //If insert succeed returns the timestamp of insertion, otherwise returns null
  Future<bool> createHome(HomeModel newHomeData) async {
    List<dynamic> homeArranged = [];
    DateTime currentDt = DateTime.now();

    bool result;

    homeArranged.add(newHomeData.toFirestore());

    try {
      await dbUsrProfileDoc!.update({
        "homes": FieldValue.arrayUnion(homeArranged),
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
  Future<bool> updateHome(
    HomeModel currentHome,
    HomeModel updatedHome,
  ) async {
    DateTime currentDt = DateTime.now();

    try {
      await dbUsrProfileDoc!.update({
        "homes": FieldValue.arrayRemove([currentHome.toFirestore()]),
      });
      await dbUsrProfileDoc!.update({
        "homes": FieldValue.arrayUnion([updatedHome.toFirestore()]),
        "modified": currentDt,
      });
      _setRepositoryState(true, "", 0);
      return true;
    } on FirebaseException catch (e) {
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toString()}", 1);
      return false;
    }
  }

  Future<bool> deleteHome(HomeModel homeToDelete) async {
    DateTime currentDt = DateTime.now();

    try {
      await dbUsrProfileDoc!.update({
        "homes": FieldValue.arrayRemove([homeToDelete.toFirestore()]),
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