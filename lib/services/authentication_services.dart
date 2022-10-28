import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_app/models/user_detailModels.dart';
import 'package:hostel_management_app/screens/Main_screen.dart';
import 'package:hostel_management_app/screens/login_Screen.dart';
import 'package:hostel_management_app/services/cloud_firestor.dart';

class AuthenticationMethods{
  
  CloudFireStoreMethods cloudFireStoreMethods=CloudFireStoreMethods();
 static Future SignUpUser(BuildContext context,String FullName,String UserName,String Email,String Password,String CPassword) async{
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
   
    FullName.trim();
    UserName.trim();
    Email.trim();
    Password.trim();
    CPassword.trim();

    if(FullName !=" " && UserName !="" && Email!="" && Password!="" && CPassword!=""){
      try{
         UserCredential credential =await firebaseAuth.createUserWithEmailAndPassword(email: Email, password: Password);
          UserModel userModel=UserModel(fullname: FullName, username: UserName, email: Email);
          if(credential.user !=null){
            await CloudFireStoreMethods.UploadDataToFireStor(model: userModel).then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
              Get.snackbar("Congrats", "User Created");
            });
 
          }
          
      
      }on FirebaseAuthException catch(e){
        Get.snackbar("Error", e.message.toString());
      }
    }else{
            Get.snackbar("Warning", "Plz Fill All Field");
          }

  }

static Future SignInUser( BuildContext context,String email, String password)async{
     FirebaseAuth firebaseAuth=FirebaseAuth.instance;
      email.trim();
      password.trim();
      if( password !="" && email != ""){
        
        try{
         await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
         
         Get.snackbar("Congrats", "User Sign In");
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),));
         });
         
        }on FirebaseAuthException catch(e){
          Get.snackbar("Error", e.message.toString());
        }
      }
      else{
        Get.snackbar("Warning", "Plz Fill All Field");
      }
      
  }

}