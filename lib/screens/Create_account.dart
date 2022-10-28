import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_app/screens/Main_screen.dart';
import 'package:hostel_management_app/screens/login_Screen.dart';
import 'package:hostel_management_app/services/authentication_services.dart';
import 'package:hostel_management_app/widgets/MyTextfieldwidget.dart';
import 'package:hostel_management_app/widgets/signUp_Button.dart';
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController NameConroller=TextEditingController();
  TextEditingController UserNameConroller=TextEditingController();
  TextEditingController EmailConroller=TextEditingController();
  TextEditingController PasswordConroller=TextEditingController();
  TextEditingController CPasswordConroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left:20.0),
        child: SingleChildScrollView(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:MediaQuery.of(context).size.height * 0.1 ,),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back,size: 30,)),
            Column(children: [
              Text("CREATE ",style: TextStyle(fontFamily: "Anton",fontSize: 30,fontWeight: FontWeight.bold),),
              Text("Account ",style: TextStyle(fontFamily: "Anton",fontSize: 30,fontWeight: FontWeight.bold),),
            ],),
            MyTextFieldWidget(controler: NameConroller,hintText: "Full Name",icon: Icons.edit,),
            MyTextFieldWidget(controler: UserNameConroller,hintText: "UserName",icon: Icons.person,),
            MyTextFieldWidget(controler: EmailConroller,hintText: "Email",icon: Icons.email),
            MyTextFieldWidget(controler: PasswordConroller,hintText: "Password",icon: Icons.lock),
            MyTextFieldWidget(controler: CPasswordConroller,hintText: "ConFirm Password",icon: Icons.lock),
            Center(child: GestureDetector(
              onTap: () async{
                await AuthenticationMethods.SignUpUser(context, NameConroller.text, UserNameConroller.text, EmailConroller.text, PasswordConroller.text, CPasswordConroller.text).then((value) {
                 
                });
              },
              child: SignUpButton(color: Colors.yellowAccent, text: "SignUp"))),
            SizedBox(height: 25,),
            Center(child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
            }, child: Text("LogIn",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: "Anton"),))),
                
          ],),
        ),
      ),
    );
  }
}