import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignUpScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
    // TODO: implement dependencies
  }

}