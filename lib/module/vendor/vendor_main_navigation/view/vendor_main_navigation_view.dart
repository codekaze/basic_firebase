import 'package:flutter/material.dart';
import '../controller/vendor_main_navigation_controller.dart';

import 'package:get/get.dart';

class VendorMainNavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VendorMainNavigationController>(
      init: VendorMainNavigationController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: Text("VendorMainNavigation"),
          ),
        );
      },
    );
  }
}