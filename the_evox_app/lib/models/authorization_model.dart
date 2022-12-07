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
          (map['homesAuthorized']),
        ));
  }

  String toJson() => json.encode(toMap());

  factory AuthorizationModel.fromJson(String source) =>
      AuthorizationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Authorization(guestId: $guestId, homesAuthorized: $homesAuthorized)';

  //** **************** */
  //** Kind of toMap and fromMap adapted to Firestore structure
  //** **************** */

  factory AuthorizationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data = snapshot.data();

    return data!.values.first.map<AuthorizationModel>(
      (x) => AuthorizationModel.fromIndexAndMap(
          data.keys.first, x as List<String>),
    );
    /*
    return AuthorizationModel(
      guestId: data?['guestId'],
      homesAuthorized: List.from(data?['homesAuthorized']),
    );*/
  }

  factory AuthorizationModel.fromIndexAndMap(String index, List<dynamic> map) {
    return AuthorizationModel(
      guestId: index,
      homesAuthorized: List<String>.from(map),
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      guestId: homesAuthorized,
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
