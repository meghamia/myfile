import 'package:get/get.dart';

import '../controllers/splaceScreenController.dart';

class SplaceScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplaceScreenController());
    // TODO: implement dependencies
  }

}