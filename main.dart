

import 'dart:io';

import 'package:demo/binding/SongPlayPage_binding.dart';
import 'package:demo/demo/home.dart';
import 'package:demo/screens/home_page.dart';
import 'package:demo/screens/demoPage.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/screens/profile.dart';
import 'package:demo/screens/song_play_page.dart';
import 'package:demo/screens/signup.dart';
import 'package:demo/screens/splaceScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'binding/homepage_binding.dart';
import 'binding/login_screen_binding.dart';
import 'binding/signup_binding.dart';
import 'binding/splaceScreenBinding.dart';
import 'config/theme.dart';
import 'controllers/cloudSongController.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDgtDLqb_a7yISQQlWgQRAOSu2HWb4VytI",
      appId: "1:557625486853:android:7c4d8162503bddc8d1f66c",
      messagingSenderId: "557625486853",
      projectId: "fir-ac46d",
      storageBucket: "fir-ac46d.appspot.com",
    ),
  )
      : await  Firebase.initializeApp();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'My App',
      theme: darkTheme,

     // home: SignupPage(),
      // home: LoginPage(),
     // home: SongPage(),
      // home: DemoPage(),   //this page is for call database to check whether the song uploaded on database or not
      //home: HomePage(),
      initialRoute: '/signupScreen',
      initialBinding: BindingsBuilder(() {
        Get.put(CloudSongController());
      }),
      getPages: [
        //GetPage(name: '/CustomHeader', page: () => CustomDrawerHeader(),binding: CustomHeaderBinding()),
        GetPage(name: '/SplaceScreen', page: () => SplaceScreen(),binding: SplaceScreenBinding()),
        GetPage(name: '/loginScreen', page: () => LoginPage(),binding: LoginScreenBinding()),
        GetPage(name: '/signupScreen', page: () => SignupPage(),binding: SignUpScreenBinding()),
        GetPage(name: '/songPlayPage', page: ()=>SongPlayPage(), binding: SongPlayPageBinding()),
        GetPage(name: '/homePage', page: ()=>HomePage(),binding: HomePageBinding())

        //    GetPage(name: Constants.songPageRoute, page: () => SongPage()),
      ],


    );

  }

}
