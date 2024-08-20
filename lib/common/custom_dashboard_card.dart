import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class CustomCard extends StatefulWidget {
  const CustomCard(
      {super.key,
      required this.carIcon,
      required this.cardName,
      required this.value});

  final Widget carIcon;
  final String cardName;
  final dynamic value;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: TColor.cardBg,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 12),
        child: SizedBox(
          height: 90,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: TColor.inputBg,
                    ),
                    child: widget.carIcon,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.cardName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              // const SizedBox(
              //   height: 40,
              // ),
              Text(
                widget.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
