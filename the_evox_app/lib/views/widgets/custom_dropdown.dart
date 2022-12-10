import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  const CustomDropdown(
      {Key? key, required this.modelList, required this.model, required this.callback})
      : super(key: key);
  final List<T?> modelList;
  final T? model;
  final Function(T?) callback;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? labour;

  @override
  void initState() {
    labour = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.modelList);
    return Container(
      child: DropdownButton<T>(
        underline: const SizedBox(),
        elevation: 0,
        isDense: true,
        hint: const Text("Select "),
        value: labour,
        items: widget.modelList.map((T? value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
        onChanged: (val) {
          widget.callback(val);
          setState(() {
            labour = val;
          });
        },
      ),
    );
  }
}




/*
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _HomePageState();
}

class _HomePageState extends State<DropDown> {
  // define a list of options for the dropdown
  final List<String> _animals = ["Dog", "Cat", "Crocodile", "Dragon"];

  // the selected value
  String? _selectedAnimal;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        width: 200,
        decoration:
            BoxDecoration(color: Colors.pink.shade200, borderRadius: BorderRadius.circular(20)),
        child: DropdownButton<String>(
          value: _selectedAnimal,
          onChanged: (value) {
            setState(() {
              _selectedAnimal = value;
            });
          },

          hint: const Center(
              child: Text(
            'Add new house',
            style: TextStyle(color: Colors.white),
          )),
          // Hide the default underline
          underline: Container(),
          // set the color of the dropdown menu
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          isExpanded: true,

          // The list of options
          items: _animals
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ))
              .toList(),

          // Customize the selected item
          selectedItemBuilder: (BuildContext context) => _animals
              .map((e) => Center(
                    child: Text(
                      e,
                      style: const TextStyle(
                          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}*/