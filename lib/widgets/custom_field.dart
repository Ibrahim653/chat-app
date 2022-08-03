import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({this.hinText, this.onChanged, this.obscureText = false});

  bool? obscureText;
  Function(String)? onChanged;
  String? hinText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'please enter all fields';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
