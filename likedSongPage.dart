// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/songPlayerController.dart';
//
// class LikedSongsPage extends StatelessWidget {
//   final SongPlayerController controller = Get.find(); // Get the controller
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Liked Songs'),
//       ),
//       body: ListView.builder(
//         itemCount: controller.likedSongs.length,
//         itemBuilder: (context, index) {
//           final song = controller.likedSongs[index];
//           return ListTile(
//             title: Text(song.title!),
//             subtitle: Text(song.artist!),
//             // Add more details as needed
//           );
//         },
//       ),
//     );
//   }
// }
