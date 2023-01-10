import 'package:flutter/material.dart';
import 'package:the_evox_app/lib/views/widgets/widgets.dart';
import 'package:the_evox_app/views/widgets/custom_back_button.dart';
import 'package:the_evox_app/views/widgets/rounded_black_button.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({Key? key}) : super(key: key);

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final _roomName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.topCenter,
                      image: AssetImage('assets/images/room_example.jpg'),
                    )),
                  ),
                  Transform.translate(
                      offset: const Offset(30, 30),
                      child: CustomBackButton(
                          onPressed: (() => Navigator.of(context).pop()))),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
                    child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _roomName,
                          //validator: validateEmail,
                          enableInteractiveSelection: false,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            hintText: 'Room name',
                            //suffixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        )),
                  ),
                  BlackButton(
                    onPressed: () => {},
                    text: 'Add room',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
