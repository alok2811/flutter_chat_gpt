import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/three_dots.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("ChatGPT")),
        body: SafeArea(
          child: Obx(() => Column(
            children: [
              Flexible(
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      return controller.messages[index];
                    },
                  )),
              if (controller.isTyping.value) const ThreeDots(),
              const Divider(
                height: 1.0,
              ),
              Card(
                child: controller.buildChatTextEditor(),
              )
            ],
          )),
        ));
  }
}
