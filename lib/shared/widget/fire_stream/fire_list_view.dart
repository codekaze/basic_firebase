import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class FireListView extends StatelessWidget {
  final dynamic stream;
  final Function? onEmptyDocs;
  final String? title;
  final bool shrinkWrap;
  final Axis? scrollDirection;
  // final bool? showLoading;
  final Function(
    Map item,
    int index,
    dynamic querySnapshot,
  )? onItemBuild;

  final Function(
    QuerySnapshot querySnapshot,
  )? onSnapshots;

  const FireListView({
    this.title,
    // this.showLoading = true,
    required this.stream,
    this.onItemBuild,
    this.onEmptyDocs,
    this.onSnapshots,
    this.shrinkWrap = true,
    this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return StreamBuilder<dynamic>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();

          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: shrinkWrap,
            physics:
                shrinkWrap == false ? null : NeverScrollableScrollPhysics(),
            scrollDirection: scrollDirection ?? Axis.vertical,
            itemBuilder: (context, index) {
              var item = snapshot.data[index].map;
              var docId = snapshot.data[index].id;
              item["id"] = docId;

              if (onItemBuild != null) {
                return onItemBuild!(item, index, null);
              }

              return Container();
            },
          );
        },
      );
    }

    // IF ANDROID, IOS or WEB
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, stream) {
        // if (showLoading!) {
        if (stream.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitRing(
              color: Get.theme.primaryColor,
            ),
          );
          // }
        }

        QuerySnapshot? querySnapshot = stream.data;

        if (querySnapshot!.docs.isEmpty) {
          if (onEmptyDocs != null) return onEmptyDocs!();
          return Container();
        }

        if (onSnapshots != null) {
          return onSnapshots!(querySnapshot);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  title!,
                ),
              ),
            if (title != null) const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: querySnapshot.docs.length,
                shrinkWrap: shrinkWrap,
                physics:
                    shrinkWrap == false ? null : NeverScrollableScrollPhysics(),
                scrollDirection: scrollDirection ?? Axis.vertical,
                itemBuilder: (context, index) {
                  var item = (querySnapshot.docs[index].data() as Map);
                  var docId = querySnapshot.docs[index].id;
                  item["id"] = docId;

                  if (onItemBuild != null) {
                    return onItemBuild!(item, index, querySnapshot);
                  }
                  return Container();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
