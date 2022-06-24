import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_example/core.dart';
import 'package:fire_example/service/auth_service.dart';
import 'package:fire_example/shared/widget/show_loading/show_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../view/sign_up_view.dart';

class SignUpController extends GetxController {
  SignUpView? view;

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

  signUp() async {
    var email = Input.get("email");
    var password = Input.get("password");

    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }

    if (FirebaseAuth.instance.currentUser == null) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //-------------------

        //-------------------
        await AuthService.checkCurrentUserRole();
      } on FirebaseAuthException catch (_) {
        print("------------");
        print(_.toString());
        print("------------");

        if (_.toString().contains("[firebase_auth/email-already-in-use]")) {
          Get.snackbar("Signup failed",
              "The email address is already in use by another account.");
        } else {
          Get.snackbar("Signup failed", "Registration failed.");
        }
      }
    }

    //-------------------
    //-------------------
    //-------------------
  }
}
