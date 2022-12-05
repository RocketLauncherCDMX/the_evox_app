import 'package:flutter/material.dart';
import 'package:the_evox_app/views/screens/screens.dart';

class AccountCreated extends StatelessWidget {
  const AccountCreated({super.key});
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
                'assets/images/account_created.png',
                fit: BoxFit.contain,
                alignment: Alignment.topRight,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Hurray!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your account is now',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'registered',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
                ),
                const SizedBox(width: 10.0),
                Image.asset(
                  'assets/icons/party.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: const Text(
                'Congratulations, you are now registered. Do you want to set up your home first?',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink.shade300),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)))),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectCountry()),
                  ),
                },
                child: const Text('Setup home'),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('No, I want to'),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.pinkAccent,
                  ),
                  child: const Text('Start exploring'),
                  onPressed: () {},
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ));
}
