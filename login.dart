// login_page.dart

import 'package:demo/screens/home_page.dart';
import 'package:demo/screens/signup.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'forgotpassword.dart';
class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: SafeArea(
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueGrey,
                title: Text('Login'),
                centerTitle: true,
              ),
              body: Form(
                key: controller.key,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/pexels-anton-h-145707.jpg',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white.withOpacity(0.8),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              controller: controller.emailController,
                              validator: (String? email) {
                                if (controller.emailController.text.isEmpty) {
                                  return 'Email is required';
                                } else if (email!.isEmpty) {
                                  return 'Disable email id';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                labelText: 'Email',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white.withOpacity(0.8),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              controller: controller.passwordController,
                              keyboardType: TextInputType.text,
                              validator: (String? val) {
                                if (controller.passwordController.text.isEmpty) {
                                  return 'Password is required';
                                } else if (val!.isEmpty || val.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              obscureText: controller.isVisible,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.key),
                                labelText: 'Password',
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    controller.pressOnPasswordIcon();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(() => ForgotPasswordPage());
                                },
                                child: Text('Forgot Password?'),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              if (controller.key.currentState!.validate()) {
                                try {
                                  controller.isLoading=true;

                                  if (await controller.areCredentialsValid(
                                      controller.emailController.text,
                                      controller.passwordController.text)) {
                                    await controller.saveUserInformation(
                                      controller.emailController.text,
                                      controller.passwordController.text,
                                    );
                                    Get.to(() => HomePage());
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Invalid email or password',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                } catch (error) {
                                  Get.snackbar(
                                    'Error',
                                    error.toString(),
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                } finally {
                                  controller.isLoading=false;
                                }
                              }
                            },
                            child: Text('Login'),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Get.to(() => SignupPage());
                            },
                            child: Text(
                              'Don\'t Have an Account? Sign Up Now!',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
