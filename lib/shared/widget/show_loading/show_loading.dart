import 'package:flutter/material.dart';
import 'package:fire_example/core.dart';

BuildContext? loadingContext;
bool loadingRendered = false;
showLoading() async {
  loadingContext = null;

  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    useRootNavigator: false,
    builder: (context) {
      loadingContext = context;

      return Stack(
        children: [
          Center(
            child: CircleAvatar(
              radius: 26.0,
              backgroundColor: Colors.white,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
            // child: CircularProgressIndicator(),
          ),
        ],
      );
    },
  );
}

hideLoading() {
  print("hideLoading...");
  // Navigator.pop(loadingContext!);
  Get.back();
}

showPopup({
  required List<Widget> children,
}) {
  showDialog(
    context: Get.context!,
    // barrierDismissible: false,
    // useRootNavigator: false,
    builder: (context) {
      loadingContext = context;
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      );
    },
  );
}

hidePopup() {
  Navigator.pop(loadingContext!);
}

Future delay(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
