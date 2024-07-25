// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:youdoc/view/on_boarding/on_boarding_view.dart';

// class LogoutScreen extends StatelessWidget {
//   const LogoutScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: MaterialButton(
//           onPressed: () async {
//             SharedPreferences preferences = await SharedPreferences.getInstance();
//             preferences.remove("token");
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => OnBoardingView(),
//               ),
//             );
//           },
//           child: Text(
//             "Logout",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/view/on_boarding/on_boarding_view.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();

            // Remove the token
            bool isRemoved = await preferences.remove("token");

            // Print the result of removal operation
            print("Token removed: $isRemoved");

            // Navigate only if the token is removed
            if (isRemoved) {
              // Reset the initialRoute to OnBoardingView
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => OnBoardingView(),
                ),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: Text(
            "Logout",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
