import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hostel_management_app/screens/Main_screen.dart';
import 'package:hostel_management_app/screens/Update_hostel_detail.dart';
import 'package:hostel_management_app/screens/add_hostel.dart';
import 'package:hostel_management_app/widgets/signUp_Button.dart';

class MyHostelScreen extends StatefulWidget {
  const MyHostelScreen({Key? key}) : super(key: key);

  @override
  State<MyHostelScreen> createState() => _MyHostelScreenState();
}

class _MyHostelScreenState extends State<MyHostelScreen> {
  bool IsNodata = true;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
            stream: 
            
            
            FirebaseFirestore.instance
                .collection("addHostel")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var document = snapshot.data;
                return document!.exists
                    ?
                     Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: double.infinity,
                            height: 350,
                            child: Image.network(
                              document.get("url"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange)),
                            child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Wardan",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Anton"),
                                        ),
                                        Text(
                                          document["wardan"],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "email",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Anton"),
                                        ),
                                        Text(document["email"]),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "city",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Anton"),
                                        ),
                                        Text(document["city"]),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Phone",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Anton"),
                                        ),
                                        Text(document["number"]),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rooms",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Anton"),
                                        ),
                                        Text(document["TRoom"]),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Description",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Anton"),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child:
                                                Text(document["Description"])),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateHostelDetail(),
                                              ));
                                        },
                                        child: Container(
                                          height: 80,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.edit,
                                            size: 60,
                                            color: Colors.lightBlue,
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection("addHostel")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .delete()
                                              .then((value) {
                                            Get.snackbar(
                                                "Successfully", "Deleted");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen(),
                                                ));
                                          });
                                        },
                                        child: Container(
                                          height: 80,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.delete,
                                            size: 60,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                      : Column(
                      
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  image: DecorationImage(
                                      image:
                                          AssetImage("images/myhostel.png"))),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height *0.025,
                          ),
                          Text(
                            "No records Found",
                            style: TextStyle(fontSize: 24, fontFamily: "Anton"),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height *0.025,
                          ),
                          Text(
                            "Sorry we did Not found any record \n with Your email, please add your \n hostel first ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500),
                          ),
                           SizedBox(
                            height: MediaQuery.of(context).size.height *0.025,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddHostelScreen(),));
                            },
                            child: SignUpButton(color: Colors.yellowAccent, text: "Add Hostel"))
                        ],
                      );
              }
            }),
      ),
    );
  }
}
