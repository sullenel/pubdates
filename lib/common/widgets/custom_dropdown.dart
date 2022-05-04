import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    this.selectedValue,
    this.items,
    this.onChanged,
  }) : super(key: key);

  final T? selectedValue;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        onChanged: onChanged,
        value: selectedValue,
        focusColor: Colors.transparent,
        alignment: Alignment.centerRight,
        // The default one is ugly af
        icon: const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Icon(Icons.keyboard_arrow_down),
        ),
        iconSize: 20,
        items: items,
      ),
    );
  }
}
