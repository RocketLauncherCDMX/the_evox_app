import 'package:flutter/material.dart';
import 'package:the_evox_app/views/screens/screens.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _obscureText = true;
  bool _agreementIsChecked = false;
  final _userName = TextEditingController();
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                            enableInteractiveSelection: false,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: 'Full name',
                              //suffixIcon: const Icon(Icons.email_outlined),
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
                            enableInteractiveSelection: false,
                            autofocus: false,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: 'Email',
                              //suffixIcon: const Icon(Icons.email_outlined),
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
                                //suffixIcon: const Icon(Icons.lock_open),
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
                        /*if (_key.currentState!.validate()) {
                          if (_agreementIsChecked == false) {
                          } else {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _userEmail.text,
                                      password: _userPassword.text)
                                  .then((value) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AccountCreated()));
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'email-already-in-use') {
                                //print('User already taken');
                              }
                            }
                          }
                        }*/
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
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHome()));
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
                          Navigator.pushReplacementNamed(context, 'login'),
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
