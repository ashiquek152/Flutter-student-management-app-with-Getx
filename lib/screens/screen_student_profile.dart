import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_app/db/models/student_model.dart';
import 'package:student_app/widgets/text_filed.dart';

class ProfileStudent extends StatelessWidget {
  const ProfileStudent({Key? key, required this.data}) : super(key: key);

  final StudentModel data;

  @override
  Widget build(BuildContext context) {
    var encodedimage = data.image;
    var image = const Base64Decoder().convert(encodedimage);
    return Scaffold(
      backgroundColor: scaffoldBG,
      appBar: AppBar(
        title: const Text('Student Details'),
        backgroundColor: scaffoldBG,
      ),
      body: SafeArea(
          child: Container(
        width: 350,
        height: 400,
        margin:
            const EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundImage: MemoryImage(image),
              radius: 70,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name    : ${data.name.toUpperCase()}',
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
                Text(
                  'Age       : ${data.age}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Place    : ${data.place.toUpperCase()}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Batch    : ${data.batch.toUpperCase()}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'RegNo  : ${data.regNo.toUpperCase()}',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
