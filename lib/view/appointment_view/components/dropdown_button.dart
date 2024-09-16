import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/model/practices.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<Service> items;
  // final ValueChanged<String?> onChanged;

  const CustomDropdownButton({
    super.key,
    required this.items,
    // required this.onChanged,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  Service? selectedValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMenu(
          context: context,
          position: const RelativeRect.fromLTRB(100, 100, 0, 0),
          items: widget.items
              .map((item) => PopupMenuItem(
                    value: item,
                    child: Text(item.serviceName),
                  ))
              .toList(),
        ).then((value) {
          if (value != null) {
            setState(() {
              selectedValue = value;
            });
            
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            selectedValue != null ? Text(
              selectedValue!.serviceName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: TColor.textGray,
              ),
            ) :
            Text(
              "Select a service",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: TColor.textGray,
              ),
            ),
            Icon(Icons.keyboard_arrow_down_sharp, color: TColor.inputGray),
          ],
        ),
      ),
    );
  }
}
