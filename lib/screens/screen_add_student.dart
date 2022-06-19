import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controller/screen_controller.dart';
import 'package:student_app/db/models/student_model.dart';
import 'package:student_app/screens/screen_home.dart';
import 'package:student_app/widgets/text_filed.dart';

class Addstudent extends StatelessWidget {
  Addstudent({Key? key, this.data}) : super(key: key);

  final StudentModel? data;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _regController = TextEditingController();
  final _batchController = TextEditingController();

  final screenController = Get.put(ScreenController());
  final formvalidationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBG,
      appBar: AppBar(
        title: const Text('Add student details'),
        backgroundColor:scaffoldBG,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formvalidationKey,
            child: ListView(
              children: [
                GetBuilder<ScreenController>(builder: (controller) {
                  return Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/blank-profile-picture-973460_1280.webp"))),
                      child: screenController.stringOfimg.trim().isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(const Base64Decoder()
                                  .convert(screenController.stringOfimg)),
                            )
                          : Container(),
                    ),
                  );
                }),
                IconButton(
                    onPressed: () async {
                      screenController.pickimage();
                    },
                    icon:
                        const Icon(Icons.camera, color: Colors.red, size: 20)),
                const SizedBox(height: 20),
                Textfeild(regController: _nameController, hintText: "Name",keyboardType: TextInputType.name,),
                Textfeild(regController: _ageController, hintText: "Age",keyboardType: TextInputType.number),
                Textfeild(regController: _placeController, hintText: "Place",keyboardType: TextInputType.text),
                Textfeild(regController: _batchController, hintText: "Batch",keyboardType: TextInputType.text),
                Textfeild(regController: _regController, hintText: "Reg No",keyboardType: TextInputType.number,),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if (formvalidationKey.currentState!.validate()) {
                          addbuttonclick(context);
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('ADD')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addbuttonclick(BuildContext context) async {
    final name = _nameController.text;
    final age = _ageController.text;
    final place = _placeController.text;
    final batch = _batchController.text;
    final reg = _regController.text;

    if (name.isEmpty ||
        age.isEmpty ||
        place.isEmpty ||
        batch.isEmpty ||
        reg.isEmpty) {
      return;
    } else if (screenController.stringOfimg.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Choose an image'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
      ));
    } else {
      final student = StudentModel(
        age: age,
        batch: batch,
        name: name,
        place: place,
        regNo: reg,
        image: screenController.stringOfimg,
      );
      screenController.addstudentData(student);
      Get.snackbar("Added", "Data added successfully", colorText: Colors.amber);
      screenController.allStudentslist();
      clearFields();
      Get.offAll(() => HomeScreen());
    }
  }

  void clearFields() {
    _nameController.text = '';
    _ageController.text = '';
    _placeController.text = '';
    _batchController.text = '';
    _regController.text = '';
    screenController.stringOfimg = '';
  }
}
