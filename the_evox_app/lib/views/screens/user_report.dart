import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:the_evox_app/views/screens/screens.dart';
import 'package:the_evox_app/views/screens/testing_repo.dart';
import 'package:the_evox_app/views/widgets/rounded_black_button.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('Report Comming soon',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 50),
          const Text('Go to Data base testing',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
              )),
          const SizedBox(height: 50),
          BlackButton(
            onPressed: () => {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const TestingrepoScreen(),
                ),
              ),
            },
            text: 'DataBase testing',
          ),
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
              onPressed: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Automations(),
                  ),
                );
              },
              icon: const Icon(
                Icons.device_hub_rounded,
                color: Colors.black,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {},
              icon: Transform.scale(
                scaleX: -1,
                child: const Icon(
                  Icons.bar_chart,
                  color: Colors.pink,
                  size: 35,
                ),
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const UserSettings(),
                  ),
                );
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
