import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/models/user_profile_model.dart';
import 'package:the_evox_app/providers/auth_provider.dart';
import 'package:the_evox_app/providers/device_provider.dart';
import 'package:the_evox_app/providers/user_provider.dart';
import 'package:the_evox_app/providers/wigdet_properties_provider.dart';
import 'package:the_evox_app/views/screens/screens.dart';

class UserSettings extends ConsumerStatefulWidget {
  const UserSettings({super.key});

  @override
  ConsumerState<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends ConsumerState<UserSettings> {
  @override
  Widget build(BuildContext context) {
    double roundness = ref.watch(roundnessProvider);
    ref.watch(isHomeLockedProvider);
    ref.watch(isHomeDisabledProvider);
    ref.watch(isEnergyOffProvider);
    final firebaseAuth = ref.watch(firebaseAuthProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 100),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: OutlinedButton(
                          style: ButtonStyle(
                              alignment: AlignmentDirectional.center,
                              backgroundColor: MaterialStateProperty.all(Colors.grey.shade700),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(color: Colors.grey)))),
                          onPressed: () => {},
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: OutlinedButton(
                          style: ButtonStyle(
                              alignment: AlignmentDirectional.center,
                              backgroundColor: MaterialStateProperty.all(Colors.grey.shade700),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(color: Colors.grey)))),
                          onPressed: () => {
                                firebaseAuth.signOut(),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Tours01()),
                                ),
                              },
                          child: const Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                Row(children: <Widget>[
                  CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipOval(
                              child: Image.asset(
                            "assets/icons/user_profile.png",
                          )))),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ref.watch(userNameProvider),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(ref.watch(userEmailProvider)),
                    ],
                  )
                ]),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Quick action',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                    Text('Manage',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.pinkAccent,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    child: SizedBox(
                      height: 120,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(isHomeLockedProvider.notifier).state =
                                    !ref.read(isHomeLockedProvider.notifier).state;
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 7.5, 0),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 0.0,
                                  color: ref.read(isHomeLockedProvider.notifier).state
                                      ? Colors.pinkAccent
                                      : Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(roundness)),
                                  ),
                                  child: SizedBox(
                                    height: 150.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          Icons.lock,
                                          color: ref.read(isHomeLockedProvider.notifier).state
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        Text('Lock home',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: ref.read(isHomeLockedProvider.notifier).state
                                                    ? Colors.white
                                                    : Colors.black)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(isHomeDisabledProvider.notifier).state =
                                    !ref.read(isHomeDisabledProvider.notifier).state;
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 0.0,
                                  color: ref.read(isHomeDisabledProvider.notifier).state
                                      ? Colors.pinkAccent
                                      : Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(roundness)),
                                  ),
                                  child: SizedBox(
                                    height: 150.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          Icons.mode_fan_off_outlined,
                                          color: ref.read(isHomeDisabledProvider.notifier).state
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        Text('Disable All',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: ref.read(isHomeDisabledProvider.notifier).state
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(isEnergyOffProvider.notifier).state =
                                    !ref.read(isEnergyOffProvider.notifier).state;
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 0.0,
                                  color: ref.read(isEnergyOffProvider.notifier).state
                                      ? Colors.pinkAccent
                                      : Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(roundness)),
                                  ),
                                  child: SizedBox(
                                    height: 150.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          Icons.flash_off_rounded,
                                          color: ref.read(isEnergyOffProvider.notifier).state
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        Text('Off energy',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: ref.read(isEnergyOffProvider.notifier).state
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 16,
                            child: Text('3', style: const TextStyle(color: Colors.white))),
                        SizedBox(width: 15),
                        Text('General',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0.0,
                        color: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(roundness)),
                        ),
                        child: SizedBox(
                          height: 100.0,
                          width: double.infinity,
                          child: InkWell(
                            customBorder: null,
                            borderRadius: BorderRadius.all(Radius.circular(roundness)),
                            highlightColor: Colors.pinkAccent,
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Expanded(flex: 1, child: SizedBox()),
                                const Expanded(
                                  flex: 2,
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                const Expanded(
                                  flex: 10,
                                  child: Text('Voice assistant',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black)),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                    flex: 2,
                                    child: Icon(Icons.arrow_forward_ios_rounded,
                                        color: Colors.grey.shade700)),
                                const Expanded(flex: 1, child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0.0,
                        color: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(roundness)),
                        ),
                        child: SizedBox(
                          height: 100.0,
                          width: double.infinity,
                          child: InkWell(
                            customBorder: null,
                            borderRadius: BorderRadius.all(Radius.circular(roundness)),
                            highlightColor: Colors.orangeAccent,
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Expanded(flex: 1, child: SizedBox()),
                                const Expanded(
                                  flex: 2,
                                  child: Icon(
                                    Icons.notifications,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                const Expanded(
                                  flex: 10,
                                  child: Text('Notification',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black)),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                    flex: 2,
                                    child: Icon(Icons.arrow_forward_ios_rounded,
                                        color: Colors.grey.shade700)),
                                const Expanded(flex: 1, child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0.0,
                        color: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(roundness)),
                        ),
                        child: SizedBox(
                          height: 100.0,
                          width: double.infinity,
                          child: InkWell(
                            customBorder: null,
                            borderRadius: BorderRadius.all(Radius.circular(roundness)),
                            highlightColor: Colors.cyan.shade700,
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                  flex: 2,
                                  child: Icon(
                                    Icons.question_mark_rounded,
                                    color: Colors.cyan.shade700,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                const Expanded(
                                  flex: 10,
                                  child: Text('FAQ & Feedback',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black)),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                    flex: 2,
                                    child: Icon(Icons.arrow_forward_ios_rounded,
                                        color: Colors.grey.shade700)),
                                const Expanded(flex: 1, child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
              onPressed: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Report(),
                  ),
                );
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Report()),
                );*/
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
              onPressed: () {},
              icon: Transform.scale(
                scaleX: -1,
                child: const Icon(
                  Icons.settings,
                  color: Colors.pink,
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
