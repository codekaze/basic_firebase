import 'package:fire_example/module/developer/developer_dashboard/view/developer_dashboard_view.dart';
import 'package:fire_example/module/developer/developer_profile/view/developer_profile_view.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../controller/developer_main_navigation_controller.dart';

import 'package:get/get.dart';

class DeveloperMainNavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeveloperMainNavigationController>(
      init: DeveloperMainNavigationController(),
      builder: (controller) {
        controller.view = this;

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            body: Column(
              children: [
                if (kDebugMode)
                  Container(
                    padding: EdgeInsets.all(4.0),
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        "Developer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: IndexedStack(
                    index: controller.selectedIndex,
                    children: [
                      DeveloperDashboardView(),
                      Container(),
                      Container(),
                      DeveloperProfileView(),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Colors.blueGrey[500],
              selectedItemColor: Colors.blueGrey[900],
              currentIndex: controller.selectedIndex,
              onTap: (newSelectedIndex) {
                controller.selectedIndex = newSelectedIndex;
                controller.update();
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: "Progress",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Bookmark",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Me",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
