import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_app/screens/Create_account.dart';
import 'package:hostel_management_app/screens/Main_screen.dart';
import 'package:hostel_management_app/screens/Welcome_screen.dart';
import 'package:hostel_management_app/services/authentication_services.dart';
import 'package:hostel_management_app/widgets/MyTextfieldwidget.dart';
import 'package:hostel_management_app/widgets/signUp_Button.dart';
import 'package:hostel_management_app/widgets/simpleButton.dart';
class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
    TextEditingController EmailConroller=TextEditingController();
  TextEditingController PasswordConroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left:20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
            IconButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
            }, icon: Icon(Icons.arrow_back,size: 30,)),
            Column(children: [
              Text("LogIn ",style: TextStyle(fontFamily: "Anton",fontSize: 30,fontWeight: FontWeight.bold),),
            ],),
           
            MyTextFieldWidget(controler: EmailConroller,hintText: "Email",icon: Icons.email),
            MyTextFieldWidget(controler: PasswordConroller,hintText: "Password",icon: Icons.lock),
           
            Center(child: GestureDetector(
              onTap: ()async{
                await AuthenticationMethods.SignInUser(context, EmailConroller.text, PasswordConroller.text).then((value) {
                 
                });
              },
              child: SignUpButton(color: Colors.orange.shade300,text: "LogIn",))),
            SizedBox(height: 25,),
            Center(child: TextButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountScreen(),));
            }, child: Text("CREATE\nACCOUNT",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: "Anton"),))),
            
                
          ],),
        ),
      ),
    );
  }
}