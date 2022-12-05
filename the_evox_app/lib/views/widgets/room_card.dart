import 'package:flutter/material.dart';
import 'package:the_evox_app/models/room_model.dart';

createRoomCard(RoomModel room) {
  return Row(
    children: <Widget>[
      SizedBox(
        height: 300,
        width: 200,
        child: Column(children: <Widget>[
          Expanded(
            flex: 3,
            child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                child: SizedBox(
                    child: Image.network(
                  room.picture,
                  fit: BoxFit.cover,
                ))),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.grey.shade200,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 5),
                      const Icon(Icons.chair),
                      const SizedBox(height: 5),
                      Text(room.name),
                      const SizedBox(height: 5),
                      Row(
                        children: const <Widget>[
                          Expanded(
                            flex: 3,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text('Devices'),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text('On'),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ]),
      )
    ],
  );
}
