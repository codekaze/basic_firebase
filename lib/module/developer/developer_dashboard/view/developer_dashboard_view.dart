import 'package:flutter/material.dart';
import '../controller/developer_dashboard_controller.dart';

import 'package:get/get.dart';

class DeveloperDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeveloperDashboardController>(
      init: DeveloperDashboardController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: Text("DeveloperDashboard"),
          ),
        );
      },
    );
  }
}