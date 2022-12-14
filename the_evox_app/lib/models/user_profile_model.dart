// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import 'authorization_model.dart';
import 'home_model.dart';

class UserProfile {
  final String userId;
  String name;
  String email;
  final String? photo;
  final String? countryCode;
  late List<HomeModel>? homes;
  late List<AuthorizationModel>? authorizations;
  late List<String>? invites;
  late DateTime? created;
  late DateTime? modified;
  late bool? verified;
  late String? profileDocId;

  UserProfile({
    required this.userId,
    required this.name,
    required this.email,
    this.photo,
    this.countryCode,
    this.homes,
    this.authorizations,
    this.invites,
    this.created,
    this.modified,
    this.verified,
    this.profileDocId,
  });

  UserProfile copyWith({
    String? userId,
    String? name,
    String? email,
    String? photo,
    String? countryCode,
    List<HomeModel>? homes,
    List<AuthorizationModel>? authorizations,
    List<String>? invites,
    DateTime? created,
    DateTime? modified,
    bool? verified,
    String? profileDocId,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      countryCode: countryCode ?? this.countryCode,
      homes: homes ?? this.homes,
      authorizations: authorizations ?? this.authorizations,
      invites: invites ?? this.invites,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      verified: verified ?? this.verified,
      profileDocId: profileDocId ?? this.profileDocId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'photo': photo,
      'countryCode': countryCode,
      'homes': (homes != null) ? homes!.map((x) => x.toMap()).toList() : null,
      'authorizations': (authorizations != null)
          ? authorizations!.map((x) => x.toMap()).toList()
          : null,
      'invites': (invites != null) ? invites!.map((x) => x).toList() : null,
      'created': created,
      'modified': modified,
      'verified': verified,
      'profileDocId': profileDocId,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
        userId: map['userId'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        photo: map['photo'] as String,
        countryCode: map['countryCode'] as String,
        homes: (map['homes'] != null)
            ? (map['homes'] is Iterable
                ? List.from(
                    map['homes'].where((x) => HomeModel.fromFirestore(x, null)))
                : null)
            : null,
        authorizations: (map['authorizations'] != null)
            ? List<AuthorizationModel>.from(
                (map['authorizations'] as List<int>).map<AuthorizationModel>(
                  (x) => AuthorizationModel.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        invites: List<String>.from(
          (map['invites'] as List<String>),
        ),
        created: map['created'] as DateTime,
        modified: map['modified'] as DateTime,
        verified: map['countryCode'] as bool,
        profileDocId: map['profileDocId'] as String);
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(userId: $userId, name: $name, email: $email, photo: $photo, countryCode: $countryCode, homes: $homes, authorizations: $authorizations, invites: $invites, created: $created, modified: $modified, verified: $verified, profileDocId: $profileDocId)';
  }

  //** **************** */
  //** Kind of toMap and fromMap adapted to Firestore structure
  //** **************** */

  factory UserProfile.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    List<HomeModel>? homesList;
    List<AuthorizationModel>? authorizationsList;

    if (data?['homes'] != null) {
      homesList = [];
      data?['homes'].forEach((key, value) {
        homesList!
            .add(HomeModel.fromIndexAndMap(key, value as Map<String, dynamic>));
      });
    }
    if (data?['homes'] != null) {
      authorizationsList = [];
      data?['authorizations'].forEach((key, value) {
        authorizationsList!.add(
            AuthorizationModel.fromIndexAndMap(key, value as List<dynamic>));
      });
    }

    Timestamp auxCreated = data?['created'];
    Timestamp auxModified = data?['modified'];
    //print(data?['homes']);
    final userMapped = UserProfile(
      userId: data?['userId'],
      name: data?['name'],
      email: data?['email'],
      photo: data?['photo'],
      countryCode: data?['countryCode'],
      homes: homesList,
      authorizations: authorizationsList,
      invites: (data?['invites'] != null)
          ? (data?['invites'] is Iterable ? List.from(data?['invites']) : null)
          : null,
      created: DateTime.fromMicrosecondsSinceEpoch(
          auxCreated.millisecondsSinceEpoch),
      modified: DateTime.fromMicrosecondsSinceEpoch(
          auxModified.millisecondsSinceEpoch),
      verified: (data?['verified'] != null) ? data!['verified'] as bool : false,
      profileDocId: snapshot.id,
    );
    return userMapped;
  }

  Map<String, dynamic> toFirestore() {
    late Map<String, dynamic> homesToFirestore;
    late Map<String, dynamic> authorizationsToFirestore;
    if (homes != null) {
      homesToFirestore = {};
      for (var homeItem in homes!) {
        homesToFirestore.addAll(homeItem.toFirestore());
      }
    }
    if (authorizations != null) {
      authorizationsToFirestore = {};
      for (var authorizationItem in authorizations!) {
        authorizationsToFirestore.addAll(authorizationItem.toFirestore());
      }
    }
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'photo': photo,
      'countryCode': countryCode,
      'homes': homesToFirestore,
      'authorizations': authorizationsToFirestore,
      'invites': (invites != null) ? invites!.map((x) => x).toList() : null,
      'created': created,
      'modified': modified,
      'verified': verified,
    };
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.userId == userId &&
        other.name == name &&
        other.email == email &&
        other.photo == photo &&
        other.countryCode == countryCode &&
        listEquals(other.homes, homes) &&
        listEquals(other.authorizations, authorizations) &&
        listEquals(other.invites, invites) &&
        other.created == created &&
        other.modified == modified &&
        other.verified == verified;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        photo.hashCode ^
        countryCode.hashCode ^
        homes.hashCode ^
        authorizations.hashCode ^
        invites.hashCode ^
        created.hashCode ^
        modified.hashCode ^
        verified.hashCode;
  }

  factory UserProfile.getTestObject() {
    return UserProfile(
        userId: "0101010101",
        name: "User Test",
        email: "user@test.com",
        photo: "http://google.com",
        countryCode: "MX",
        invites: ["03030303", "04040404"],
        created: DateTime.now(),
        modified: DateTime.now(),
        verified: false);
  }
}
