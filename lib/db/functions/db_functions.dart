// import 'dart:convert';
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:student_app/db/models/student_model.dart';

// RxList<StudentModel> studentListmodel = <StudentModel>[].obs;
// RxList<StudentModel> searchData = <StudentModel>[].obs;

// // Future<void> addstudent(StudentModel value) async {
// //   final studentDataBase = await Hive.openBox<StudentModel>('Student_Data_Base');
// //   final id = await studentDataBase.add(value);
// //   value.id = id;
// //   studentDataBase.put(value.id, value);
// //   studentListmodel.clear();
// //   studentListmodel.addAll(studentDataBase.values);
// // }

// // // ignore: non_constant_identifier_names
// // Future<void> AllStudentslist() async {
// //   final studentDataBase = await Hive.openBox<StudentModel>('Student_Data_Base');
// //   studentListmodel.clear();
// //   studentListmodel.addAll(studentDataBase.values);
// // }

// // void deleteData(int id) async {
// //   final studentDataBase = await Hive.openBox<StudentModel>('Student_Data_Base');
// //   await studentDataBase.delete(id);
// //   AllStudentslist();
// // }

// // updateData(StudentModel value) async {
// //   final studentDataBase = await Hive.openBox<StudentModel>('Student_Data_Base');
// //   await studentDataBase.put(value.id, value);
// //   AllStudentslist();
// // }

// searchdata(String value) {
//   searchData.clear();
//   for (var items in studentListmodel) {
//     if (items.name.toString().toLowerCase().contains(value.toLowerCase())) {
//       StudentModel findings = StudentModel(
//         name: items.name,
//         age: items.age,
//         place: items.place,
//         batch: items.batch,
//         image: items.image,
//         regNo: items.regNo,
//       );
//       searchData.add(findings);
//     }
//   }
// }

// File?
//     image; //File is a reference to a file on  system storatge (path of the file)
// String stringOfimg = '';

// class ImageController extends GetxController {
//   pickimage() async {
//     final galleryImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (galleryImage == null) {
//       return;
//     } else {
//       image = File(galleryImage.path);
//       update();
//       final bytes = File(galleryImage.path).readAsBytesSync();
//       stringOfimg = base64Encode(bytes);
//     }
//   }
// }
