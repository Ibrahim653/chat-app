import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
   CustomButton({required this.text,this.onTap}) ;
String text;
VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child:  Center(
          child: Text(text),
        ),
      ),
    );
  }
}
