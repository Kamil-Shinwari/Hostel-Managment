import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_app/screens/MyHostelScreen.dart';
import 'package:hostel_management_app/widgets/signUp_Button.dart';

class UpdateHostelDetail extends StatefulWidget {
  const UpdateHostelDetail({Key? key}) : super(key: key);

  @override
  State<UpdateHostelDetail> createState() => _UpdateHostelDetailState();
}

class _UpdateHostelDetailState extends State<UpdateHostelDetail> {
  TextEditingController wardanController = TextEditingController();
  TextEditingController HostelController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController descripController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController TotalRoomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff82eedd),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Update Hostel Info",
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  Color(0xff5EFCE8),
                  Color(0xff736EFE),
                ])),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
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
              wardanController.text = document!.get("wardan");
              HostelController.text = document.get("hostel");
              emailController.text = document.get("email");
              CityController.text = document.get("city");
              descripController.text = document.get("Description");
              PhoneController.text = document.get("number");
              TotalRoomController.text = document.get("TRoom");
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: wardanController,
                    ),
                    TextField(
                      controller: HostelController,
                    ),
                    TextField(
                      controller: emailController,
                    ),
                    TextField(
                      controller: CityController,
                    ),
                    TextField(
                      maxLines: 3,
                      controller: descripController,
                    ),
                    TextField(
                      controller: PhoneController,
                    ),
                    TextField(
                      controller: TotalRoomController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () async {
                          String wardan = wardanController.text;
                          String hostel = HostelController.text;
                          String emails = emailController.text;
                          String cityt = CityController.text;
                          String desc = descripController.text;
                          String numbers = PhoneController.text;
                          String totlan = TotalRoomController.text;

                          if (wardan != "" &&
                              hostel != "" &&
                              emails != "" &&
                              cityt != "" &&
                              desc != " " &&
                              numbers != "" &&
                              totlan != "") {
                                try{
                                  await FirebaseFirestore.instance
                                  .collection("addHostel")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                    "wardan":wardanController.text,
                                    "hostel":HostelController.text,
                                    "email":emailController.text,
                                    "city":CityController.text,
                                    "Description":descripController.text,
                                    "number":PhoneController.text,
                                    "TRoom":TotalRoomController.text
                                  }).then((value) {
                                    Get.snackbar("successfully", "Updated");
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHostelScreen(),));
                                  });
                                }catch(e){
                                  Get.snackbar("error", e.toString());
                                }
                              
                              }

                        },

                        child: SignUpButton(
                            color: Colors.yellowAccent, text: "Update")),
                  ],
                ),
              );
            }
          },
        ));
  }
}
