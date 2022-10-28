import 'package:flutter/material.dart';
class MyTextFieldWidget extends StatefulWidget {
  final String hintText;
 final IconData? icon;
 TextInputType? inputType;
 int? maxline;
 TextEditingController controler;
 MyTextFieldWidget({super.key,this.maxline,this.inputType, required this.controler,required this.hintText,  this.icon});

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: TextField(
        keyboardType: widget.inputType,
        maxLines: widget.maxline,
        controller: widget.controler,
        decoration: InputDecoration(
          label:Text( widget.hintText,style: TextStyle(color: Colors.black),),
          focusedBorder:OutlineInputBorder() ,
          focusColor: Colors.black,
          prefixIcon: Icon(widget.icon,color: Colors.black,),
          border: OutlineInputBorder()),
      ),
    );
  }
}