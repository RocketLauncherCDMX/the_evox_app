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
                      image: NetworkImage(
                          'https://www.decorilla.com/online-decorating/wp-content/uploads/2022/03/black-and-white-luxury-kitchen-design.jpg'),
                    )),
                  ),
                  Transform.translate(
                      offset: const Offset(30, 30),
                      child: CustomBackButton(onPressed: (() => Navigator.of(context).pop()))),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Room name',
                          ),
                          style: TextStyle(fontSize: 22.0, height: 2.0, color: Colors.black)),
                    ),
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
