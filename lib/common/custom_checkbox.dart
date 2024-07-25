// import 'package:flutter/material.dart';
// import 'package:youdoc/common/color_extention.dart';

// class CustomCheckbox extends StatefulWidget {
//   const CustomCheckbox({
//     super.key,
//     required this.value,
//     required this.change,
//     required this.text,
//     this.primaryColor,
//   });

//   final bool? value;
//   final ValueChanged<bool?> change;
//   final Color? primaryColor;
//   final String text;

//   @override
//   State<CustomCheckbox> createState() => _CustomCheckboxState();
// }

// class _CustomCheckboxState extends State<CustomCheckbox> {
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: GestureDetector(
//         onTap: () => widget.change(!widget.value!),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Checkbox(
//               value: widget.value,
//               activeColor: widget.primaryColor ?? TColor.primary,
//               onChanged: widget.change,
//             ),
//             const SizedBox(
//               width: 0,
//             ),
//             Flexible(
//               child: Text(
//                 widget.text,
//                 style: TextStyle(
//                   color: TColor.btnText,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.change,
    required this.text,
    this.primaryColor,
  });

  final bool? value;
  final ValueChanged<bool?> change;
  final Color? primaryColor;
  final String text;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.change(!widget.value!),
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: widget.value,
              activeColor: widget.primaryColor ?? TColor.primary,
              onChanged: widget.change,
            ),
            const SizedBox(
              width: 0,
            ),
            Text(
              widget.text,
              style: TextStyle(
                color: TColor.btnText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
