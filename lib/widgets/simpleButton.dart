import 'package:flutter/material.dart';
class SimpleButton extends StatefulWidget {
 final Color color;
 final String text;

  SimpleButton({super.key,  required this.color, required this.text, });
  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        color:widget.color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
    
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(widget.text,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
      
    );
  }
}