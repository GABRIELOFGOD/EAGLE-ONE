import 'package:flutter/material.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/loader_overlay.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/components/practices.dart';

class SinglePracticeView extends StatefulWidget {
  const SinglePracticeView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<SinglePracticeView> createState() => _SinglePracticeViewState();
}

class _SinglePracticeViewState extends State<SinglePracticeView> {
  bool isLoading = false;
  Practice? practice;
  // = Practice(
  //   id: 0,
  //   practiceEmail: "",
  //   practiceAboutText: "",
  //   practiceAddress: "",
  //   practiceImage: "",
  //   practiceName: "",
  //   specialty: "",
  // );

  // dynamic pract

  Future<void> getSinglePractice() async {
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var practicer = await baseRequest.getPractice(widget.id);
      setState(() {
        practice = practicer;
      });
    } catch (e) {
      _showMessageDialog(
        "Failed to load, please check your internet connection and try again",
        () {
          Navigator.pop(context);
        },
        "Error",
        "Something went wrong",
        "Go back",
        Colors.red,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSinglePractice();
  }

  void _showMessageDialog(
    String message,
    void closeFunction,
    String title,
    String sub,
    String closeText,
    Color btnColor,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return CustomDialog(
            message: message,
            onClose: () => closeFunction,
            title: title,
            sub: sub,
            closeText: closeText,
            btnColor: btnColor);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryBg,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            size: 12,
            color: TColor.btnText,
          ),
        ),
        title: Text(
          "Practice information",
          style: TextStyle(
            color: TColor.btnText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: TColor.primaryBg,
      ),
      body: practice == null
          ? Center(
              child: CircularProgressIndicator(
                color: TColor.primary,
              ),
            )
          : Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: TColor.btnBg,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: practice!.practiceImage == ""
                            ? Image.asset(
                                "assets/images/practice_logo_big.png",
                                width: 27,
                                height: 27,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(practice!.practiceImage),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            practice!.practiceName,
                            style: TextStyle(
                              color: TColor.btnText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: TColor.btnBg,
                                  border: Border.all(
                                      width: 1.0, color: TColor.inactiveBtn),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.bookmark_border,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: TColor.btnBg,
                                  border: Border.all(
                                      width: 1.0, color: TColor.inactiveBtn),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.phone_in_talk_outlined,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Contact",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About practice",
                        style: TextStyle(
                            color: TColor.textGray,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        practice!.practiceAboutText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/bank.png",
                            width: 18,
                            color: TColor.inputGray,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Services offered",
                            style: TextStyle(
                              color: TColor.inputGray,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      // Wrap(
                      //   children: [],
                      // )
                      Wrap(
                        children: practice == null
                            ? [
                                Center(
                                  child: CircularProgressIndicator(
                                    color: TColor.primary,
                                  ),
                                )
                              ]
                            : practice!.services.map((service) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: TColor.btnBg,
                                  ),
                                  child: Text(
                                    service.serviceName,
                                    style: TextStyle(
                                      color: TColor.btnText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/location.png",
                                width: 18,
                                color: TColor.inputGray,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                  color: TColor.inputGray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Text(
                                practice!.practiceAddress,
                                style: TextStyle(
                                  color: TColor.btnText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomAnchor(
                                text: "Open in Google Map",
                                clicked: () {},
                                myFontSize: 14.0,
                                textColor: TColor.primary,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/location.png",
                                width: 18,
                                color: TColor.inputGray,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Operation hours",
                                style: TextStyle(
                                  color: TColor.inputGray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    practice!.userOpeningTimes[0].openingTime,
                                    style: TextStyle(
                                      color: TColor.btnText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    " - ",
                                    style: TextStyle(
                                      color: TColor.btnText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    practice!.userOpeningTimes[0].closingTime,
                                    style: TextStyle(
                                      color: TColor.btnText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Mon-Sun",
                                style: TextStyle(
                                  color: TColor.btnText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/user.png",
                                width: 18,
                                color: TColor.inputGray,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Lead physician",
                                style: TextStyle(
                                  color: TColor.inputGray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Text(
                                practice!.practiceAddress,
                                style: TextStyle(
                                  color: TColor.btnText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomAnchor(
                                text: "Open in Google Map",
                                clicked: () {},
                                myFontSize: 14.0,
                                textColor: TColor.primary,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  LoadingOverlay(isLoading: isLoading),
                ],
              ),
            ),
    );
  }
}
