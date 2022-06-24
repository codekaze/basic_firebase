import 'package:fire_example/core.dart';
import 'package:fire_example/module/developer/developer_main_navigation/view/developer_main_navigation_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../controller/login_controller.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Stack(
                children: [
                  if (kDebugMode)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => Get.off(DeveloperMainNavigationView()),
                        child: Card(
                          color: Colors.orange,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "Dev Pages",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Center(
                    child: Card(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 320.0,
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Wrap(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  ExTextField(
                                    id: "email",
                                    label: "Email",
                                  ),
                                  ExTextField(
                                    id: "password",
                                    label: "Password",
                                    textFieldType: TextFieldType.password,
                                  ),
                                  ExButton(
                                    label: "Login",
                                    onPressed: () async {
                                      Get.to(AdminMainNavigationView());
                                    },
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await FirebaseAuth.instance
                                          .signInAnonymously();
                                      Get.off(ClientMainNavigationView());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Login as Guest",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
