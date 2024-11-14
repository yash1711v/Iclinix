import 'package:flutter/material.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/styles.dart';

class CustomRadioButton extends StatelessWidget {
  final List<String> items; // List of patient names
  final String selectedValue; // Currently selected value
  final Function(String?) onChanged; // Function to call when selection changes

  const CustomRadioButton({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        bool isSelected = selectedValue == item; // Check if the item is selected
        return GestureDetector(
          onTap: () => onChanged(item), // Update the selected value when tapped
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio<String>(
                value: item,
                groupValue: selectedValue,
                onChanged: (value) => onChanged(value),
                activeColor: Theme.of(context).primaryColor, // Color of selected radio button
              ),
              const SizedBox(width: 8.0), // Space between radio and text
              Expanded(
                child: Text(
                  item,
                  style: openSansSemiBold.copyWith(fontSize: Dimensions.fontSize14,
                  color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}




class SingleCustomRadioButton extends StatelessWidget {
  final String value; // The value for this radio button
  final String groupValue; // The currently selected value
  final Function(String?) onChanged; // Function to call when selection changes

  const SingleCustomRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value), // Update the selected value when tapped
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: (val) => onChanged(val), // Trigger the change
            activeColor: Theme.of(context).primaryColor, // Color of selected radio button
          ),
          const SizedBox(width: 8.0), // Space between radio and text
          Expanded(
            child: Text(
              '+ Add New',
              style: openSansSemiBold.copyWith(
                fontSize: Dimensions.fontSize14,
                color: Theme.of(context).disabledColor, // Text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
