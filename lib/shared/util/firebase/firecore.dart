import 'dart:developer';
import 'dart:io';
import 'package:fireverse/fireglobal.dart';
import 'package:fireverse/fireverse.dart';

class FireCore {
  final String collectionName = "";
}

extension FireCoreAbstractExt on FireCore {
  dynamic get ref {
    return Fire.getRef(collectionName: collectionName);
  }

  dynamic stream() {
    if (Platform.isWindows) {
      return ref.stream;
    } else {
      return ref.snapshots();
    }
  }

  Future<Map?> getDoc(String id) async {
    if (Platform.isWindows) {
      var s = await ref.doc(id).get();
      var d = s.map;
      if (d == null) return Future.value(null);
      Map item = s.map;
      item["id"] = id;
      return (item);
    } else {
      var s = await ref.doc(id).get();
      var d = s.data();
      if (d == null) return Future.value(null);
      Map item = (d as Map);
      d["id"] = id;
      return (item);
    }
  }

  Future deleteAll() async {
    if (Platform.isWindows) {
      var snapshots = await ref.get();
      log("${snapshots.length}");
      for (var i = 0; i < snapshots.length; i++) {
        await ref.doc(snapshots[i].id).delete();
      }
    } else {
      var snapshots = await ref.get();
      for (var i = 0; i < snapshots.docs.length; i++) {
        var doc = snapshots.docs[i];
        await ref.doc(doc.id).delete();
      }
    }
  }

  Future add(Map<String, dynamic> value) async {
    value["created_by"] = Fire.currentUser!.uid;
    value["created_at"] = Fire.timestamp();
    value["updated_at"] = Fire.timestamp();
    value["status"] = "Pending";

    log(ref.toString());
    return await ref.add(value);
  }

  Future update(String docId, Map<String, dynamic> value) async {
    value["updated_at"] = Fire.timestamp();
    return await ref.doc(docId).update(value);
  }

  Future delete(String docId) async {
    return await ref.doc(docId).delete();
  }
}
