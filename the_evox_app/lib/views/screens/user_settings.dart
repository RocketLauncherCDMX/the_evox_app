import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/repositories/auth_provider_repository.dart';
import 'package:the_evox_app/providers/home_provider.dart';
import 'package:the_evox_app/providers/user_provider.dart';
import 'package:the_evox_app/providers/wigdet_properties_provider.dart';
import 'package:the_evox_app/views/screens/screens.dart';
import 'package:the_evox_app/views/screens/user_add_room.dart';
import 'package:the_evox_app/views/widgets/room_card.dart';

// ignore: must_be_immutable
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MyHomeState();
}

class _MyHomeState extends ConsumerState<MainScreen> {
  //final _actualVal = 'Add Home';
  // ignore: prefer_final_fields
  int _rooms = 1;
  final String _name = '';
  final String _place = 'Mexico city';
  //var _temperature = 187;
  final _tempDouble = 22.3;
  final _activeDevices = 4;
  final _powerUsage = 0.0;
  // ignore: unused_field
  final _bottomNavIcon = 1;

  @override
  Widget build(BuildContext context) {
    var myHomes = ref.watch(homesProvider);
    var signedUser = ref.watch(userStateProvider);

    double roundness = ref.watch(roundnessProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserSettings()),
                        );*/
                      },
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/user_image.png'),
                        backgroundColor: Colors.transparent,
                        radius: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                          child: Text('Homes DropDown'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 50,
                      height: 55,
                      child: SizedBox(
                        child: OutlinedButton(
                            style: ButtonStyle(
                                alignment: AlignmentDirectional.center,
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey.shade700),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: const BorderSide(
                                            color: Colors.grey)))),
                            onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SetupHome()),
                                  ),
                                },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello ${ref.watch(userNameProvider)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22.0),
                ),
                const SizedBox(width: 10.0),
                Image.asset(
                  'assets/icons/greet.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Welcome to your home',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 5, 20),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0.0,
                      color: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(roundness)),
                      ),
                      child: SizedBox(
                        height: 150.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            const Icon(
                              Icons.cloud,
                              color: Colors.white,
                            ),
                            Text(_tempDouble.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.white)),
                            const Text('°C',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    color: Colors.white)),
                            Text(_place,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.white)),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0.0,
                      color: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(roundness)),
                      ),
                      child: SizedBox(
                        height: 150.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const SizedBox(height: 5),
                            const Icon(
                              Icons.settings_rounded,
                              color: Colors.white,
                            ),
                            const Text('0',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.white)),
                            Column(
                              children: const <Widget>[
                                Text('Active',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.white)),
                                Text('devices',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.white)),
                                SizedBox(height: 10),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 20, 20),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0.0,
                      color: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(roundness)),
                      ),
                      child: SizedBox(
                        height: 150.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            const Icon(
                              Icons.electric_bolt,
                              color: Colors.white,
                            ),
                            Text(_powerUsage.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.white)),
                            const Text('mW/h',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    color: Colors.white)),
                            const Text('Usage',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.white)),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: Colors.grey.shade700,
                          radius: 16,
                          child: Text(_rooms.toString(),
                              style: const TextStyle(color: Colors.white))),
                      const SizedBox(width: 15),
                      const Text('Rooms',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black)),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () => {},
                          child: Text(
                            _rooms == 0 ? 'Add room' : 'See all',
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddRoom()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(20, 20),
                            shape: const CircleBorder(),
                            elevation: 0,
                          ),
                          child: const Text(
                            '+',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
              child: _rooms == 0 ? noRoomsWidget() : createRoomCard(),
              //child: noRoomsWidget(),
            ),
          ],
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
              onPressed: () {},
              icon: const Icon(
                Icons.home_rounded,
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

noRoomsWidget() {
  return SizedBox(
    child: Column(
      children: <Widget>[
        const SizedBox(height: 15),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 10,
                  color: Colors.black12,
                  spreadRadius: 5)
            ],
          ),
          child: CircleAvatar(
              backgroundColor: Colors.pink.shade200,
              radius: 42,
              child: const Text('!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold))),
        ),
        const SizedBox(height: 15),
        const Text('No rooms',
            style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const Text('You haven\'t added a room. You need to add',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.normal)),
        const Text('rooms first by clicking "Add room".',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.normal)),
        const SizedBox(height: 100)
      ],
    ),
  );
}
