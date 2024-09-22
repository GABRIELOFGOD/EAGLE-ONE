import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/view/practice/single_practice_view.dart';

class SingleSearchClinic extends StatefulWidget {
  const SingleSearchClinic({
    super.key,
    required this.name,
    required this.image,
    required this.id,
  });
  final String name;
  final String image;
  final int id;

  @override
  State<SingleSearchClinic> createState() => _SingleSearchClinicState();
}

class _SingleSearchClinicState extends State<SingleSearchClinic> {
  void viewPractice() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SinglePracticeView(id: widget.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewPractice,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 18.0,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // widget.image == ""
                //     ? 
                    Image.asset("assets/images/practice_logo.png"),
                    // : ClipRRect(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     child: Image.network(
                    //       widget.image,
                    //       width: 24.0,
                    //       height: 24.0,
                    //     )),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: TColor.btnBg,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    weight: 10,
                    size: 12,
                    color: TColor.inputGray,
                  ),
                  const SizedBox(
                    width: 5.2,
                  ),
                  Text(
                    "Practice info",
                    style: TextStyle(
                      color: TColor.btnText,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
