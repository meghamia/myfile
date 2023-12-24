import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgotpasswordcontroller.dart';

class ForgotPasswordPage extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController =
  Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white.withOpacity(0.8), // Adjust the opacity as needed
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: forgotPasswordController.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => forgotPasswordController.resetPassword(),
              child: Obx(() {
                return forgotPasswordController.isLoading.value
                    ? CircularProgressIndicator()
                    : Text('Reset Password');
              }),
            ),
          ],
        ),
      ),
    );
  }
}
