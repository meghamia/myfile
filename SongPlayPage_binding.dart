import 'package:get/get.dart';

import '../controllers/songPlayerController.dart';

class SongPlayPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SongPlayerController());
  }

}