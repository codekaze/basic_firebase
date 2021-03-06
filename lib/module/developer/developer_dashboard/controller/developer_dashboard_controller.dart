import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_example/core.dart';
import 'package:fire_example/shared/widget/show_loading/show_loading.dart';
import 'package:fireverse/fireglobal.dart';
import 'package:get/get.dart';
import '../view/developer_dashboard_view.dart';

class DeveloperDashboardController extends GetxController {
  DeveloperDashboardView? view;

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

  Future reset() async {
    var snapshot = await FirebaseFirestore.instance.collection("users").get();
    showLoading();
    for (var doc in snapshot.docs) {
      await FirebaseFirestore.instance.collection("users").doc(doc.id).delete();
    }
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    Get.off(LoginView());
  }
}
