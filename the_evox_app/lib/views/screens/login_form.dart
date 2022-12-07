import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/models/user_profile_model.dart';
import 'package:the_evox_app/providers/user_provider.dart';
import 'package:the_evox_app/views/screens/register_form.dart';
import 'package:the_evox_app/views/widgets/rounded_black_button.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  bool _obscureText = true;
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: signIn(context),
      ),
    );
  }

  Container signIn(BuildContext context) {
    return Container(
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
                      onPressed: () => {
                            Navigator.pop(context),
                          },
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
                  'Welcome back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            Form(
              key: _key,
              child: TextFormField(
                controller: _userEmail,
                validator: validateEmail,
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
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _userPassword,
              validator: validatePassword,
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.pinkAccent,
                  ),
                  child: const Text('Recovery password'),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            BlackButton(
              onPressed: () {},
              text: 'Login',
              width: 300,
            ),
            const SizedBox(height: 30),
            const Text('Or login with'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Consumer(builder: (context, ref, child) {
                    return ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade300),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)))),
                        child: Image.asset('assets/icons/goggle_logo.png'));
                  }),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ElevatedButton(
                      onPressed: () => {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)))),
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
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)))),
                      child: Image.asset('assets/icons/apple_logo.png')),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Dont have an account?'),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.pinkAccent,
                  ),
                  child: const Text('Register'),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterForm()),
                    ),
                  },
                )
              ],
            ),
          ],
        ));
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Email address is required.';
  }

  return null;
}

String? validatePassword(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Password is required.';
  }

  return null;
}
