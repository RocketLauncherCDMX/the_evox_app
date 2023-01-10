import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_evox_app/views/screens/setup_home_04.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeAddress extends StatefulWidget {
  const HomeAddress({Key? key}) : super(key: key);

  @override
  State<HomeAddress> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeAddress> {
  final _textController = TextEditingController();
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                            onPressed: () => {Navigator.pop(context)},
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(
                      '3/4',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Home address',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32.0),
                    ),
                    const SizedBox(width: 10.0),
                    SizedBox(
                      child: Image.asset(
                        'assets/icons/pin.png',
                        width: 30,
                        height: 30,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 60.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: TextField(
                        controller: _textController,
                        enableInteractiveSelection: false,
                        autofocus: false,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: 'Saint claire Street #26',
                          suffixIcon: IconButton(
                              onPressed: () {
                                _textController.clear();
                              },
                              icon: const Icon(Icons.clear),
                              color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox(width: 10.0)),
                    SizedBox(
                      height: 60.0,
                      width: 60,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.my_location,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                ),
              ),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)))),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddRooms()),
                    ),
                  },
                  child: const Text('Next'),
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        )));
  }
}
