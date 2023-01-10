import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/providers/wigdet_properties_provider.dart';

class CustomBackButton extends ConsumerWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double roundness = ref.watch(squareButtonRoundnessProvider);
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(roundness),
            ))),
        onPressed: () => {
              Navigator.of(context).pop(),
            },
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ));
  }
}
