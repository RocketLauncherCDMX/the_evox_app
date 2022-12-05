// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class AuthorizationModel {
  final String guestId;
  final List<String> homesAuthorized;
  AuthorizationModel({
    required this.guestId,
    required this.homesAuthorized,
  });

  AuthorizationModel copyWith({
    String? guestId,
    List<String>? homesAuthorized,
  }) {
    return AuthorizationModel(
      guestId: guestId ?? this.guestId,
      homesAuthorized: homesAuthorized ?? this.homesAuthorized,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'guestId': guestId,
      'homesAuthorized': homesAuthorized,
    };
  }

  factory AuthorizationModel.fromMap(Map<String, dynamic> map) {
    return AuthorizationModel(
        guestId: map['guestId'] as String,
        homesAuthorized: List<String>.from(
          (map['homesAuthorized'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory AuthorizationModel.fromJson(String source) =>
      AuthorizationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Authorization(guestId: $guestId, homesAuthorized: $homesAuthorized)';

  factory AuthorizationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AuthorizationModel(
      guestId: data?['guestId'],
      homesAuthorized: List.from(data?['homesAuthorized']),
    );
  }

  //*! **************** */
  //*! Probably not necesary because of Firestore db.add() accepts .toMap results
  //*! **************** */
  Map<String, dynamic> toFirestoreMap() {
    return <String, dynamic>{
      'guestId': guestId,
      'homesAuthorized': homesAuthorized,
    };
  }

  @override
  bool operator ==(covariant AuthorizationModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.guestId == guestId &&
        listEquals(other.homesAuthorized, homesAuthorized);
  }

  @override
  int get hashCode => guestId.hashCode ^ homesAuthorized.hashCode;
}
