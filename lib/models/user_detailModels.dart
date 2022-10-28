import 'package:flutter/material.dart';
class UserModel{
  final String? fullname;
  final String? username;
  final String? email;

 UserModel({required this.fullname,required this.username,required this.email});
  Map<String,dynamic> getJson()=>{
    "fullname":fullname,
    "username":username,
    "email":email
  };

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(fullname: json["fullname"], username:json["username"] , email: json["email"]);
  }
  
}
