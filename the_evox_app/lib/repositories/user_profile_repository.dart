import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_profile_model.dart';

/**
   * TODO: add enum out of UserProfileRepository class (enum UserProfileRepositoryStatus{}) to improve error code handling
   */

//Firestore user profile handling
class UserProfileRepository {
  late CollectionReference dbUsersCollection;

  //Global variables for class state handling
  //Update these 3 vars using _setRepositoryState method
  bool status = false;
  String errorMessage = "";
  int? errorCode;

  //Constructor establishes database connection to 'users' collection
  UserProfileRepository() {
    dbUsersCollection = FirebaseFirestore.instance.collection("users");
  }

  //Creates a userprofile document in Firestore filled with [newProfileData] object
  //
  //On success returns [docCreatedId] as document Id, must be stored in UserProfile object
  //On failure or error returns [docCreatedId] as null
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
      _setRepositoryState(
          false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 400);
    }
    return docCreatedId;
  }

  //Searches a profile document for given authenticated user id [userAuthId]
  //
  //On success returns [profileData] filled with Firestore's profile document
  //On failure or error returns [profileData] as null
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
      //Error on Firestore connection
      profileData = null;
      _setRepositoryState(
          false, "FIREBASE CONN ERROR: ${e.message!.toLowerCase()}", 1);
    }
    return profileData;
  }

  //Updates user's name,email,photo AND/OR countryCode (only parameters given to method)
  //
  //On success returns [updatedProfile] object, filled with updated information
  //On failure or error returns [updatedProfile] as null
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
        "modified":
            modificationTimestamp, //Sets modified field with current date time
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
      _setRepositoryState(
          false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 1);
      return currentProfile;
    }
  }

  //Remove user profile's specified by [docProfileId]
  //
  //On success true is returned
  //On failure or error false is returned
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
      _setRepositoryState(
          false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 1);
      return false;
    }
  }

// ignore_for_file: no_leading_underscores_for_local_identifiers
// This 'repository state setter' method must be used before returning o throwing on each possible method result
// set [_status] true for success, false for fail or error
  void _setRepositoryState(
      bool _status, String _errorMessage, int? _errorCode) {
    status = _status;
    errorMessage = _errorMessage;
    errorCode = _errorCode;
  }
}
