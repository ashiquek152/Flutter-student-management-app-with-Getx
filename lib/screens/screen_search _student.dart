import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controller/screen_controller.dart';
import 'package:student_app/screens/screen_student_profile.dart';
import 'package:student_app/widgets/text_filed.dart';

var proIMG;

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  final screenController = ScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBG,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CupertinoSearchTextField(
                      controller: searchController,
                      onChanged: (value) {
                        // screenController.searchValue=value.obs;
                       screenController.searchdata(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () {
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var data = searchData[index];
                        var encodedimg = data.image;
                        proIMG = const Base64Decoder().convert(encodedimg);
                        if (data.name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                              color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                              leading: CircleAvatar(
                                radius: 35,
                                backgroundImage: MemoryImage(proIMG),
                              ),
                              title: Text(data.name.toUpperCase(),
                                style: const TextStyle(fontSize: 20)),
                              onTap: () => Get.to(() => ProfileStudent(data: data)),
                                                      ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      separatorBuilder: (ctx, index)=> const Divider(height: 5),
                      itemCount: searchData.length),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}