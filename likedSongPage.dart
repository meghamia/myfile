// likedSongPage.dart
import 'package:demo/model/LocalMusicModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/songPlayerController.dart';
import '../model/MySongModel.dart';

class LikedSongPage extends StatelessWidget {
  var controller= Get.find<HomePageController>();


  @override
  Widget build(BuildContext context) {
    print("Liked Songs: ${controller.likedSong}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Songs'),
      ),
      body: ListView.builder(
        itemCount: controller.likedSong.length,
        itemBuilder: (context, index) {
          LocalMusicModel likedSong = controller.likedSong[index];
          return ListTile(
            title: Text(likedSong.title!),
            subtitle: Text(likedSong.artist!),
          );
        },
      ),
    );
  }
}
