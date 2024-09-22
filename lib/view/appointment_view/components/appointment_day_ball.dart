import "package:flutter/material.dart";
import "package:youdoc/common/color_extention.dart";
import "package:youdoc/view/appointment_view/components/border_painter.dart";

class AppointmentBall extends StatefulWidget {
  const AppointmentBall({
    super.key,
    required this.formattedDate,
    required this.isActive,
    required this.isSelected,
    this.pad,
    this.padd,
  });

  final String formattedDate;
  final bool isActive;
  final bool isSelected;
  final double? pad;
  final double? padd;

  @override
  State<AppointmentBall> createState() => _AppointmentBallState();
}

class _AppointmentBallState extends State<AppointmentBall> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      // width: 36,
      child: CustomPaint(
        painter: GradientBorderPainter(
          strokeWidth: 2.0,
          radius: 100.0,
          gradient: widget.isSelected
              ? LinearGradient(
                  colors: [
                    TColor.textGrad,
                    TColor.primary,
                  ],
                )
              : LinearGradient(
                  colors: [
                    TColor.primaryBg,
                    TColor.primaryBg,
                  ],
                ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.pad ?? 0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: widget.padd ?? 0),
            decoration: BoxDecoration(
              color: TColor.btnBg,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                widget.formattedDate,
                style: TextStyle(
                  color: widget.isActive ? TColor.btnText : TColor.inactiveBtn,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import "package:flutter/material.dart";
// import "package:youdoc/common/color_extention.dart";
// import "package:youdoc/view/appointment_view/components/border_painter.dart";

// class AppointmentBall extends StatefulWidget {
//   const AppointmentBall({
//     super.key,
//     required this.formattedDate, // Update to accept formattedDate
//     required this.isActive,
//     required this.isSelected,
//   });

//   final String formattedDate; // Update the field name
//   final bool isActive;
//   final bool isSelected;

//   @override
//   State<AppointmentBall> createState() => _AppointmentBallState();
// }

// class _AppointmentBallState extends State<AppointmentBall> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//           horizontal: 8), // Add padding to fit content
//       height: 36, // Maintain the height
//       width: double.infinity,
//       child: CustomPaint(
//         painter: GradientBorderPainter(
//           strokeWidth: 2.0,
//           radius: 100.0,
//           gradient: widget.isSelected
//               ? LinearGradient(
//                   colors: [
//                     TColor.textGrad,
//                     TColor.primary,
//                   ],
//                 )
//               : LinearGradient(
//                   colors: [
//                     TColor.primaryBg,
//                     TColor.primaryBg,
//                   ],
//                 ),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             color: TColor.btnBg,
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: Center(
//             child: Text(
//               widget.formattedDate, // Use the formatted date
//               style: TextStyle(
//                 color: widget.isActive ? TColor.btnText : TColor.inactiveBtn,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
