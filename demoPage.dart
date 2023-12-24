import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cloudSongController.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    CloudSongController cloudSongController  = Get.put(CloudSongController());
    return Scaffold(
        body: Center(
        child: ElevatedButton(
          child: Text("call database"),
          onPressed: () {
           cloudSongController.getCloudSound();
          //  cloudSongController.uploadSongToDB();
          },
        ),
      ),
    );
  }
}
