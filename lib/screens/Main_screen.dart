import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_app/models/user_detailModels.dart';
import 'package:hostel_management_app/screens/MyHostelScreen.dart';
import 'package:hostel_management_app/screens/Welcome_screen.dart';
import 'package:hostel_management_app/screens/add_hostel.dart';
import 'package:hostel_management_app/screens/find_hostel_screen.dart';
import 'package:hostel_management_app/services/cloud_firestor.dart';
import 'package:hostel_management_app/widgets/signUp_Button.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserModel model=UserModel(fullname:"" , username: "", email: "");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Get.snackbar("Congrats", "init called");
    getdata();
  }

 void getdata() async {
     
    model = await CloudFireStoreMethods.getNameAndEmail();
  }
  

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      key: Scaffoldkey,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
       
      SizedBox(height: 8.h,),
        GestureDetector(
          onTap: () {
            Scaffoldkey.currentState!.openDrawer();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(22.h),
                boxShadow: []),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 2.h,
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  (Icons.menu),
                  color: Colors.black,
                  size: 4.h,
                ),
              ),
            ),
          ),
        ),
        Column(
          
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           Text(
                     "Find Hostel Near You",
                     style: TextStyle(fontSize: 20,fontFamily:"choco"),
                   ),

        SizedBox(height: 5.h,),
        Container(
          height: 7.h,
                 width: 40.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            colors: [
            Color(0xffFDFCFB),
            Color(0xffE2D1C3),
          ]),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(90),topRight: Radius.circular(90)),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(model.fullname==null?"": model.fullname.toString(),style: TextStyle(fontSize: 3.h,fontWeight: FontWeight.bold,color: Colors.black),),
            Text(model.email==null?"": model.email.toString(),style: TextStyle(fontSize: 2.h,fontWeight: FontWeight.bold,color: Colors.black))
          ]),
         
        ),
        
        ],),
        SizedBox(height: 5.h,),
        Row(
          
          children: [
          
         Expanded(child: Padding(
           padding: EdgeInsets.all(1.h),
           child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FindHostelScreen(),));
            },
            child: myContainer(imgUrl: "images/hostel2.png", text: "Hostels")),
         )),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHostelScreen(),));
                },
                 child: myContainer(
                  imgUrl: "images/myhostel.png",
                  text: "My Hostel",
                 ),
               ),
             ),
           )
        ],),
        SizedBox(height: 2.h,),
        Row(children: [
          Expanded(child: myContainer(imgUrl: "images/chats.png", text: "Chats")),
          
            Expanded(child: GestureDetector(
              onTap: () async{
               await FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
               });
              },
              child: myContainer(imgUrl: "images/logout.png", text: "Log out"))),
        ],),
        SizedBox(height: 1.h,),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddHostelScreen(),));
          },
          child: SignUpButton(color: Colors.yellowAccent, text: "Add Hostel")),
      ]),
    );
  }
}

class myContainer extends StatelessWidget {
 final String imgUrl;
 final String text;

  const myContainer({super.key, required this.imgUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
       width: 43.w,
       height: 25.h,
       
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(20)
       ),
       child: Column(children: [
           Expanded(
            flex: 2,
            child: Image.asset("$imgUrl",fit: BoxFit.cover,)),
           
           Expanded(
            flex: 1,
            child: Text("$text",style: TextStyle(fontSize: 22,fontFamily: "Anton"),))
       ]),
       ),
    );
  }
}
