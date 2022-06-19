import 'package:flutter/material.dart';

class Textfeild extends StatelessWidget {
  const Textfeild({
    Key? key,
    required TextEditingController regController,
    required this.hintText,
    this.keyboardType = TextInputType.name,
  })  : _regController = regController,
        super(key: key);

  final TextEditingController _regController;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            } else {
              return null;
            }
          },
          controller: _regController,
          decoration: InputDecoration(
              hintText: hintText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

const scaffoldBG = Colors.amber;
