// // login_controller.dart
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'constants.dart';
//
// class LoginController extends GetxController {
//   final RxBool isLoading = false.obs;
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> login() async {
//     try {
//       isLoading(true);
//
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//
//       // If login is successful, save the login state locally and in Firestore
//       await saveLoginState(userCredential.user?.uid ?? '');
//
//       // Navigate to the home screen
//       Get.offAllNamed(Constants.homeRoute);
//     } catch (e) {
//       // Handle login failure
//       print('Login failed: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> saveLoginState(String userId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference users = firestore.collection('users');
//
//     // Save login state locally
//     await prefs.setBool(Constants.isLoggedInKey, true);
//
//     // Save login state in Firestore
//     await users.doc(userId).set({
//       'isLoggedIn': true,
//     });
//   }
//
//   checkLocalLoginState() {}
// }

// login_controller.dart



import 'dart:core';

import 'package:demo/controllers/songPlayerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../screens/home_page.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final key = GlobalKey<FormState>();
  bool isVisible=false;
  void pressOnPasswordIcon(){
    isVisible=!isVisible;
    update();
  }

  var isLoading = false;

  // Email validation using regex pattern
  bool isValidEmail(String email) {
    String emailPattern =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

 bool passwordVisible = false;



  Future<void> login() async {
    try {

      // Save user information in SharedPreferences
      await saveUserInformation(
        emailController.text,
        passwordController.text,
      );
      Get.to(() => HomePage());
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<bool> areCredentialsValid(String enteredEmail, String enteredPassword) async {
    try {
      // Use Firebase Authentication to check if credentials are valid
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: enteredEmail,
        password: enteredPassword,
      );

      // If login is successful, return true
      return userCredential.user != null;
    } catch (error) {
      print('Error validating credentials: $error');
      return false;
    }
  }


  Future<void> saveUserInformation(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    //prefs.setBool("isLoginSuccessful", true);
  }
}







