import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fire_example/core.dart';

class FireListItem {
  final String? photoUrl;
  final String? title;
  final String? subtitle;

  FireListItem({
    this.title,
    this.subtitle,
    this.photoUrl,
  });
}

class FireCrud extends StatelessWidget {
  final String title;
  final List<dynamic> formFields;
  final List<Widget> actions;
  final FireCore service;
  final FireListItem listItem;

  final bool enableAdd;
  final bool enableEdit;
  final bool enableDelete;
  final bool enableApproval;
  final bool approvalIndicator;

  //Custom Builder
  final Function(Map item)? itemBuilder;
  final dynamic customRef;

  FireCrud({
    required this.title,
    required this.formFields,
    required this.service,
    required this.listItem,
    this.actions = const [],
    this.enableAdd = true,
    this.enableEdit = true,
    this.enableDelete = true,
    this.enableApproval = false,
    this.approvalIndicator = false,

    //Custom Builder
    this.itemBuilder,
    this.customRef,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FireCrudController>(
        init: FireCrudController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("$title"),
              actions: [
                if (kDebugMode) ...[
                  InkWell(
                    onTap: () async {
                      service.deleteAll();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.delete_outlined,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
                ...actions,
                // InkWell(
                //   onTap: () {
                //     showInfoDialog(
                //       "Test",
                //       "TestTest",
                //     );
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //       top: 8.0,
                //       bottom: 8.0,
                //       right: 8.0,
                //       left: 8.0,
                //     ),
                //     child: Icon(Icons.tune),
                //   ),
                // ),
                // InkWell(
                //   onTap: () {},
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //       top: 8.0,
                //       bottom: 8.0,
                //       right: 8.0,
                //       left: 8.0,
                //     ),
                //     child: Icon(Icons.search),
                //   ),
                // ),
                SizedBox(
                  width: 4.0,
                ),
              ],
            ),
            floatingActionButton: !enableAdd
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      Get.to(
                        FireForm(
                          title: "Add ${title.replaceAll(" List", "")} Form",
                          onSave: () async {
                            Map<String, dynamic> values = {};
                            Map<String, dynamic> labels = {};

                            for (var i = 0; i < formFields.length; i++) {
                              var id = formFields[i].id;
                              var label = formFields[i].label;

                              if (id == null) continue;
                              values[id] = Input.get(id);
                              labels[id] = label;
                            }

                            for (var key in values.keys) {
                              var label = labels[key];
                              if (values[key] == null) {
                                showWarning("Error", "$label is Required");
                                return;
                              }

                              if (values[key] is String) {
                                if (values[key] == "") {
                                  showWarning("Error", "$label is Required");
                                  return;
                                }
                              }
                            }

                            await service.add(values);
                            Get.back();
                          },
                          children: List<Widget>.from(formFields),
                        ),
                      );
                    },
                    child: Icon(Icons.add),
                  ),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        prefixIcon: Icon(
                          Icons.search,
                          size: 24,
                          color: Colors.grey,
                        ),
                        suffixIcon: Icon(
                          Icons.tune_outlined,
                          size: 24,
                          color: Colors.grey,
                        ),
                      ),
                      onSubmitted: (search) {
                        controller.search = search;
                        controller.update();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: FireListView(
                      stream: customRef ?? service.stream(),
                      shrinkWrap: false,
                      onItemBuild: (item, index, snapshot) {
                        var photoUrl =
                            getValueFromItem(listItem.photoUrl, item);
                        var itemTitle = getValueFromItem(listItem.title, item);
                        var itemSubtitle =
                            getValueFromItem(listItem.subtitle, item);

                        if (listItem.title != null) {
                          if (listItem.title!.contains(".")) {
                            var arr = listItem.title!.split(".");
                            itemTitle = item[arr[0]][arr[1]];
                          }
                        }

                        if (controller.search.isNotEmpty) {
                          if (!itemTitle.toString().contains(controller.search))
                            return Container();
                        }

                        return InkWell(
                          onTap: () async {
                            if (!enableEdit) return;

                            Map? selectedItem =
                                await service.getDoc(item["id"]);
                            Get.to(
                              FireForm(
                                title: "Edit $title Form",
                                onSave: () async {
                                  Map<String, dynamic> values = {};
                                  Map<String, dynamic> labels = {};

                                  for (var i = 0; i < formFields.length; i++) {
                                    var id = formFields[i].id;
                                    var label = formFields[i].label;

                                    if (id == null) continue;
                                    values[id] = Input.get(id);
                                    labels[id] = label;
                                  }

                                  for (var key in values.keys) {
                                    var label = labels[key];
                                    if (values[key] == null) {
                                      showWarning(
                                          "Error", "$label is Required");
                                      return;
                                    }

                                    if (values[key] is String) {
                                      if (values[key] == "") {
                                        showWarning(
                                            "Error", "$label is Required");
                                        return;
                                      }
                                    }
                                  }

                                  await service.update(
                                      selectedItem!["id"], values);
                                  Get.back();
                                },
                                children: List<Widget>.from(formFields),
                              ),
                            );

                            await Future.delayed(Duration(milliseconds: 500));
                            var editFormFields = List.from(formFields);
                            for (var i = 0; i < editFormFields.length; i++) {
                              var id = editFormFields[i].id;
                              log("id: $id");
                              // log("${Input.inputController[id]}");
                              Input.inputController[id]!
                                  .setValue(selectedItem![id]);
                            }
                          },
                          child: FireItem(
                            service: service,
                            id: item["id"],
                            enableSlide: enableDelete,
                            child: itemBuilder != null
                                ? Builder(
                                    builder: (context) {
                                      return itemBuilder!(item);
                                    },
                                  )
                                : Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                      ),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: listItem.photoUrl == null
                                                ? null
                                                : ExImage(
                                                    "$photoUrl",
                                                    height: 50.0,
                                                    width: 50.0,
                                                  ),
                                            title: listItem.title == null
                                                ? null
                                                : Text("$itemTitle"),
                                            subtitle: listItem.subtitle == null
                                                ? null
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 6.0,
                                                      ),
                                                      Text("$itemSubtitle"),
                                                      if (approvalIndicator) ...[
                                                        SizedBox(
                                                          height: 6.0,
                                                        ),
                                                        if (item["status"] ==
                                                            "Pending")
                                                          Row(
                                                            children: [
                                                              Icon(Icons.timer),
                                                              SizedBox(
                                                                width: 4.0,
                                                              ),
                                                              Text("Pending"),
                                                            ],
                                                          ),
                                                        if (item["status"] ==
                                                            "Rejected")
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons.cancel),
                                                              SizedBox(
                                                                width: 4.0,
                                                              ),
                                                              Text("Rejected"),
                                                            ],
                                                          ),
                                                        if (item["status"] ==
                                                            "Approved")
                                                          Row(
                                                            children: [
                                                              Icon(Icons.check),
                                                              SizedBox(
                                                                width: 4.0,
                                                              ),
                                                              Text("Approved"),
                                                            ],
                                                          ),
                                                      ],
                                                    ],
                                                  ),
                                          ),
                                          if (enableApproval) ...[
                                            Divider(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: () async {
                                                      showConfirmDialog(
                                                        "Confirm Reject",
                                                        "Are you sure?",
                                                        onConfirm: () {
                                                          log(item.toString());
                                                          service.update(
                                                              item["id"], {
                                                            "status":
                                                                "Rejected",
                                                          });
                                                          // service.delete(
                                                          //     item["id"]);
                                                          Get.back();
                                                        },
                                                      );
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          dangerColor,
                                                      child: Icon(
                                                        Icons.cancel,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      showConfirmDialog(
                                                        "Confirm Approve",
                                                        "Are you sure?",
                                                        onConfirm: () {
                                                          log(item.toString());
                                                          service.update(
                                                              item["id"], {
                                                            "status":
                                                                "Approved",
                                                          });
                                                          Get.back();
                                                        },
                                                      );
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          successColor,
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

getValueFromItem(String? key, Map item) {
  var value;
  if (key == null) return;

  if (key.contains(".")) {
    var arr = key.split(".");
    if (arr.length == 2) {
      value = item[arr[0]]?[arr[1]] ?? "-";
    } else if (arr.length == 3) {
      value = item[arr[0]][arr[1]][arr[2]];
    }
  } else {
    value = item[key];
  }

  return value;
}
