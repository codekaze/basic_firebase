import 'package:flutter/material.dart';
import '../controller/vendor_dashboard_controller.dart';

import 'package:get/get.dart';

class VendorDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VendorDashboardController>(
      init: VendorDashboardController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: Text("VendorDashboard"),
          ),
        );
      },
    );
  }
}