import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:student_app/controller/screen_controller.dart';
import 'package:student_app/db/models/student_model.dart';
import 'package:student_app/screens/screen_home.dart';
import 'package:student_app/widgets/text_filed.dart';

class EditStudent extends StatelessWidget {
  final StudentModel data;
  bool editorClicked = false;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _regController = TextEditingController();
  final _batchController = TextEditingController();

  final screenController =Get.put(ScreenController()) ;

  EditStudent({Key? key, required this.data, required this.editorClicked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    _nameController.text = data.name;
    _ageController.text = data.age;
    _placeController.text = data.place;
    _regController.text = data.regNo;
    _batchController.text = data.batch;

    return Scaffold(
      backgroundColor: scaffoldBG,
      appBar: AppBar(
        title: const Text('Edit Data'),
        backgroundColor:scaffoldBG,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              GetBuilder<ScreenController>(builder: (controller) {
                if (editorClicked == true) {
                  screenController.stringOfimg = data.image;
                  editorClicked = false;
                }
                return CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      MemoryImage(const Base64Decoder().convert(screenController.stringOfimg)),
                );
              }),
              IconButton(
                onPressed: () async {
                  screenController.pickimage();
                },
                icon: const Icon(
                  Icons.camera,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            Textfeild(regController: _nameController, hintText: "Name",keyboardType: TextInputType.name),
                Textfeild(regController: _ageController, hintText: "Age",keyboardType: TextInputType.number),
                Textfeild(regController: _placeController, hintText: "Place"),
                Textfeild(regController: _batchController, hintText: "Batch"),
                Textfeild(regController: _regController, hintText: "Reg No",keyboardType: TextInputType.number),
              Center(
                child: ElevatedButton.icon(
                    onPressed: () {
                      updatebuttonClick(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Update')),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updatebuttonClick(BuildContext context) async {
    final name = _nameController.text;
    final age = _ageController.text;
    final place = _placeController.text;
    final batch = _batchController.text;
    final reg = _regController.text;

    final screenController = Get.put(ScreenController());

    if (name.isEmpty ||
        age.isEmpty ||
        place.isEmpty ||
        batch.isEmpty ||
        reg.isEmpty ||
        screenController.stringOfimg.isEmpty) {
      return;
    }
    final student = StudentModel(
        age: age,
        batch: batch,
        name: name,
        place: place,
        regNo: reg,
        image: screenController.stringOfimg,
        id: data.id);
    await screenController.updateData(student);
    Get.snackbar("Updated !", "Data upadated successfully",
    barBlur: 20.0,
        colorText:Colors.white );
   
    clearFields();
    Get.off(() => HomeScreen());
  }

  void clearFields() {
    final screenController =Get.put( ScreenController());
    _nameController.text = '';
    _ageController.text = '';
    _placeController.text = '';
    _batchController.text = '';
    _regController.text = '';
    screenController.stringOfimg = '';
  }
}
