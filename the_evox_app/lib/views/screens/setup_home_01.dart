import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_evox_app/providers/home_provider.dart';
import 'package:the_evox_app/providers/user_provider.dart';
import 'package:the_evox_app/views/screens/screens.dart';
import 'package:the_evox_app/views/widgets/alert_dialog_ok.dart';

class SetupHome extends ConsumerStatefulWidget {
  const SetupHome({Key? key}) : super(key: key);

  @override
  ConsumerState<SetupHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<SetupHome> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                                      borderRadius: BorderRadius.circular(15.0),
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
                    '1/4',
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
                  'Your home name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
                ),
                const SizedBox(width: 10.0),
                Image.asset(
                  'assets/icons/house.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Center(
              child: Text(
                  'Choose a nickname for this home to help identify it later.',
                  style: TextStyle(
                    fontSize: 16.0,
                  )),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 60.0,
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  controller: _textController,
                  enableInteractiveSelection: true,
                  autofocus: false,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'House nickname',
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
            ),
            const Expanded(
              child: SizedBox(),
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
                  _textController.text.isEmpty
                      ? showAlertDialog(
                          context, 'You need to name the house to continue')
                      : ref.read(homesProvider.notifier).newHomeName =
                          _textController.text,
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectCountry()),
                  ),*/
                },
                child: const Text('Next'),
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      )),
    );
  }
}
