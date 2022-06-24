import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_example/core.dart';
import 'package:fire_example/service/auth_service.dart';
import 'package:fire_example/shared/widget/show_loading/show_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../view/login_view.dart';

class LoginController extends GetxController {
  LoginView? view;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  login() async {
    var email = Input.get("email");
    var password = Input.get("password");

    showLoading();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      hideLoading();
      await AuthService.checkCurrentUserRole();

      if (AuthService.isAdmin) {
        Get.off(AdminMainNavigationView());
      } else {
        Get.off(ClientMainNavigationView());
      }
    } on Exception catch (_) {
      hideLoading();
      showError("Login failed", "Wrong username or password");
    }
  }
}
