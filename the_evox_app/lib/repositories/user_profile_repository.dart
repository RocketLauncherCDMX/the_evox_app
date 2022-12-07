import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_profile_model.dart';

class UserProfileRepository {
  late CollectionReference dbUsersCollection;

  bool status = false;
  String errorMessage = "";
  int? errorCode;

  UserProfileRepository() {
    dbUsersCollection = FirebaseFirestore.instance.collection("users");
  }

  /**
   * TODO: document possible errors (mabe just check fireb docs)
   */

  Future<String?> createUserProfile(UserProfile newProfileData) async {
    DateTime currentDt = DateTime.now();
    String? docCreatedId = "";
    try {
      newProfileData.created = currentDt;
      newProfileData.modified = currentDt;
      await dbUsersCollection
          .add(newProfileData.toFirestore())
          .then((DocumentReference doc) => {docCreatedId = doc.id});
      _setRepositoryState(true, "", 0);
    } on FirebaseException catch (e) {
      docCreatedId = null;
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 400);
    }
    return docCreatedId;
  }

  Future<UserProfile?> getUserProfileByAuthId(String userAuthId) async {
    UserProfile? profileData;
    try {
      final docSnap = await dbUsersCollection
          .where("userId", isEqualTo: userAuthId)
          .withConverter(
            fromFirestore: UserProfile.fromFirestore,
            toFirestore: (UserProfile uProfile, _) => uProfile.toFirestore(),
          )
          .get();

      if (docSnap.docs.isNotEmpty) {
        //A profile was found in db for the user authenticated
        profileData = docSnap.docs.first.data();
        profileData.profileDocId = docSnap.docs.first.id;
        _setRepositoryState(true, "", 0);
      } else {
        //There isnt a profile in db that matches with userAuthId
        profileData = null;
        _setRepositoryState(false, "No matching profile for userAuthId", 404);
      }
    } on FirebaseException catch (e) {
      profileData = null;
      _setRepositoryState(false, "FIREBASE CONN ERROR: ${e.message!.toLowerCase()}", 1);
    }
    return profileData;
  }

  Future<UserProfile> updateUserProfile(
    UserProfile currentProfile, {
    String? name = "",
    String? email = "",
    String? photo = "",
    String? countryCode = "",
  }) async {
    late DateTime? modificationTimestamp;
    late UserProfile? updatedProfile;

    try {
      modificationTimestamp = DateTime.now();
      await dbUsersCollection.doc(currentProfile.profileDocId).update({
        if (name != "") "name": name,
        if (email != "") "email": email,
        if (photo != "") "photo": photo,
        if (countryCode != "") "countryCode": countryCode,
        "modified": modificationTimestamp,
      });
      _setRepositoryState(true, "", 1);
      updatedProfile = UserProfile(
        userId: currentProfile.userId,
        name: name!,
        email: email!,
        photo: photo!,
        countryCode: countryCode!,
        homes: currentProfile.homes,
        authorizations: currentProfile.authorizations,
        invites: currentProfile.invites,
        created: currentProfile.created,
        modified: modificationTimestamp,
        profileDocId: currentProfile.profileDocId,
        verified: currentProfile.verified,
      );
      return updatedProfile;
    } on FirebaseException catch (e) {
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 1);
      return currentProfile;
    }
  }

  Future<bool> deleteUserProfile(String docProfileId) async {
    try {
      await dbUsersCollection
          .doc(docProfileId)
          .delete()
          .then((value) => print("User profile deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
      _setRepositoryState(true, "", 0);
      return true;
    } on FirebaseException catch (e) {
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 1);
      return false;
    }
  }

// ignore_for_file: no_leading_underscores_for_local_identifiers
//This 'repository state setter' method must be used before every
//posible result of each method ends
//* @param _status true for success on method, false for fail on method
  void _setRepositoryState(bool _status, String _errorMessage, int? _errorCode) {
    status = _status;
    errorMessage = _errorMessage;
    errorCode = _errorCode;
  }
}
