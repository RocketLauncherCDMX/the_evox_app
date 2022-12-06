// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_evox_app/repositories/user_home_repository.dart';

import 'package:the_evox_app/repositories/user_profile_repository.dart';

import 'package:the_evox_app/models/authorization_model.dart';
import 'package:the_evox_app/models/device_model.dart';
import 'package:the_evox_app/models/home_model.dart';
import 'package:the_evox_app/models/room_model.dart';
import 'package:the_evox_app/models/user_profile_model.dart';

class TestingrepoScreen extends StatefulWidget {
  const TestingrepoScreen({Key? key}) : super(key: key);

  @override
  State<TestingrepoScreen> createState() => _TestingrepoScreenState();
}

class _TestingrepoScreenState extends State<TestingrepoScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserProfileRepository _profileRepository = UserProfileRepository();
  UserHomeRepository? _homeRepository;

  UserProfile? signedProfile;
  _TestingrepoScreenState() {
    signedProfile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RepoTesting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.blueGrey.shade50,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Center(
                  child: StreamBuilder<User?>(
                    stream: _firebaseAuth.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("...");
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        return const Text("Loggeado");
                      } else {
                        return const Text("No loggeado");
                      }
                    },
                  ),
                ),
              ),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                      child: Column(
                        children: [
                          /********** INSERT TEST **********/
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey.shade400)),
                                child: const Text("Inserting Test"),
                                onPressed: () async {
                                  /** Create not user-binded filled profile in db */
                                  if (await _profileRepository
                                          .createUserProfile(
                                              _createTestFilledProfile()) !=
                                      null) {
                                    print("PROFILE CREATED");
                                  } else {
                                    print(
                                        "ERROR: ${_profileRepository.errorMessage}");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          /********** INSERT TEST **********/
                          /********** EMAIL PASS **********/
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.lightGreen.shade300)),
                                child: const Text("Email SignUp"),
                                onPressed: () async {
                                  if (signedProfile == null) {
                                    /** If THERE ISNT a user profile object created
                               * then proceed to signin intend */
                                    try {
                                      /** Make sign up intend with email and password */
                                      UserCredential userSigned =
                                          await _firebaseAuth
                                              .createUserWithEmailAndPassword(
                                                  email:
                                                      'jorgegarcia@gmail.com',
                                                  password: "12345678");

                                      /** If no error throwned
                                 * get user info from credential */
                                      User? newUserInfo = userSigned.user;

                                      /** Create a test filled up object user profile
                                 * binded to user authenticated */
                                      UserProfile newUserProfile =
                                          _createTestFilledProfile(
                                              testName: newUserInfo!.displayName
                                                  .toString(),
                                              testAuthId: newUserInfo.uid);

                                      /** Create a user profile in DB from previous filledup
                                 * object and stores the ID of created db doc */
                                      newUserProfile.profileDocId =
                                          await _profileRepository
                                              .createUserProfile(
                                                  newUserProfile);
                                      if (_profileRepository.status) {
                                        /** If Status indicator is true means that profile
                                     * was successfully created and stores
                                     * the locally created profile in global var */
                                        signedProfile = newUserProfile;
                                        _homeRepository = UserHomeRepository(
                                            userProfileDocId:
                                                signedProfile!.profileDocId!);
                                      } else {
                                        print(_profileRepository.errorMessage);
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      print("error: ${e.message}");
                                    }
                                  } else {
                                    /** If THERE IS a user profile object then means that user was logged in */
                                    print("User is already logged!!");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.lightGreen.shade300)),
                                child: const Text("Email SignIn"),
                                onPressed: () async {
                                  if (signedProfile == null) {
                                    /** If THERE ISNT a user profile object created
                               * then proceed to signin intend */
                                    try {
                                      /** Perform login with email and password
                                 * expecting for user credential
                                 */
                                      UserCredential userSigned =
                                          await _firebaseAuth
                                              .signInWithEmailAndPassword(
                                                  email:
                                                      'jorgegarcia@gmail.com',
                                                  password: "12345678");

                                      /** Trying to retrive the profile from DB using
                                 * user authenticated ID */
                                      signedProfile = await _profileRepository
                                          .getUserProfileByAuthId(
                                              userSigned.user!.uid.toString());

                                      if (_profileRepository.status) {
                                        /** If retriving user profile from DB SUCCEEDS*/
                                        print(
                                            "User signed: ${signedProfile!.name}");
                                        print(signedProfile);
                                        _homeRepository = UserHomeRepository(
                                            userProfileDocId:
                                                signedProfile!.profileDocId!);
                                      } else {
                                        /** If retriving user profile from DB FAILS*/
                                        if (_profileRepository.errorCode ==
                                            404) {
                                          /** If no Exception throwned (just profile not found)
                                    * create one getting user info from credential */
                                          print(
                                              'USER WARNING: User profile no found in DB, starting profile creation');
                                          User? newUserInfo = userSigned.user;

                                          /** Create a test filled up object user profile
                                     * binded to user authenticated */
                                          UserProfile newUserProfile =
                                              _createTestFilledProfile(
                                                  testName: newUserInfo!
                                                      .displayName
                                                      .toString(),
                                                  testAuthId: newUserInfo.uid);

                                          /** Create a user profile in DB from previous filledup
                                     * object and stores the ID of created db doc */
                                          newUserProfile.profileDocId =
                                              await _profileRepository
                                                  .createUserProfile(
                                                      newUserProfile);
                                          if (_profileRepository.status) {
                                            /** If Status indicator is true means that profile
                                         * was successfully created and stores
                                         * the locally created profile in global var */
                                            print(
                                                "User profile created for: ${newUserProfile.name}");
                                            signedProfile = newUserProfile;
                                            _homeRepository =
                                                UserHomeRepository(
                                                    userProfileDocId:
                                                        signedProfile!
                                                            .profileDocId!);
                                          } else {
                                            print(_profileRepository
                                                .errorMessage);
                                          }
                                        } else {
                                          print(
                                              "ERROR USERPROFILEPROVIDER: ${_profileRepository.errorMessage}");
                                        }
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      print("AUTH ERROR: ${e.message}");
                                    }
                                  } else {
                                    /** If THERE IS a user profile object then means that user was logged in */
                                    print("User is already logged!!");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          /********** EMAIL PASS **********/
                          /********** USER PROFILE OPPERATIONS **********/
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.cyan.shade800)),
                                child: const Text("Update User"),
                                onPressed: () async {
                                  if (signedProfile != null) {
                                    DateTime previousUpdate =
                                        signedProfile!.modified!;
                                    try {
                                      signedProfile = await _profileRepository
                                          .updateUserProfile(signedProfile!);
                                      if (_profileRepository.status) {
                                        print(
                                            "User updated at: ${signedProfile!.modified.toString()}, previous update in: ${previousUpdate.toString()}");
                                      } else {
                                        print(
                                            "ERROR USERPROFILEPROVIDER:${_profileRepository.errorMessage}");
                                      }
                                    } on Exception catch (e) {
                                      print("Error: ${e.toString()}");
                                    }
                                  } else {
                                    print("Logged user not found");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.cyan.shade800)),
                                child: const Text("Delete profile"),
                                onPressed: () async {
                                  if (signedProfile != null) {
                                    try {
                                      if (await _profileRepository
                                          .deleteUserProfile(
                                              signedProfile!.profileDocId!)) {
                                        print(
                                            "User profile successfully deleted.");
                                        /**
                                         * ! Delete account from Auth DB before trigger logout
                                         */
                                        _firebaseAuth.signOut();
                                      } else {
                                        print(
                                            "ERROR USERPROFILEPROVIDER:${_profileRepository.errorMessage}");
                                      }
                                    } on Exception catch (e) {
                                      print("Error: ${e.toString()}");
                                    }
                                  } else {
                                    print("Logged user not found");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          /********** USER PROFILE OPERATIONS **********/
                          /********** GOOGLE **********/
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red.shade500)),
                                child: const Text("Google SignUp"),
                                onPressed: () async {
                                  try {
                                    // Trigger the authentication flow
                                    GoogleSignInAccount? googleUser =
                                        await GoogleSignIn().signIn();

                                    // Obtain the auth details from the request
                                    GoogleSignInAuthentication? googleAuth =
                                        await googleUser?.authentication;

                                    // Create a new credential
                                    var credential =
                                        GoogleAuthProvider.credential(
                                      accessToken: googleAuth?.accessToken,
                                      idToken: googleAuth?.idToken,
                                    );

                                    UserCredential newGoogleUser =
                                        await _firebaseAuth
                                            .signInWithCredential(credential);
                                  } on FirebaseAuthException catch (e) {
                                    print("error: ${e.message}");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red.shade500)),
                                child: const Text("Google SignIn"),
                                onPressed: () async {
                                  try {
                                    UserCredential userGoogleSigned =
                                        await _firebaseAuth
                                            .signInWithEmailAndPassword(
                                                email: 'jorgegarcia@gmail.com',
                                                password: "12345678");
                                  } on FirebaseAuthException catch (e) {
                                    print("error: ${e.message}");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          /********** GOOGLE **********/
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black)),
                                child: const Text("SignOut"),
                                onPressed: () {
                                  signedProfile = null;
                                  _homeRepository = null;
                                  _firebaseAuth.signOut();
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                        ],
                      ),
                    ),
                  ),
                  /** 
                   * ! ******************************************
                   * ! ********--------------------------********
                   * ! ********   HOME OPERATIONS   ********
                   * ! ********--------------------------********
                   * ! ******************************************
                   */
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                      child: Column(
                        children: [
                          /********** HOMES OPERATIONS **********/
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blueGrey.shade700)),
                                child: const Text("Add Home"),
                                onPressed: () async {
                                  if (signedProfile != null) {
                                    if (signedProfile!.homes == null) {
                                      signedProfile!.homes = [];
                                    }
                                    HomeModel newHome = HomeModel(
                                        homeId: getCustomUniqueId(),
                                        name: 'Beach House',
                                        location: {
                                          "address":
                                              "555 Oakroad, Winterforest",
                                          "coords": "19N 19W 19.19",
                                          "countryCode": "MX"
                                        },
                                        images: [
                                          "https://google.com",
                                          "https://google.com"
                                        ],
                                        rooms: null);

                                    try {
                                      await _homeRepository!
                                          .createHome(newHome);

                                      if (_homeRepository!.status) {
                                        signedProfile!.homes!.add(newHome);
                                        print(
                                            "Home added, current homes:${signedProfile!.homes!.length}");
                                      } else {
                                        print(_homeRepository!.errorMessage);
                                      }
                                    } on Exception catch (e) {
                                      print(e.toString());
                                    }
                                  } else {
                                    print("Logged user not found");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blueGrey.shade700)),
                                child: const Text("Update home n.2"),
                                onPressed: () async {
                                  if (signedProfile != null) {
                                    if (signedProfile!.homes != null) {
                                      if (signedProfile!.homes!.length >= 2) {
                                        HomeModel updatedHome = HomeModel(
                                            homeId:
                                                signedProfile!.homes![1].homeId,
                                            name: signedProfile!.homes![1].name,
                                            location: signedProfile!
                                                .homes![1].location,
                                            images: (List<String>.of(
                                                signedProfile!
                                                    .homes![1].images!)
                                              ..add("https://google.com")),
                                            rooms:
                                                signedProfile!.homes![1].rooms);
                                        try {
                                          await _homeRepository!.updateHome(
                                              signedProfile!.homes![1],
                                              updatedHome);

                                          if (_homeRepository!.status) {
                                            signedProfile!.homes![1] =
                                                updatedHome;
                                            print(
                                                "Home updated added 1 image, current qty:${signedProfile!.homes![1].images!.length}");
                                          } else {
                                            print(
                                                _homeRepository!.errorMessage);
                                          }
                                        } on Exception catch (e) {
                                          print(e.toString());
                                        }
                                      } else {
                                        print(
                                            "Too few homes, at least 2 needed to perform update on home n.2");
                                      }
                                    } else {
                                      print(
                                          "No homes found on this user, Add at least 2 to perform update on home n.2");
                                    }
                                  } else {
                                    print("Logged user not found");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          //BUTTON COMPONENT
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blueGrey.shade700)),
                                child: const Text("Delete last home"),
                                onPressed: () async {
                                  if (signedProfile != null) {
                                    if (signedProfile!.homes != null) {
                                      if (signedProfile!.homes!.isNotEmpty) {
                                        HomeModel home2Delete = signedProfile!
                                                .homes![
                                            (signedProfile!.homes!.length - 1)];
                                        try {
                                          await _homeRepository!
                                              .deleteHome(home2Delete);

                                          if (_homeRepository!.status) {
                                            signedProfile!.homes!
                                                .remove(home2Delete);
                                            print(
                                                "Home deleted, current homes:${signedProfile!.homes!.length}");
                                          } else {
                                            print(
                                                _homeRepository!.errorMessage);
                                          }
                                        } on Exception catch (e) {
                                          print(e.toString());
                                        }
                                      } else {
                                        print(
                                            "No homes found, Add at least 1 to perform delete");
                                      }
                                    } else {
                                      print(
                                          "No homes found on this user, Add at least 2 to perform update on home n.2");
                                    }
                                  } else {
                                    print("Logged user not found");
                                  }
                                },
                              ),
                            ),
                          ),
                          //END BUTTON COMPONENT
                          /********** HOMES OPERATIONS **********/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  UserProfile _createTestFilledProfile({
    String testName = "User Test",
    String testEmail = "user@test.com",
    String testAuthId = "0101010101",
  }) {
    var creationDt = DateTime.now();
    var userHomeRoomDevices = [
      DeviceModel(
          deviceId: "aa11aa11",
          name: "Main light",
          type: "Rgb Lamp",
          controller: {"parametro1": "valor1", "parametro2": "valor2"},
          powerMeasure: 100.0),
    ];
    var userHomeRooms = [
      RoomModel(
          roomId: "a1a1a1a1",
          name: "Living room",
          picture: "http://google.com/home1room1.jpg",
          powerUsage: 2535.0,
          devices: userHomeRoomDevices),
    ];
    var userHomes = [
      HomeModel(
          homeId: "AAAAAAAA",
          name: "Forest House",
          location: {
            "address": "555 Oakroad, Winterforest",
            "coords": "19N 19W 19.19",
            "countryCode": "MX"
          },
          images: [
            "http://google.com/home1.jpg",
            "http://google.com/home2.jpg"
          ],
          rooms: userHomeRooms),
    ];
    var userAuthorizations = [
      (AuthorizationModel(
          guestId: "02020202", homesAuthorized: ["AAAAAAAA", "BBBBBBBB"]))
    ];
    return UserProfile(
        userId: testAuthId,
        name: testName,
        email: testEmail,
        photo: "http://google.com",
        countryCode: "MX",
        authorizations: userAuthorizations,
        homes: userHomes,
        invites: ["03030303", "04040404"],
        created: creationDt,
        modified: creationDt,
        verified: false);
  }

  String getCustomUniqueId() {
    const String pushChars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    int lastPushTime = 0;
    List lastRandChars = [];
    int now = DateTime.now().millisecondsSinceEpoch;
    bool duplicateTime = (now == lastPushTime);
    lastPushTime = now;
    List timeStampChars = List<String>.filled(8, '0');
    for (int i = 7; i >= 0; i--) {
      timeStampChars[i] = pushChars[now % 62];
      now = (now / 62).floor();
    }
    String uniqueId = timeStampChars.join('');
    if (!duplicateTime) {
      for (int i = 0; i < 12; i++) {
        lastRandChars.add((Random().nextDouble() * 62).floor());
      }
    } else {
      int i = 0;
      for (int i = 11; i >= 0 && lastRandChars[i] == 61; i--) {
        lastRandChars[i] = 0;
      }
      lastRandChars[i]++;
    }
    for (int i = 0; i < 10; i++) {
      uniqueId += pushChars[lastRandChars[i]];
    }
    return uniqueId;
  }
}
