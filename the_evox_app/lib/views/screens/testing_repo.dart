// ignore_for_file: prefer_const_constructors, slash_for_doc_comments
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:the_evox_app/repositories/devices_repository.dart';
import 'package:the_evox_app/repositories/rooms_repository.dart';
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
  final DateFormat dateformatter = DateFormat('yMdHms');
  UserHomeRepository? _homesRepository;
  RoomsRepository? _roomsRepository;
  DevicesRepository? _devicesRepository;

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
                                onPressed: () => insertTestProfile(),
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
                                onPressed: () => emailSignUp(),
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
                                onPressed: () => emailSignIn(),
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
                                onPressed: () => updateProfile(),
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
                                onPressed: () => deleteProfile(),
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
                                onPressed: () => googleSignUp(),
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
                                onPressed: () => googleSignIn(),
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
                                onPressed: () => signOut(),
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
                          /********** HOMES BUTTONS **********/
                          //CREATE HOME BUTTON
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45,
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
                                onPressed: () => createHome(),
                              ),
                            ),
                          ),
                          //END CREATE HOME BUTTON
                          //UPDATE HOME BUTTON
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45,
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
                                child: const Text("Update Home n.2"),
                                onPressed: () => updateHome(),
                              ),
                            ),
                          ),
                          //END UPDATE HOME BUTTON
                          //DELETE HOME BUTTON
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45,
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
                                child: const Text("Delete last Home"),
                                onPressed: () => deleteHome(),
                              ),
                            ),
                          ),
                          //END DELETE HOME BUTTON
                          /********** HOMES BUTTONS **********/
                          /********** ROOMS BUTTONS **********/
                          //CREATE ROOM BUTTON
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45,
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
                                            Colors.blueGrey.shade600)),
                                child: const Text("Add Room to Home2"),
                                onPressed: () => createRoom(),
                              ),
                            ),
                          ),
                          //END CREATE ROOM BUTTON
                          //UPDATE ROOM BUTTON
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45,
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
                                            Colors.blueGrey.shade600)),
                                child: const Text("Update Room n.2"),
                                onPressed: () => updateRoom(),
                              ),
                            ),
                          ),
                          //END UPDATE ROOM BUTTON
                          //DELETE ROOM BUTTON
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45,
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
                                            Colors.blueGrey.shade600)),
                                child: const Text("Delete last Room"),
                                onPressed: () => deleteRoom(),
                              ),
                            ),
                          ),
                          //END DELETE ROOM BUTTON
                          /********** ROOMS BUTTONS **********/
                          /********** DEVICES BUTTONS **********/
                          //CREATE DEVICE BUTTON
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45,
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
                                            Colors.blueGrey.shade500)),
                                child: const Text("Add Device to Room2"),
                                onPressed: () => createDevice(),
                              ),
                            ),
                          ),
                          //END CREATE DEVICE BUTTON
                          //UPDATE DEVICE BUTTON
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45,
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
                                            Colors.blueGrey.shade500)),
                                child: const Text("Update Device n.2"),
                                onPressed: () => updateDevice(),
                              ),
                            ),
                          ),
                          //END UPDATE DEVICE BUTTON
                          //DELETE DEVICE BUTTON
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45,
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
                                            Colors.blueGrey.shade500)),
                                child: const Text("Delete last Device"),
                                onPressed: () => deleteDevice(),
                              ),
                            ),
                          ),
                          //END DELETE DEVICE BUTTON
                          /********** DEVICES BUTTONS **********/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: const <Widget>[
                  Text('Test name: Abhay'),
                  Text('Test Email: the_evox@gmail.com'),
                  Text('Test Password: 12345678'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /********** AUTH METHODS **********/
  void insertTestProfile() async {
    /** Create not user-binded filled profile in db */
    var tmpProfile = _createTestFilledProfile();
    if (await _profileRepository.createUserProfile(tmpProfile) != null) {
      print("PROFILE CREATED");
    } else {
      print("ERROR: ${_profileRepository.errorMessage}");
    }
  }

  void emailSignUp() async {
    if (signedProfile == null) {
      /** If THERE ISNT a user profile object created
       * then proceed to signin intend */
      try {
        /** Make sign up intend with email and password */
        UserCredential userSigned =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: 'garcamcoder@gmail.com', password: "12345678");

        /** If no error throwned
         * get user info from credential */
        User? newUserInfo = userSigned.user;

        /** Create a test filled up object user profile
         * binded to user authenticated */
        UserProfile newUserProfile = _createTestFilledProfile(
            testName: "George Garcam",
            testAuthId: newUserInfo!.uid,
            testEmail: newUserInfo.email.toString());

        /** Create a user profile in DB from previous filledup
         * object and stores the ID of created db doc */
        newUserProfile.profileDocId =
            await _profileRepository.createUserProfile(newUserProfile);
        if (_profileRepository.status) {
          /** If Status indicator is true means that profile
           * was successfully created and stores
           * the locally created profile in global var */
          signedProfile = newUserProfile;
          _homesRepository = UserHomeRepository(
              userProfileDocId: signedProfile!.profileDocId!);
          _roomsRepository =
              RoomsRepository(userProfileDocId: signedProfile!.profileDocId!);
          _devicesRepository =
              DevicesRepository(userProfileDocId: signedProfile!.profileDocId!);
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
  }

  void emailSignIn() async {
    if (signedProfile == null) {
      /** If THERE ISNT a user profile object created
                               * then proceed to signin intend */
      try {
        /** Perform login with email and password
                                 * expecting for user credential
                                 */
        UserCredential userSigned =
            await _firebaseAuth.signInWithEmailAndPassword(
                email: 'garcamcoder@gmail.com', password: "12345678");

        /** Trying to retrive the profile from DB using
                                 * user authenticated ID */
        signedProfile = await _profileRepository
            .getUserProfileByAuthId(userSigned.user!.uid.toString());

        if (_profileRepository.status) {
          /** If retriving user profile from DB SUCCEEDS*/
          print("User signed: ${signedProfile!.name}");
          print(signedProfile);
          _homesRepository = UserHomeRepository(
              userProfileDocId: signedProfile!.profileDocId!);
          _roomsRepository =
              RoomsRepository(userProfileDocId: signedProfile!.profileDocId!);
          _devicesRepository =
              DevicesRepository(userProfileDocId: signedProfile!.profileDocId!);
        } else {
          /** If retriving user profile from DB FAILS*/
          if (_profileRepository.errorCode == 404) {
            /** If no Exception throwned (just profile not found)
             * create one getting user info from credential */
            print(
                'USER WARNING: User profile no found in DB, starting profile creation');
            User? newUserInfo = userSigned.user;

            /** Create a test filled up object user profile
             * binded to user authenticated */
            UserProfile newUserProfile = _createTestFilledProfile(
              testName: newUserInfo!.displayName.toString(),
              testEmail: newUserInfo.email.toString(),
              testAuthId: newUserInfo.uid,
            );

            /** Create a user profile in DB from previous filledup
             * object and stores the ID of created db doc */
            newUserProfile.profileDocId =
                await _profileRepository.createUserProfile(newUserProfile);
            if (_profileRepository.status) {
              /** If Status indicator is true means that profile
               * was successfully created and stores
               * the locally created profile in global var */
              print("User profile created for: ${newUserProfile.name}");
              signedProfile = newUserProfile;
              _homesRepository = UserHomeRepository(
                  userProfileDocId: signedProfile!.profileDocId!);
              _roomsRepository = RoomsRepository(
                  userProfileDocId: signedProfile!.profileDocId!);
              _devicesRepository = DevicesRepository(
                  userProfileDocId: signedProfile!.profileDocId!);
            } else {
              print(_profileRepository.errorMessage);
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
  }

  void updateProfile() async {
    if (signedProfile != null) {
      DateTime previousUpdate = signedProfile!.modified!;
      try {
        signedProfile =
            await _profileRepository.updateUserProfile(signedProfile!);
        if (_profileRepository.status) {
          print(
              "User updated at: ${signedProfile!.modified.toString()}, previous update in: ${previousUpdate.toString()}");
        } else {
          print("ERROR USERPROFILEPROVIDER:${_profileRepository.errorMessage}");
        }
      } on Exception catch (e) {
        print("Error: ${e.toString()}");
      }
    } else {
      print("Logged user not found");
    }
  }

  void deleteProfile() async {
    if (signedProfile != null) {
      try {
        if (await _profileRepository
            .deleteUserProfile(signedProfile!.profileDocId!)) {
          print("User profile successfully deleted.");
          /**
           * ! Delete account from Auth DB before trigger logout */
          _firebaseAuth.signOut();
        } else {
          print("ERROR USERPROFILEPROVIDER:${_profileRepository.errorMessage}");
        }
      } on Exception catch (e) {
        print("Error: ${e.toString()}");
      }
    } else {
      print("Logged user not found");
    }
  }

  void googleSignUp() async {
    try {
      // Trigger the authentication flow
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential newGoogleUser =
          await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print("error: ${e.message}");
    }
  }

  void googleSignIn() async {
    try {
      UserCredential userGoogleSigned =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: 'jorgegarcia@gmail.com', password: "12345678");
    } on FirebaseAuthException catch (e) {
      print("error: ${e.message}");
    }
  }

  void signOut() {
    signedProfile = null;
    _homesRepository = null;
    _firebaseAuth.signOut();
  }
  /********** AUTH METHODS **********/

  /********** HOMES METHODS **********/
  void createHome() async {
    if (signedProfile != null) {
      if (signedProfile!.homes == null) {
        signedProfile!.homes = [];
      }
      HomeModel newHome = HomeModel(
          homeId: getCustomUniqueId(),
          name: 'Beach House',
          location: {
            "address": "555 Oakroad, Winterforest",
            "coords": "19N 19W 19.19",
            "countryCode": "MX"
          },
          images: ["https://google.com", "https://google.com"],
          rooms: null);

      try {
        await _homesRepository!.createHome(newHome);

        if (_homesRepository!.status) {
          signedProfile!.homes!.add(newHome);
          print("HOME added, current HOMES: ${signedProfile!.homes!.length}");
        } else {
          print(_homesRepository!.errorMessage);
        }
      } on Exception catch (e) {
        print(e.toString());
      }
    } else {
      print("Logged user not found");
    }
  }

  void updateHome() async {
    if (signedProfile != null) {
      if (signedProfile!.homes == null) {
        signedProfile!.homes = [];
      }
      if (signedProfile!.homes!.length >= 2) {
        HomeModel updatedHome = HomeModel(
            homeId: signedProfile!.homes![1].homeId,
            name: signedProfile!.homes![1].name,
            location: signedProfile!.homes![1].location,
            images: (List<String>.of(signedProfile!.homes![1].images!)
              ..add("https://google.com")),
            rooms: signedProfile!.homes![1].rooms);
        try {
          await _homesRepository!.updateHome(updatedHome);

          if (_homesRepository!.status) {
            signedProfile!.homes![1] = updatedHome;
            print(
                "Home updated added 1 image, current qty:${signedProfile!.homes![1].images!.length}");
          } else {
            print(_homesRepository!.errorMessage);
          }
        } on Exception catch (e) {
          print(e.toString());
        }
      } else {
        print(
            "Not enough HOMES, Add at least 2 HOMES to perform updateHome on HOME 2");
      }
    } else {
      print("Logged user not found");
    }
  }

  void deleteHome() async {
    if (signedProfile != null) {
      if (signedProfile!.homes == null) {
        signedProfile!.homes = [];
      }
      if (signedProfile!.homes!.isNotEmpty) {
        HomeModel home2Delete =
            signedProfile!.homes![(signedProfile!.homes!.length - 1)];
        try {
          await _homesRepository!.deleteHome(home2Delete.homeId);

          if (_homesRepository!.status) {
            signedProfile!.homes!.remove(home2Delete);
            print(
                "HOME deleted, current HOMES:${signedProfile!.homes!.length}");
          } else {
            print(_homesRepository!.errorMessage);
          }
        } on Exception catch (e) {
          print(e.toString());
        }
      } else {
        print("Not enough HOMES, Add at least 1 HOME to perform deleteRoom");
      }
    } else {
      print("Logged user not found");
    }
  }
  /********** HOMES METHODS **********/

  /********** ROOMS METHODS **********/
  void createRoom() async {
    if (signedProfile != null) {
      if (signedProfile!.homes == null) {
        signedProfile!.homes = [];
      }
      if (signedProfile!.homes!.length >= 2) {
        if (signedProfile!.homes![1].rooms == null) {
          signedProfile!.homes![1].rooms = [];
        }
        RoomModel newRoom = RoomModel(
          roomId: getCustomUniqueId(),
          type: 'bedroom',
          name: 'My room ${dateformatter.format(DateTime.now())}',
          picture: 'https://google.com',
          powerUsage: 20.1,
          devices: null,
        );

        try {
          await _roomsRepository!.createRoom(
            newRoom,
            signedProfile!.homes![1].homeId,
          );

          if (_roomsRepository!.status) {
            signedProfile!.homes![1].rooms!.add(newRoom);
            print(
                "ROOM added to HOME 2, current ROOMS:${signedProfile!.homes![1].rooms!.length}");
          } else {
            print(_roomsRepository!.errorMessage);
          }
        } on Exception catch (e) {
          print(e.toString());
        }
      } else {
        print(
            "Not enough HOMES, Add at least 2 to perform createDevice on HOME 2");
      }
    } else {
      print("Logged user not found");
    }
  }

  void updateRoom() async {
    if (signedProfile != null) {
      if (signedProfile!.homes == null) {
        signedProfile!.homes = [];
      }
      if (signedProfile!.homes!.length >= 2) {
        if (signedProfile!.homes![1].rooms == null) {
          signedProfile!.homes![1].rooms = [];
        }
        if (signedProfile!.homes![1].rooms!.length >= 2) {
          final currentRoom = signedProfile!.homes![1].rooms![1];
          RoomModel updatedRoom = RoomModel(
            roomId: getCustomUniqueId(),
            type: currentRoom.type,
            name: currentRoom.name,
            picture:
                'https://google.com/${dateformatter.format(DateTime.now())}',
            powerUsage: currentRoom.powerUsage,
            devices: currentRoom.devices,
          );
          try {
            await _roomsRepository!.updateRoom(
              updatedRoom,
              signedProfile!.homes![1].homeId,
            );

            if (_roomsRepository!.status) {
              signedProfile!.homes![1].rooms![1] = updatedRoom;
              print(
                  "Room updated picture changed, last image: ${currentRoom.picture}, new image: ${updatedRoom.picture}");
            } else {
              print(_homesRepository!.errorMessage);
            }
          } on Exception catch (e) {
            print(e.toString());
          }
        } else {
          print(
              "To few ROOMS, Add at least 2 ROOMS to perform updateRoom on ROOM 2");
        }
      } else {
        print(
            "Not enough HOMES, Add at least 2 HOMES and 2 ROOMS to perform updateRoom on ROOM 2");
      }
    } else {
      print("Logged user not found");
    }
  }

  void deleteRoom() async {
    if (signedProfile != null) {
      if (signedProfile!.homes == null) {
        signedProfile!.homes = [];
      }
      if (signedProfile!.homes!.length >= 2) {
        if (signedProfile!.homes![1].rooms == null) {
          signedProfile!.homes![1].rooms = [];
        }
        if (signedProfile!.homes![1].rooms!.isNotEmpty) {
          RoomModel room2Delete = signedProfile!.homes![1].rooms!.last;
          try {
            await _roomsRepository!.deleteRoom(
                room2Delete.roomId, signedProfile!.homes![1].homeId);

            if (_roomsRepository!.status) {
              signedProfile!.homes![1].rooms!.remove(room2Delete);
              print(
                  "ROOM deleted from HOME 2, current ROOMS:${signedProfile!.homes![1].rooms!.length}");
            } else {
              print(_homesRepository!.errorMessage);
            }
          } on Exception catch (e) {
            print(e.toString());
          }
        } else {
          print("Not enough ROOMS, Add at least 1 ROOM to perform deleteRoom");
        }
      } else {
        print(
            "Not enough HOMES, Add at least 2 HOMES and 1 ROOM to perform deleteRoom");
      }
    } else {
      print("Logged user not found");
    }
  }
  /********** ROOMS METHODS **********/

  /********** DEVICES METHODS **********/
  void createDevice() async {
    if (signedProfile != null) {
      if (signedProfile!.homes == null) {
        signedProfile!.homes = [];
      }
      if (signedProfile!.homes!.length >= 2) {
        if (signedProfile!.homes![1].rooms == null) {
          signedProfile!.homes![1].rooms = [];
        }
        if (signedProfile!.homes![1].rooms!.length >= 2) {
          if (signedProfile!.homes![1].rooms![1].devices == null) {
            signedProfile!.homes![1].rooms![1].devices = [];
          }
          DeviceModel newDevice = DeviceModel(
            deviceId: getCustomUniqueId(),
            name: 'My device ${dateformatter.format(DateTime.now())}',
            type: 'enlightment',
            controller: {
              'param1': 'val1',
              'param2': 'val2',
              'param3': 'val3',
            },
            powerMeasure: 200.0,
          );

          try {
            await _devicesRepository!.createDevice(
              newDevice,
              signedProfile!.homes![1].homeId,
              signedProfile!.homes![1].rooms![1].roomId,
            );

            if (_roomsRepository!.status) {
              signedProfile!.homes![1].rooms![1].devices!.add(newDevice);
              print(
                  "DEVICE added to ROOM 2, current DEVICES:${signedProfile!.homes![1].rooms![1].devices!.length}");
            } else {
              print(_roomsRepository!.errorMessage);
            }
          } on Exception catch (e) {
            print(e.toString());
          }
        } else {
          print(
              "Not enough ROOMS in HOME 2, Add at least 2 to perform createDevice on ROOM 2");
        }
      } else {
        print(
            "Not enough HOMES, Add at least 2 then add 2 ROOMS to perform createDevice on ROOM 2 in HOME 2");
      }
    } else {
      print("Logged user not found");
    }
  }

  void updateDevice() async {
    if (signedProfile != null) {
      if (signedProfile!.homes == null) {
        signedProfile!.homes = [];
      }
      if (signedProfile!.homes!.length >= 2) {
        if (signedProfile!.homes![1].rooms == null) {
          signedProfile!.homes![1].rooms = [];
        }
        if (signedProfile!.homes![1].rooms!.length >= 2) {
          if (signedProfile!.homes![1].rooms![1].devices == null) {
            signedProfile!.homes![1].rooms![1].devices = [];
          }
          if (signedProfile!.homes![1].rooms![1].devices!.length >= 2) {
            final currentDevice =
                signedProfile!.homes![1].rooms![1].devices![1];
            DeviceModel updatedDevice = DeviceModel(
              deviceId: getCustomUniqueId(),
              name: currentDevice.name,
              type: currentDevice.type,
              controller: currentDevice.controller,
              powerMeasure: currentDevice.powerMeasure + 10.1,
            );
            try {
              await _devicesRepository!.updateDevice(
                updatedDevice,
                signedProfile!.homes![1].homeId,
                signedProfile!.homes![1].rooms![1].roomId,
              );

              if (_devicesRepository!.status) {
                signedProfile!.homes![1].rooms![1].devices![1] = updatedDevice;
                print(
                    "DEVICE updated, last power measure: ${currentDevice.powerMeasure}, new: ${updatedDevice.powerMeasure}");
              } else {
                print(_devicesRepository!.errorMessage);
              }
            } on Exception catch (e) {
              print(e.toString());
            }
          } else {
            print(
                "Too few DEVICES, at least 2 needed to perform update on DEVICE 2");
          }
        } else {
          print(
              "Not enough ROOMS, Add at least 2 ROOMS then 2 DEVICES to perform updateDevice on DEVICE 2");
        }
      } else {
        print(
            "Not enough HOMES, Add at least 2 HOMES, 2 ROOMS and 2 DEVICES to perform updateDevice on DEVICE 2");
      }
    } else {
      print("Logged user not found");
    }
  }

  void deleteDevice() async {
    if (signedProfile != null) {
      if (signedProfile!.homes == null) {
        signedProfile!.homes = [];
      }
      if (signedProfile!.homes!.length >= 2) {
        if (signedProfile!.homes![1].rooms == null) {
          signedProfile!.homes![1].rooms = [];
        }
        if (signedProfile!.homes![1].rooms!.length >= 2) {
          if (signedProfile!.homes![1].rooms![1].devices == null) {
            signedProfile!.homes![1].rooms![1].devices = [];
          }
          if (signedProfile!.homes![1].rooms![1].devices!.isNotEmpty) {
            DeviceModel device2Delete =
                signedProfile!.homes![1].rooms![1].devices!.last;
            try {
              await _devicesRepository!.deleteDevice(
                  device2Delete.deviceId,
                  signedProfile!.homes![1].homeId,
                  signedProfile!.homes![1].rooms![1].roomId);

              if (_devicesRepository!.status) {
                signedProfile!.homes![1].rooms![1].devices!
                    .remove(device2Delete);
                print(
                    "1 DEVICE deleted from ROOM 2, current DEVICES:${signedProfile!.homes![1].rooms![1].devices!.length}");
              } else {
                print(_homesRepository!.errorMessage);
              }
            } on Exception catch (e) {
              print(e.toString());
            }
          } else {
            print(
                "Not enough DEVICES, Add at least 1 DEVICE to perform deleteDevice");
          }
        } else {
          print(
              "Not enough ROOMS, Add at least 2 ROOMS and 1 DEVICE to perform deleteDevice");
        }
      } else {
        print(
            "Not enough HOMES, Add at least 2 HOMES, 2 ROOMS and 1 DEVICE to perform deleteDevice");
      }
    } else {
      print("Logged user not found");
    }
  }
  /********** DEVICES METHODS **********/

  UserProfile _createTestFilledProfile({
    String testName = "Abhay",
    String testEmail = "the_evox@test.com",
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
          type: "living",
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
        verified: true);
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
