import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final List<String> items;
  const DropDown({Key? key, required this.items}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DropDownState();
  }
}

class _DropDownState extends State<DropDown> {

  var selectedDropDownValue = "Header";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedDropDownValue,
        items: widget.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: onDropDownChanged);
  }

  void onDropDownChanged(newValue) {
    setState(() {
      selectedDropDownValue = newValue!;
    });
    print("Value:$newValue");
  }
}
