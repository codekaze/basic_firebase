import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_example/core.dart';
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

    try {
      showLoading();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      hideLoading();
      //-------------------

      var snapshot = await FirebaseFirestore.instance.collection("users").get();
      bool isAdmin = false;
      if (snapshot.docs.isEmpty) {
        isAdmin = true;
        await FirebaseFirestore.instance.collection("users").add({
          "id": FirebaseAuth.instance.currentUser!.uid,
          "email": FirebaseAuth.instance.currentUser!.email,
          "is_admin": isAdmin,
        });

        showInfo("Success", "Registered as admin!");
      } else {
        await FirebaseFirestore.instance.collection("users").add({
          "id": FirebaseAuth.instance.currentUser!.uid,
          "email": FirebaseAuth.instance.currentUser!.email,
          "is_admin": isAdmin,
        });

        showInfo("Success", "Registered as client!");
      }

      Get.off(LoginView());
      //-------------------
    } on Exception catch (_) {
      hideLoading();
      Get.snackbar("Error", "Registration failed!");
    }
  }
}
