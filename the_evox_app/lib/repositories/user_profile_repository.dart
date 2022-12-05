import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile_model.dart';

class UserProfileRepository {
  late CollectionReference dbUsersCollection; // collectionReference is from Firestore

  bool status = false;
  String errorMessage = "";
  int? errorCode;

  UserProfileRepository() {
    dbUsersCollection = FirebaseFirestore.instance.collection("users");
  }

  // ignore: todo
  // TODO: document possible errors (mabe just check fireb docs)

  Future<String> createUserProfile(UserProfile newProfileData) async {
    DateTime currentDt = DateTime.now();
    String? docCreated = "";
    try {
      newProfileData.created = currentDt;
      newProfileData.modified = currentDt;
      await dbUsersCollection
          .add(newProfileData.toFirestore())
          .then((DocumentReference doc) => {docCreated = doc.id});
      _setRepositoryState(true, "", 0);
    } on FirebaseException catch (e) {
      docCreated = null;
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 400);
    }
    return docCreated!;
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

  Future<UserProfile>? updateUserProfile(UserProfile udProfile) async {
    final DateTime modificationTimestamp = DateTime.now();
    try {
      dbUsersCollection.doc(udProfile.profileDocId).update({
        "name": udProfile.name,
        "email": udProfile.email,
        "photo": udProfile.photo,
        "countryCode": udProfile.countryCode,
        "modified": modificationTimestamp,
      });
      udProfile.modified = modificationTimestamp;
      _setRepositoryState(true, "", 1);
    } on FirebaseException catch (e) {
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 1);
    }
    return udProfile;
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

/* Example of use George's code
final UserProfile myUser = UserProfile(
    userId: userId,
    name: name,
    email: email,
    photo: photo,
    countryCode: countryCode,
    verified: verified
);

final HomeModel newHome = HomeModel(homeId: homeId, name: name, location: location, images: images, rooms: rooms)

if(createHomeForUser(newHome)) {
  myUser.homes.add(newHome);
}

if(updateHomeForUser(currentHome, newHome)) {
  myUser.homes[2] = newHome;
}*/
