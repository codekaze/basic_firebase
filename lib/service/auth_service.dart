import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static bool isAdmin = false;
  static Future checkCurrentUserRole() async {
    isAdmin = false;
    if (FirebaseAuth.instance.currentUser != null) {
      var snapshot = await FirebaseFirestore.instance.collection("users").get();
      if (snapshot.docs.isEmpty) {
        isAdmin = true;
        await FirebaseFirestore.instance.collection("users").add({
          "id": FirebaseAuth.instance.currentUser!.uid,
          "email": FirebaseAuth.instance.currentUser!.email,
          "is_admin": isAdmin,
        });
      }

      //-------------
      var currentUserSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (currentUserSnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection("users").add({
          "id": FirebaseAuth.instance.currentUser!.uid,
          "email": FirebaseAuth.instance.currentUser!.email,
          "is_admin": isAdmin,
        });
      } else {
        Map<String, dynamic> currentUser = currentUserSnapshot.docs[0].data();
        isAdmin = currentUser["is_admin"] ?? false;
      }
    }
  }
}
