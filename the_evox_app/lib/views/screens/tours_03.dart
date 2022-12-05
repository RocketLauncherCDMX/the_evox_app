import 'package:flutter/material.dart';
import 'package:the_evox_app/views/screens/login_form.dart';
import 'package:the_evox_app/views/widgets/rounded_black_button.dart';

class Tours03 extends StatelessWidget {
  const Tours03({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 110,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(50, 60, 0, 0),
              child: Image.asset(
                'assets/images/logo_01.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Image.asset(
                'assets/images/tours_living_03.png',
                fit: BoxFit.contain,
                alignment: Alignment.topRight,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
              child: const Text(
                'Functionality',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Smarter life with',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const Text(
              'smart device',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 15.0,
                    height: 3.0,
                    color: Colors.black12,
                  ),
                  const SizedBox(width: 5.0),
                  Container(
                    width: 15.0,
                    height: 3.0,
                    color: Colors.black12,
                  ),
                  const SizedBox(width: 5.0),
                  Container(
                    width: 40.0,
                    height: 3.0,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            BlackButton(
                onPressed: () => {
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const LoginForm(),
                        ),
                      ),
                    },
                text: 'Login'),
            const SizedBox(height: 10.0),
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
                    Navigator.pushReplacementNamed(context, 'register'),
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ));
}
