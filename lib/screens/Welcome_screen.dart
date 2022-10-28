import 'package:flutter/material.dart';
import 'package:hostel_management_app/screens/Create_account.dart';
import 'package:hostel_management_app/screens/login_Screen.dart';
import 'package:hostel_management_app/widgets/simpleButton.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
          child: Center(
              child: Image.asset(
            "images/lock.png",
            width: 250,
            height: 250,
          )),
        ),
        Center(
            child: Text(
          "MAKE IT EASY",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, fontFamily: "Anton"),
        )),
        Column(
          children: [
            Text("We will Provide you an Easy Platform to Find",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            Text("Your Accomodation",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             GestureDetector(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
              },
              child: SimpleButton(color: Colors.yellowAccent, text: "LogIn")),
             GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountScreen(),));
              },
              child: SimpleButton(color: Colors.yellowAccent, text: "Sign Up")),
          ],
        ),
      ]),
    );
  }
}
