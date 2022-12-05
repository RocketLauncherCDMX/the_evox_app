import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlackButton extends StatefulWidget {
  final String text;
  double width;
  double height;
  final VoidCallback onPressed;

  BlackButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.width = 200,
      this.height = 60})
      : super(key: key);
  @override
  State<BlackButton> createState() => _BlackButtonState();
}

class _BlackButtonState extends State<BlackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
