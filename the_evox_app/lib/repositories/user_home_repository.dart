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
    dbUsrProfileDoc = FirebaseFirestore.instance.collection('users').doc(userProfileDocId);
  }

  //If insert succeed returns the timestamp of insertion, otherwise returns null
  Future<bool> createHome(HomeModel newHomeData) async {
    DateTime currentDt = DateTime.now();

    final homeMapped = newHomeData.toFirestore();

    try {
      await dbUsrProfileDoc!.update({
        "homes.${homeMapped.keys.first}": homeMapped.values.first,
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
    HomeModel updatedHome,
  ) async {
    DateTime currentDt = DateTime.now();

    final homeMapped = updatedHome.toFirestore();

    try {
      await dbUsrProfileDoc!.update({
        "homes.${homeMapped.keys.first}": homeMapped.values.first,
        "modified": currentDt,
      });
      _setRepositoryState(true, "", 0);
      return true;
    } on FirebaseException catch (e) {
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toString()}", 1);
      return false;
    }
  }

  Future<bool> deleteHome(String homeToDeleteId) async {
    DateTime currentDt = DateTime.now();

    try {
      await dbUsrProfileDoc!.update({
        "homes.$homeToDeleteId": FieldValue.delete(),
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
  void _setRepositoryState(bool _status, String _errorMessage, int? _errorCode) {
    status = _status;
    errorMessage = _errorMessage;
    errorCode = _errorCode;
  }
}
