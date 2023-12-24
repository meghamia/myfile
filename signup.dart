import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import 'home_page.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: SafeArea(
          child: GetBuilder<SignupController>(
        init: SignupController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Sign Up'),
            ),

            body: Form(
              key: controller.key1,
              child: Stack(
                children: [
                  // Background Image
                  Image.network(
                    'https://images.pexels.com/photos/12418421/pexels-photo-12418421.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
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
                        // Name TextField
                        TextFormField(
                          validator: (String? name) {
                            if (name!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          controller: controller.nameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),

                        // Email TextField
                        TextFormField(
                          validator: (String? email) {
                            if (controller.emailController.text.isEmpty) {
                              return 'Email is required';
                            } else if (email!.isEmpty) {
                              return 'Disable email id';
                            }
                            return null;
                          },
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16.0),

                        // Password TextField
                        TextFormField(
                          validator: (String? val) {
                            if (controller.passwordController.text.isEmpty) {
                              return 'Password is required';
                            } else if (val!.isEmpty || val.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          controller: controller.passwordController,
                          obscureText: controller.isVisible,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Toggle the password visibility
                                controller.pressOnPasswordIcon();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Sign Up Button
                        ElevatedButton(
                          onPressed: () {
                            if (controller.key1.currentState!.validate()) {
                              controller.signUp();
                              // if (!controller.isLoading) {
                              //  Get.off(() => SongPage());
                              // }
                            }
                            //Get.off(() => SongPage());
                          },
                          child: controller.isLoading
                              ? CircularProgressIndicator()
                              : Text('Sign Up'),
                        ),
                        SizedBox(height: 20),

                        // Login Button
                        TextButton(
                          onPressed: () => Get.toNamed(
                              "/loginScreen"), // Use the named route for login
                          child: Text('Already have an account? Login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
