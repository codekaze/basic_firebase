import 'package:flutter/material.dart';
import '../controller/client_dashboard_controller.dart';

import 'package:get/get.dart';

class ClientDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientDashboardController>(
      init: ClientDashboardController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: Text("ClientDashboard"),
          ),
        );
      },
    );
  }
}