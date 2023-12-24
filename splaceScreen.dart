import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/splaceScreenController.dart';


class SplaceScreen extends StatelessWidget {
  const SplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceScreenController splaceScreenController = Get.put(SplaceScreenController());
    return Scaffold(
      body: Center(
        child: SvgPicture.asset("assets/icons/big_logo.svg"),
      ),
    );
  }
}