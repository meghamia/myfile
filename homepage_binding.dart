import 'package:demo/controllers/cloudSongController.dart';
import 'package:demo/controllers/songPlayerController.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SongPlayerController());
    Get.lazyPut(() => CloudSongController());
    // TODO: implement dependencies
  }

}