//
// import 'package:demo/constants.dart';
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
//
//
// class HomePage extends StatelessWidget {
//   Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(Constants.logoutDialogTitle),
//           content: Text(Constants.logoutDialogMessage),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//               },
//               child: Text(Constants.noButtonText),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigate back to the login screen on logout
//                 Get.offAllNamed(Constants.loginRoute);
//               },
//               child: Text(Constants.yesButtonText),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: Text('Welcome to the Home Screen!'),
//       ),
//       // Add your logout button or any other content here
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Show the logout confirmation dialog
//           await _showLogoutConfirmationDialog(context);
//         },
//         child: Icon(Icons.logout),
//       ),
//     );
//   }
// }
