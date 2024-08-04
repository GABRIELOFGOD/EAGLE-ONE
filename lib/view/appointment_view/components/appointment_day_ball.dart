import "package:flutter/material.dart";
import "package:youdoc/common/color_extention.dart";
import "package:youdoc/view/appointment_view/components/border_painter.dart";

class AppointmentBall extends StatefulWidget {
  const AppointmentBall({
    super.key,
    required this.day,
    required this.isActive,
    required this.isSelected,
  });

  final String day;
  final bool isActive;
  final bool isSelected;

  @override
  State<AppointmentBall> createState() => _AppointmentBallState();
}

class _AppointmentBallState extends State<AppointmentBall> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 36,
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
        child: Container(
          decoration: BoxDecoration(
            color: TColor.btnBg,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              widget.day,
              style: TextStyle(
                color: widget.isActive ? TColor.btnText : TColor.inactiveBtn,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
