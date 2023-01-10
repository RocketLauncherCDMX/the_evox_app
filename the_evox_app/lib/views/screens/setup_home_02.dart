import 'dart:async';

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_evox_app/providers/home_provider.dart';
import 'package:the_evox_app/views/screens/setup_home_03.dart';

class SelectCountry extends ConsumerStatefulWidget {
  const SelectCountry({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectCountry> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<SelectCountry> {
  TextEditingController countryController = TextEditingController();
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
                    '2/4',
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
            const SizedBox(
              child: Text(
                'Select your country',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: "Press to search",
                  hintText: "Country",

                  // prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              readOnly: true,
              onTap: () {
                showCountryPicker(
                  context: context,
                  onSelect: (Country country) {
                    ref.read(homesProvider.notifier).newHomecountryCode =
                        country.countryCode.toString();
                    print(country.countryCode.toString());
                  },
                  // Optional. Sets the theme for the country list picker.
                  countryListTheme: CountryListThemeData(
                    // Optional. Sets the border radius for the bottomsheet.
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    // Optional. Styles the search field.
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Start typing to search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                        ),
                      ),
                    ),
                    // Optional. Styles the text in the search field
                    searchTextStyle: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                );
              },
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeAddress()),
                  ),
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
