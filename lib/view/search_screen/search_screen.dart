import "package:flutter/material.dart";
import "package:youdoc/common/color_extention.dart";
import "package:youdoc/common/loader_overlay.dart";
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import "package:youdoc/common/custom_checkbox.dart";
import "package:youdoc/components/api_request.dart";
import "package:youdoc/model/practices.dart";
import "package:youdoc/view/search_screen/components/single_clinic_list.dart";
import 'dart:math' as math;
import 'package:geolocator/geolocator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  // final VoidCallback closeSearch;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Practice> clinicResult = [];
  bool isLoading = false;
  bool locationAllowed = false;

  double distance = 1;

  List tempSearchList = [];

  // Future<void> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Step 1: Check if location services are enabled
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   // Step 2: Check for location permissions
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // Step 3: Get user's current location
  //   Position userPosition = await Geolocator.getCurrentPosition();
  //   double userLat = userPosition.latitude;
  //   double userLon = userPosition.longitude;

  //   // Step 4: Haversine function to calculate the distance
  //   double calculateDistance(
  //       double lat1, double lon1, double lat2, double lon2) {
  //     const earthRadiusKm = 6371;

  //     double dLat = degToRad(lat2 - lat1);
  //     double dLon = degToRad(lon2 - lon1);

  //     double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
  //         math.cos(degToRad(lat1)) *
  //             math.cos(degToRad(lat2)) *
  //             math.sin(dLon / 2) *
  //             math.sin(dLon / 2);

  //     double c = 2 * math.asin(math.sqrt(a));
  //     return earthRadiusKm * c;
  //   }

  //   double degToRad(double deg) {
  //     return deg * (math.pi / 180);
  //   }

  //   // Step 5: Filter practices within the specified distance (distanceInKm)
  //   double distanceInKm =
  //       5; // Change to your desired distance or pass it as a parameter

  //   List<Practice> nearbyPractices = clinicResult.where((practice) {
  //     double distance = calculateDistance(
  //         userLat, userLon, practice.latitude, practice.longitude);
  //     return distance <= distanceInKm;
  //   }).toList();

  //   // Step 6: Update the UI with the filtered list
  //   setState(() {
  //     tempSearchList = nearbyPractices;
  //   });
  // }

  // void filterByDistance({double maxDistanceInKm = 10}) async {
  //   Position position = await _determinePosition();
  //   double userLatitude = position.latitude;
  //   double userLongitude = position.longitude;

  //   List<Practice> filteredClinics = clinicResult.where((clinic) {
  //     double distanceInMeters = Geolocator.distanceBetween(
  //       userLatitude,
  //       userLongitude,
  //       clinic.latitude,
  //       clinic.longitude,
  //     );
  //     double distanceInKm = distanceInMeters / 1000;
  //     return distanceInKm <= maxDistanceInKm;
  //   }).toList();

  //   setState(() {
  //     tempSearchList = filteredClinics;
  //   });
  // }

  // void gettingClinics() {
  //   setState(() {
  //     clinicResult = [
  //       Clinic(
  //         name: "Evercare Hospital",
  //         description:
  //             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  //       ),
  //       Clinic(
  //         name: "Gabriel Care",
  //         description:
  //             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  //       ),
  //       Clinic(
  //         name: "Evercare Hospital",
  //         description:
  //             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  //       ),
  //       Clinic(
  //         name: "Gabriel Care",
  //         description:
  //             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  //       ),
  //     ];
  //   });
  // }

  Future<void> gettingAllUsers() async {
    setState(() {
      isLoading = true;
    });

    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.getAllPractices();
      setState(() {
        clinicResult = response;
      });
    } catch (e, stackTrace) {
      if (mounted) {
        SnackBar snackBar = SnackBar(
          content: Text("Error: $e"),
          action: SnackBarAction(
            label: "Close",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void runFilter(String enteredKeyWord) {
    List<Practice> result = [];

    if (enteredKeyWord.isEmpty &&
        primary == false &&
        dental == false &&
        eye == false &&
        pharmacy == false &&
        sexual == false &&
        today == false &&
        week == false &&
        month == false) {
      setState(() {
        result = [];
      });
    } else {
      if (enteredKeyWord.isNotEmpty) {
        result = clinicResult
            .where((clinic) => clinic.practiceName
                .toLowerCase()
                .contains(enteredKeyWord.toLowerCase()))
            .toList();
      } else {
        List<Practice> tempResult = [];

        if (primary == true) {
          tempResult.addAll(clinicResult
              .where((clinic) => clinic.services
                  .any((service) => service.serviceName == "Primary care"))
              .toList());
        }

        if (eye == true) {
          tempResult.addAll(clinicResult
              .where((clinic) => clinic.services
                  .any((service) => service.serviceName == "Eye/Vision"))
              .toList());
        }

        if (dental == true) {
          tempResult.addAll(clinicResult
              .where((clinic) => clinic.services
                  .any((service) => service.serviceName == "Dental"))
              .toList());
        }

        if (pharmacy == true) {
          tempResult.addAll(clinicResult
              .where((clinic) => clinic.services
                  .any((service) => service.serviceName == "Pharmacy"))
              .toList());
        }

        if (sexual == true) {
          tempResult.addAll(clinicResult
              .where((clinic) => clinic.services
                  .any((service) => service.serviceName == "Sexual health"))
              .toList());
        }

        // if (today == true) {
        //   tempResult.addAll(clinicResult
        //       .where((clinic) => clinic.availability.toLowerCase() == "today")
        //       .toList());
        // }

        // if (week == true) {
        //   tempResult.addAll(clinicResult
        //       .where((clinic) => clinic.availability.toLowerCase() == "week")
        //       .toList());
        // }

        // if (month == true) {
        //   tempResult.addAll(clinicResult
        //       .where((clinic) => clinic.availability.toLowerCase() == "month")
        //       .toList());
        // }

        result = tempResult;
      }
    }

    setState(() {
      tempSearchList = result.toSet().toList();
    });
  }

  // void _showMessageDialog(
  //   String message,
  //   void closeFunction,
  //   String title,
  //   String sub,
  //   String closeText,
  //   Color btnColor,
  // ) {
  //   showDialog(
  //     context: context,
  //     barrierColor: Colors.black.withOpacity(0.5),
  //     builder: (context) {
  //       return CustomDialog(
  //           message: message,
  //           onClose: () => closeFunction,
  //           title: title,
  //           sub: sub,
  //           closeText: closeText,
  //           btnColor: btnColor);
  //     },
  //   );
  // }

  // ======== FILTER ======= //
  bool? primary = false;
  bool? dental = false;
  bool? eye = false;
  bool? pharmacy = false;
  bool? sexual = false;

// ========= AVAILABILITY =========== //
  bool? today = false;
  bool? week = false;
  bool? month = false;

  @override
  void initState() {
    super.initState();
    gettingAllUsers();
    isFiltered();
    // _determinePosition();
  }

  bool filtered = false;

  void isFiltered() {
    setState(() {
      filtered = (primary == true ||
          dental == true ||
          eye == true ||
          pharmacy == true ||
          sexual == true ||
          today == true ||
          week == true ||
          month == true);
    });
  }

  void updateFilter(String filterName, bool? value) {
    setState(() {
      switch (filterName) {
        case 'primary':
          primary = value;
          break;
        case 'dental':
          dental = value;
          break;
        case 'eye':
          eye = value;
          break;
        case 'pharmacy':
          pharmacy = value;
          break;
        case 'sexual':
          sexual = value;
          break;
        case 'today':
          today = value;
          break;
        case 'week':
          week = value;
          break;
        case 'month':
          month = value;
          break;
        default:
          break;
      }
      isFiltered();
    });
    runFilter("");
  }

  void clearFilter() {
    setState(() {
      primary = false;
      dental = false;
      eye = false;
      pharmacy = false;
      sexual = false;
      today = false;
      week = false;
      month = false;
      distance = 1;
      filtered = false;
    });
    runFilter("");
  }

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: TColor.primaryBg,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 42,
                  child: TextField(
                    controller: search,
                    onChanged: (value) => runFilter(value),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search for a practice or service",
                      prefixIcon: GestureDetector(
                        onTap: () {
                          if (search.text.isNotEmpty) {
                            setState(() {
                              search.text = "";
                              tempSearchList = [];
                            });
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        TColor.textGrad,
                        TColor.primary,
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: tempSearchList.isEmpty
                                  ? SizedBox(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icons/search_icon.png",
                                            width: 24,
                                            color: TColor.bottomBar,
                                          ),
                                          const SizedBox(
                                            width: 9,
                                          ),
                                          Text(
                                            "Search for a practice or medical service",
                                            style: TextStyle(
                                                color: TColor.bottomBar,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    )
                                  : ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight: 150,
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: tempSearchList.length,
                                          itemBuilder: (context, index) {
                                            final clinic =
                                                tempSearchList[index];
                                            return SingleSearchClinic(
                                              name: clinic.practiceName,
                                              image: clinic.practiceImage,
                                              id: clinic.id,
                                            );
                                          },
                                        ),
                                      ),
                                    )),
                          const SizedBox(
                            height: 48,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Services",
                                    style: TextStyle(
                                      color: TColor.inputGray,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "(select desired)",
                                    style: TextStyle(
                                      color: TColor.bottomBar,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                // spacing: 2.0,
                                // runSpacing: 4.0,
                                children: [
                                  CustomCheckbox(
                                    value: primary,
                                    change: (value) =>
                                        updateFilter('primary', value),
                                    text: "Primary care",
                                  ),
                                  CustomCheckbox(
                                    value: dental,
                                    change: (value) =>
                                        updateFilter('dental', value),
                                    text: "Dental",
                                  ),
                                  CustomCheckbox(
                                    value: eye,
                                    change: (value) =>
                                        updateFilter('eye', value),
                                    text: "Eye/vision",
                                  ),
                                  CustomCheckbox(
                                    value: pharmacy,
                                    change: (value) =>
                                        updateFilter('pharmacy', value),
                                    text: "Pharmacy",
                                  ),
                                  CustomCheckbox(
                                    value: sexual,
                                    change: (value) =>
                                        updateFilter('sexual', value),
                                    text: "Sexual health",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Distance in miles",
                                    style: TextStyle(
                                      color: TColor.inputGray,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "(select desired)",
                                    style: TextStyle(
                                      color: TColor.bottomBar,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Opacity(
                                opacity: locationAllowed ? 1.0 : 0.5,
                                child: IgnorePointer(
                                  ignoring: !locationAllowed,
                                  child: Column(
                                    children: [
                                      SliderTheme(
                                        data: SliderThemeData(
                                          trackHeight: 3,
                                          thumbColor: Colors.white,
                                          overlayShape:
                                              SliderComponentShape.noOverlay,
                                          overlayColor: Colors.transparent,
                                          activeTrackColor:
                                              null, // Defer to the default
                                          inactiveTrackColor:
                                              null, // Defer to the default
                                        ),
                                        child: ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            return LinearGradient(
                                              colors: [
                                                TColor.textGrad,
                                                TColor.primary
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ).createShader(bounds);
                                          },
                                          child: Slider(
                                            value: 5,
                                            min: 1,
                                            max: 10,
                                            divisions: 10,
                                            label: distance.round().toString(),
                                            onChanged: (double value) {
                                              setState(() {
                                                distance = value;
                                              });
                                            },
                                            activeColor: Colors.white,
                                            inactiveColor: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Availability",
                                    style: TextStyle(
                                      color: TColor.inputGray,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "(select desired)",
                                    style: TextStyle(
                                      color: TColor.bottomBar,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                // spacing: 2.0,
                                // runSpacing: 4.0,
                                children: [
                                  CustomCheckbox(
                                    value: today,
                                    change: (value) =>
                                        updateFilter('today', value),
                                    text: "Today",
                                  ),
                                  CustomCheckbox(
                                    value: week,
                                    change: (value) =>
                                        updateFilter('week', value),
                                    text: "This week",
                                  ),
                                  CustomCheckbox(
                                    value: month,
                                    change: (value) =>
                                        updateFilter('month', value),
                                    text: "This month",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: filtered
                                ? GestureDetector(
                                    onTap: clearFilter,
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.close,
                                          size: 14,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Clear filters",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        LoadingOverlay(isLoading: isLoading),
      ],
    );
  }
}
