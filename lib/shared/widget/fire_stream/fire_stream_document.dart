import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core.dart';

class FireStreamDocument extends StatelessWidget {
  final Stream<dynamic> stream;
  final Widget? onLoading;
  final Widget? onError;
  final Function? onEmpty;
  final Function(Map? data) onReceivedData;

  FireStreamDocument({
    required this.stream,
    required this.onReceivedData,
    this.onLoading,
    this.onError,
    this.onEmpty,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return StreamBuilder(
        stream: stream,
        builder: (context, stream) {
          if (stream.data == null) return Container();

          var d = (stream.data as dynamic);
          Map? item;
          if (d != null) {
            item = d!.map;
            item!["id"] = d.id;
          }

          return onReceivedData(item);
        },
      );
    }

    return StreamBuilder(
      stream: stream,
      builder: (context, stream) {
        if (stream.connectionState == ConnectionState.waiting) {
          if (onLoading == null) {
            return Center(
              child: SpinKitRing(
                color: Get.theme.primaryColor,
              ),
            );
          }
        }

        if (stream.hasError) {
          if (onError == null) {
            return Center(child: Text(stream.error.toString()));
          }
        }

        if (stream.data == null) {
          if (onEmpty != null) {
            return onEmpty!();
          }
        }

        Map? item;
        if (stream.data != null) {
          var d = (stream.data as DocumentSnapshot);
          item = (d.data() as Map);
          item["id"] = d.id;
        }

        return onReceivedData(item);
      },
    );
  }
}
