import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_evox_app/models/authorization_model.dart';
import 'package:the_evox_app/models/device_model.dart';
import 'package:the_evox_app/models/home_model.dart';
import 'package:the_evox_app/models/room_model.dart';
import 'package:the_evox_app/models/user_profile_model.dart';
import 'package:the_evox_app/repositories/auth_provider_repository.dart';
import 'package:the_evox_app/providers/user_provider.dart';
import 'package:the_evox_app/repositories/user_home_repository.dart';
import 'package:the_evox_app/views/screens/screens.dart';
import 'package:the_evox_app/views/widgets/alert_dialog_ok.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterScreen> {
  bool _obscureText = true;
  bool _agreementIsChecked = false;
  final _userName = TextEditingController();
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final profileRepository = ref.watch(userProfileRepositoryProvider);
    var signedProfile = ref.watch(userStateProvider);
    var homeRepository = ref.watch(homeRepositoryProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: const BorderSide(
                                            color: Colors.grey)))),
                            onPressed: () =>
                                {Navigator.of(context).pop(const Tours03())},
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Let\'s get started',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                  ),
                  Form(
                      key: _key,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _userName,
                            validator: _validateName,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.name,
                            enableInteractiveSelection: false,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: 'Full name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _userEmail,
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            enableInteractiveSelection: false,
                            autofocus: false,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _userPassword,
                            validator: _validatePassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            enableInteractiveSelection: false,
                            autofocus: false,
                            obscureText: _obscureText,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                )),
                          )
                        ],
                      )),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          //fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: _agreementIsChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _agreementIsChecked = value!;
                            });
                          },
                        ),
                        const Text('I agree'),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.pinkAccent,
                          ),
                          child: const Text('Privacy Policy'),
                          onPressed: () {},
                        ),
                        const Text('and'),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.pinkAccent,
                          ),
                          child: const Text('User agreement'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 250,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)))),
                      onPressed: () async {
                        if (_agreementIsChecked == true) {
                          ref.read(userNameProvider.notifier).state =
                              _userName.text;
                          ref.read(userEmailProvider.notifier).state =
                              _userEmail.text;

                          if (signedProfile == null) {
                            /** If THERE ISNT a user profile object created
                                 * then proceed to signin intend */
                            try {
                              /** Make sign up intend with email and password */
                              UserCredential userSigned = await firebaseAuth
                                  .createUserWithEmailAndPassword(
                                      email: ref.read(userEmailProvider),
                                      password: _userPassword.text);
                              print(ref.read(userNameProvider));
                              print(ref.read(userEmailProvider));

                              /** If no error throwned
                                   * get user info from credential */
                              User? newUserInfo = userSigned.user;

                              /** Create a test filled up object user profile
                                   * binded to user authenticated */
                              UserProfile newUserProfile =
                                  _createTestFilledProfile(
                                      testName:
                                          newUserInfo!.displayName.toString(),
                                      testAuthId: newUserInfo.uid);

                              newUserProfile.email = _userEmail.text;
                              newUserProfile.name = _userName.text;

                              /** Create a user profile in DB from previous filledup
                                   * object and stores the ID of created db doc */
                              newUserProfile.profileDocId =
                                  await profileRepository
                                      .createUserProfile(newUserProfile);
                              if (profileRepository.status) {
                                /** If Status indicator is true means that profile
                                       * was successfully created and stores
                                       * the locally created profile in global var */
                                signedProfile = newUserProfile;
                                homeRepository = UserHomeRepository(
                                    userProfileDocId:
                                        signedProfile!.profileDocId!);
                              } else {
                                print(profileRepository.errorMessage);
                              }
                            } on FirebaseAuthException catch (e) {
                              print("error: ${e.message}");
                            }
                          } else {
                            /** If THERE IS a user profile object then means that user was logged in */
                            print("User is already logged!!");
                          }

                          //ref.watch(isUserSignedProvider.notifier).state
                        } else {
                          showAlertDialog(context,
                              'Please, read and accept the privacy policy and user agreement first');
                        }
                        if (!mounted) return;
                      },
                      child: const Text('Register'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Or register with'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: ElevatedButton(
                            onPressed: () async {
                              try {
                                // Trigger the authentication flow
                                GoogleSignInAccount? googleUser =
                                    await GoogleSignIn().signIn();

                                // Obtain the auth details from the request
                                GoogleSignInAuthentication? googleAuth =
                                    await googleUser?.authentication;

                                // Create a new credential
                                var credential = GoogleAuthProvider.credential(
                                  accessToken: googleAuth?.accessToken,
                                  idToken: googleAuth?.idToken,
                                );

                                UserCredential newGoogleUser =
                                    await firebaseAuth
                                        .signInWithCredential(credential);
                                print('UserCrendetial: $credential');

                                /** Create a user profile in DB from previous filledup
                                 * object and stores the ID of created db doc */
                                signedProfile?.profileDocId =
                                    await profileRepository
                                        .createUserProfile(signedProfile!);
                                if (profileRepository.status) {
                                  /** If Status indicator is true means that profile
                               * was successfully created and stores
                               * the locally created profile in global var */
                                  signedProfile = signedProfile;
                                  homeRepository = UserHomeRepository(
                                      userProfileDocId:
                                          signedProfile!.profileDocId!);
                                } else {
                                  print(profileRepository.errorMessage);
                                }
                              } on FirebaseAuthException catch (e) {
                                print("error: ${e.message}");
                              }

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen()));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey.shade300),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)))),
                            child: Image.asset('assets/icons/goggle_logo.png')),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: ElevatedButton(
                            onPressed: () => {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue.shade700),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)))),
                            child: Image.asset(
                              'assets/icons/fb_logo.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.scaleDown,
                            )),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: ElevatedButton(
                            onPressed: () => {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)))),
                            child: Image.asset('assets/icons/apple_logo.png')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Already have an account?'),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.pinkAccent,
                        ),
                        child: const Text('Login'),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          ),
                        },
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

String? _validateName(String? formName) {
  if (formName == null || formName.isEmpty) {
    return 'Name is required.';
  }

  return null;
}

String? _validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Email address is required.';
  }

  if (!formEmail.contains('@') || !formEmail.contains('.')) {
    return 'Email format incorrect.';
  }

  return null;
}

String? _validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required';
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return 'Minimum 8 chars, uppercase, number and symbol.';
  }

  return null;
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
        devices: userHomeRoomDevices,
        type: ''),
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
        images: ["http://google.com/home1.jpg", "http://google.com/home2.jpg"],
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
