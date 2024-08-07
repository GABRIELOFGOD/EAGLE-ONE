import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class PhysicianCard extends StatelessWidget {
  const PhysicianCard({
    super.key,
    required this.image,
    required this.name,
    required this.practice,
    required this.role,
    required this.isSelected,
  });
  final String image;
  final String name;
  final String role;
  final String practice;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
          child: image == ""
              ? Image.asset(
                  "assets/icons/user.png",
                  width: 36,
                  height: 36,
                )
              : Image.network(image),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: Cros,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. $name",
                    style: TextStyle(
                      color: TColor.btnText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "$role at $practice",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              isSelected ? ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [TColor.textGrad, TColor.primary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ) : Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: TColor.primaryBg,
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
