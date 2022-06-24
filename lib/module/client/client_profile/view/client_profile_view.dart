import 'package:fire_example/core.dart';
import 'package:flutter/material.dart';
import '../controller/client_profile_controller.dart';

import 'package:get/get.dart';

class ClientProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientProfileController>(
      init: ClientProfileController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Spacer(),
                ExButton(
                  label: "Logout",
                  color: dangerColor,
                  onPressed: () async {
                    Get.off(LoginView());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
