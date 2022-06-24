import 'package:fire_example/core.dart';
import 'package:fire_example/shared/widget/show_loading/show_loading.dart';
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
            title: Text("Developer Dashboard"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  child: Wrap(
                    children: [
                      InkWell(
                        onTap: () async {
                          await controller.reset();
                        },
                        child: Container(
                          width: Get.width / 4,
                          child: Column(
                            children: [
                              Icon(Icons.developer_board),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Reset",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
