import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBackButton extends StatefulWidget {
  final VoidCallback onPressed;

  const CustomBackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
