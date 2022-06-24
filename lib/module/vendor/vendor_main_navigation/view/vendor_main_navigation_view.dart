import 'package:fire_example/core.dart';
import 'package:flutter/foundation.dart';
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
                        "Vendor",
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
                      Container(),
                      Container(),
                      Container(),
                      VendorProfileView(),
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
