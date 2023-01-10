import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:the_evox_app/views/screens/screens.dart';

class Automations extends StatefulWidget {
  const Automations({super.key});

  @override
  State<Automations> createState() => _AutomationsState();
}

class _AutomationsState extends State<Automations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Text('Automations',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 50),
          Text('Comming soon',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
              )),
        ],
      )),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: null,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const MainScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.home_rounded,
                color: Colors.black,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {},
              icon: const Icon(
                Icons.device_hub_rounded,
                color: Colors.pink,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Report(),
                  ),
                );
              },
              icon: Transform.scale(
                scaleX: -1,
                child: const Icon(
                  Icons.bar_chart,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                /*Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const UserSettings(),
                  ),
                );*/
              },
              icon: Transform.scale(
                scaleX: -1,
                child: const Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
