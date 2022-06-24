import 'package:flutter/material.dart';
import '../controller/admin_profile_controller.dart';

import 'package:get/get.dart';

class AdminProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminProfileController>(
      init: AdminProfileController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: Text("AdminProfile"),
          ),
        );
      },
    );
  }
}