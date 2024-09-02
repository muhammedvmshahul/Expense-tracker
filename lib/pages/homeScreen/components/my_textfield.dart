import 'package:flutter/material.dart';



class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String? Function(String?)? validator;
  const MyTextField({super.key,required this.controller,this.hintText, this.labelText, this.hintStyle,this.labelStyle, required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
          hintStyle: hintStyle,
        labelStyle: labelStyle,
      ),
      validator: validator,

    );
  }
}
