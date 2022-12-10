import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_evox_app/views/screens/screens.dart';

class AddRooms extends StatefulWidget {
  const AddRooms({Key? key}) : super(key: key);

  @override
  State<AddRooms> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddRooms> {
  final _textController = TextEditingController();
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
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: const BorderSide(color: Colors.grey)))),
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
                    '4/4',
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Text(
                'Add rooms',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
              const SizedBox(width: 10.0),
              SizedBox(
                child: Image.asset(
                  'assets/icons/couch.png',
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
                        hintText: 'Room name',
                        suffixIcon: IconButton(
                            onPressed: () {
                              _textController.clear();
                            },
                            icon: const Icon(Icons.clear),
                            color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
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
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)))),
                onPressed: () => {
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const MyHome(),
                    ),
                  ),
                },
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      )),
    );
  }
}
