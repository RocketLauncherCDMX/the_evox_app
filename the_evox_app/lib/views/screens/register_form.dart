import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/models/user_profile_model.dart';
import 'package:the_evox_app/providers/user_provider.dart';
import 'package:the_evox_app/repositories/user_home_repository.dart';
import 'package:the_evox_app/views/screens/screens.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  bool _obscureText = true;
  bool _agreementIsChecked = false;
  final _userName = TextEditingController();
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = ref.watch(FirebaseAuthProvider);
    final profileRepository = ref.watch(UserProfileRepositoryProvider);
    var homeRepository = ref.watch(UserHomeRepositoryProvider);
    UserProfile? signedProfile = null;

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
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        side: const BorderSide(color: Colors.grey)))),
                            onPressed: () => {Navigator.of(context).pop(const Tours03())},
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                            enableInteractiveSelection: false,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: 'Full name',
                              //suffixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _userEmail,
                            validator: _validateEmail,
                            enableInteractiveSelection: false,
                            autofocus: false,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: 'Email',
                              //suffixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _userPassword,
                            validator: _validatePassword,
                            enableInteractiveSelection: false,
                            autofocus: false,
                            obscureText: _obscureText,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: 'Password',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                //suffixIcon: const Icon(Icons.lock_open),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _obscureText ? Icons.visibility_off : Icons.visibility,
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
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)))),
                      onPressed: () async {
                        if (signedProfile == null) {
                          /** If THERE ISNT a user profile object created
                               * then proceed to signin intend */
                          try {
                            /** Make sign up intend with email and password */
                            UserCredential userSigned =
                                await firebaseAuth.createUserWithEmailAndPassword(
                                    email: 'jorgegarcia@gmail.com', password: "12345678");

                            /** If no error throwned
                                 * get user info from credential */
                            User? newUserInfo = userSigned.user;
                            print(newUserInfo);

                            /** Create a user profile in DB from previous filledup
                                 * object and stores the ID of created db doc */
                            signedProfile!.profileDocId =
                                await profileRepository.createUserProfile(signedProfile!);
                            if (profileRepository.status) {
                              /** If Status indicator is true means that profile
                                     * was successfully created and stores
                                     * the locally created profile in global var */
                              homeRepository =
                                  UserHomeRepository(userProfileDocId: signedProfile.profileDocId!);
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
                              //FireBaseAuthAPI().signIn();
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => const MyHome()));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.grey.shade300),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0)))),
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
                                    MaterialStateProperty.all<Color>(Colors.blue.shade700),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0)))),
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
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0)))),
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
                            MaterialPageRoute(builder: (context) => const LoginForm()),
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

  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return 'Minimum 8 chars, uppercase, number and symbol.';
  }

  return null;
}
