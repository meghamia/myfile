// import 'package:flutter/material.dart';
//
//
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../constants.dart';
// import '../screens/home_page.dart';
//
//
// class SignupController extends GetxController {
//   final key1= GlobalKey<FormState>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   var isLoading = false;
//
//   Future<void> signUp() async {
//     try {
//       isLoading=true;
//
//       // Validate input fields
//       // if (nameController.text.isEmpty ||
//       //     emailController.text.isEmpty ||
//       //     passwordController.text.isEmpty) {
//       //   Get.snackbar('Error', 'All fields are required',
//       //       snackPosition: SnackPosition.BOTTOM);
//       //   return;
//       // }
//
//       // Create user in Firebase Authentication
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//           email: emailController.text, password: passwordController.text);
//
//       // Store user information in Firestore
//       await FirebaseFirestore.instance
//           .collection(Constants.usersCollection)
//           .doc(userCredential.user!.uid)
//           .set({
//         'name': nameController.text,
//         'email': emailController.text,
//         // Add other fields if needed
//       });
//
//
//
//       // Display success message
//       Get.snackbar('Success', 'Account created successfully',
//           snackPosition: SnackPosition.BOTTOM);
//
//       // Navigate to home page after successful signup
//       if (isLoading) {
//         Get.off(() => SongPage());
//       }
//
//
//       isLoading=false;
//     } catch (error) {
//       isLoading=false;
//       Get.snackbar('Error', error.toString(),
//           snackPosition: SnackPosition.BOTTOM);
//     }
//     update();
//   }
//   bool passwordVisible = false;
//   void onpress(){
//     passwordVisible= !passwordVisible;
//     update();
//   }
//
//
// }




import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../screens/home_page.dart';


class SignupController extends GetxController {
  String userName = '';
  String userEmail = '';
  String userId = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final key1= GlobalKey<FormState>();
  bool isVisible=false;
  void pressOnPasswordIcon(){
    isVisible=!isVisible;
    update();
  }

  var isLoading = false;

  bool passwordVisible = false;

  Future<void> signUp() async {
    try {
      isLoading=true;

      // Validate input fields
      // if (nameController.text.isEmpty ||
      //     emailController.text.isEmpty ||
      //     passwordController.text.isEmpty) {
      //   Get.snackbar('Error', 'All fields are required',
      //       snackPosition: SnackPosition.BOTTOM);
      //   return;
      // }

      // Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text,
      );

      // Store user information in Firestore
      await FirebaseFirestore.instance
          .collection(Constants.usersCollection)
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text,
        'email': emailController.text,
        // Add other fields if needed
      });
       userId = userCredential.user!.uid;
      userName = nameController.text;
      userEmail = emailController.text;
      // Display success message
      Get.snackbar('Success', 'Account created successfully',
          snackPosition: SnackPosition.BOTTOM);

      // Navigate to home page after successful signup
      if (isLoading) {
        Get.off(() => HomePage());
      }


      isLoading=false;
    } catch (error) {
      isLoading=false;
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }

  Map<String, String> getUserData() {
    return {'userId': userId, 'userName': userName, 'userEmail': userEmail};

  }



}