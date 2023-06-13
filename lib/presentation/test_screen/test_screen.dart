import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/utils/color_constant.dart';

import 'test_controller.dart';

class TestScreen extends GetWidget<TestController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                "Test Screen",
                style: TextStyle(color: Colors.black),
              )),
              backgroundColor: Colors.white,
            ),
            backgroundColor: ColorConstant.whiteA700,
            body: Container(
              child: Text("test"),
            )));
  }
}
