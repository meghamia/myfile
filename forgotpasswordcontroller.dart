// // forgot_password_controller.dart
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class ForgotPasswordController extends GetxController {
//   var emailController = TextEditingController();
//   var isLoading = false.obs;
//
//   Future<void> resetPassword() async {
//     try {
//       isLoading(true);
//
//       // Validate input field
//       if (emailController.text.isEmpty) {
//         Get.snackbar('Error', 'Email field is required',
//             snackPosition: SnackPosition.BOTTOM);
//         return;
//       }
//
//       // Send password reset email
//       await FirebaseAuth.instance.sendPasswordResetEmail(
//         email: emailController.text,
//       );
//
//       // Save the entered email to SharedPreferences
//       _saveEmailToSharedPreferences(emailController.text);
//
//       // Display success message
//       Get.snackbar('Success', 'Password reset email sent successfully',
//           snackPosition: SnackPosition.BOTTOM);
//
//       isLoading(false);
//     } catch (error) {
//       isLoading(false);
//       Get.snackbar('Error', error.toString(),
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   _saveEmailToSharedPreferences(String email) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('forgotPasswordEmail', email);
//   }
// }


// forgot_password_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController extends GetxController {
  var emailController = TextEditingController();
  var isLoading = false.obs;

  Future<void> resetPassword() async {
    try {
      isLoading(true);

      // Validate input field
      if (emailController.text.isEmpty) {
        Get.snackbar('Error', 'Email field is required',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // Send password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );

      // Save the entered email to SharedPreferences
      _saveEmailToSharedPreferences(emailController.text);

      // Display success message
      Get.snackbar('Success', 'Password reset email sent successfully',
          snackPosition: SnackPosition.BOTTOM);

      isLoading(false);
    } catch (error) {
      isLoading(false);
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  _saveEmailToSharedPreferences(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('forgotPasswordEmail', email);
  }
}
