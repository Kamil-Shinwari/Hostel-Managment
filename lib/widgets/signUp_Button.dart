import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SignUpButton extends StatefulWidget {
   final Color color;
 final String text;
 
 

  SignUpButton({super.key,  required this.color, required this.text, });

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal:8),
       child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 45,
        decoration: BoxDecoration(
          color:widget.color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
    
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(widget.text,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
        
    ),
     );
  }
}