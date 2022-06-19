import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:student_app/controller/screen_controller.dart';
import 'package:student_app/db/models/student_model.dart';
import 'package:student_app/screens/screen_add_student.dart';
import 'package:student_app/screens/screen_search%20_student.dart';
import 'package:student_app/screens/screen_student_profile.dart';
import 'package:student_app/screens/screen_update_student.dart';
import 'package:student_app/widgets/text_filed.dart';
// ignore: prefer_typing_uninitialized_variables

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  StudentModel? data;
  final screenController = ScreenController();
  dynamic images;

  @override
  Widget build(BuildContext context) {
    screenController.allStudentslist();
    return Scaffold(
      backgroundColor: scaffoldBG,
      appBar: AppBar(
        title: const Center(child: Text('STUDENTS LIST',style: TextStyle(fontWeight: FontWeight.bold),)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                searchData.clear();
                Get.to(() => SearchPage());
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: scaffoldBG,
      ),
      body: SafeArea(
        child: Obx(
          () {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = studentModelList[index];
                    final encodedimg = data.image;
                    images = const Base64Decoder().convert(encodedimg);
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: const Alignment(0, 0),
                        height: 80,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0,3), // changes position of shadow
                            )
                          ],
                        ),
                        child: Slidable(
                         direction: Axis.horizontal,
                          key: Key(data.id.toString()),
                          startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                IconButton(
                                    onPressed: () => Get.to(() => EditStudent(data: data, editorClicked: true)),
                                    icon: const Icon(Icons.edit,
                                        color: Colors.amber)),
                                IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: "Delete",
                                        titleStyle:
                                            const TextStyle(color: Colors.red),
                                        middleText: "Are you sure ?",
                                        confirm: TextButton(
                                            onPressed: () {
                                              screenController.deleteData(data.id!);
                                              Get.back();
                                            },
                                            child: const Text("Yes")),
                                        cancel: TextButton(
                                            onPressed: () =>Get.back(),
                                            child: const Text("No")));},
                                    icon: const Icon(Icons.delete_forever,
                                        color: Colors.red)),
                              ]),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage: MemoryImage(images),
                            ),
                            title: Text(data.name.toUpperCase(),
                              style: const TextStyle(fontSize: 20)),
                            onTap: () => Get.to(() => ProfileStudent(data: data)),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) =>const Divider(height: 1),
                  itemCount: studentModelList.length),
            );
          },
        ),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.miniCenterFloat ,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => Addstudent()),
        backgroundColor: Colors.black,
        tooltip: 'Add New',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
