import 'dart:developer';
import 'dart:typed_data';

import 'package:country_phone_code_picker/controller/country_controller.dart';
import 'package:country_phone_code_picker/core/country_phone_code_picker_widget.dart';
import 'package:country_phone_code_picker/models/country.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hostel_management_app/models/addHostel.dart';
import 'package:hostel_management_app/screens/Create_account.dart';
import 'package:hostel_management_app/screens/Main_screen.dart';
import 'package:hostel_management_app/screens/Welcome_screen.dart';
import 'package:hostel_management_app/services/authentication_services.dart';
import 'package:hostel_management_app/services/cloud_firestor.dart';
import 'package:hostel_management_app/utils/utils.dart';
import 'package:hostel_management_app/widgets/MyTextfieldwidget.dart';
import 'package:hostel_management_app/widgets/signUp_Button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
final ImagePicker imgpicker = ImagePicker();

class AddHostelScreen extends StatefulWidget {
  const AddHostelScreen({Key? key}) : super(key: key);

  @override
  State<AddHostelScreen> createState() => _AddHostelScreenState();
}

class _AddHostelScreenState extends State<AddHostelScreen> {
  
 Uint8List? imagefiles;
   Position? position;
    
      TextEditingController WardanNameConroller=TextEditingController();
  TextEditingController HostelNameConroller=TextEditingController();
    TextEditingController CityNameConroller=TextEditingController();
      TextEditingController EmailConroller=TextEditingController();
        TextEditingController NumberConroller=TextEditingController();
          TextEditingController DescriptionConroller=TextEditingController();
   TextEditingController tRoomConroller=TextEditingController();
    TextEditingController NoOfBadConroller=TextEditingController();
     TextEditingController TwoBedConroller=TextEditingController();
     Uint8List? images;

     @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            IconButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(),));
            }, icon: Icon(Icons.arrow_back,size: 30,)),
            Column(children: [
              Text("ADD YOUR\n Hostel  ",style: TextStyle(fontFamily: "Anton",fontSize: 30,fontWeight: FontWeight.bold),),
            ],),
           
            MyTextFieldWidget(controler: WardanNameConroller,hintText: "Wardan",icon: Icons.edit),
            MyTextFieldWidget(controler: HostelNameConroller,hintText: "Hostel Name",icon: Icons.edit),
           Text("Select City",style: TextStyle(fontSize: 16,fontFamily: "Anton"),),
           
           MyTextFieldWidget(controler: CityNameConroller,hintText: "Select City",icon: Icons.edit),
            MyTextFieldWidget(controler: EmailConroller,hintText: "Email",icon: Icons.email),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal:8.0),
            //   child: CountryPhoneCodePicker.withDefaultSelectedCountry(
            //     width: double.infinity,
            //     showName: true,
            //     showPhoneCode: true,
            //    defaultCountryCode:
            //    Country(name: 'Pakistan', countryCode: 'pk', phoneCode: '+92'),
            //    borderRadius: 5,
            //    borderWidth: 1,
            //   borderColor: Colors.grey,
            //   style: const TextStyle(fontSize: 16),
            //   searchBarHintText: 'Search by name',
            //   ),
            // ),
             MyTextFieldWidget(inputType: TextInputType.phone,controler: NumberConroller,hintText: "Phone",icon: Icons.phone_android_outlined),
            MyTextFieldWidget(maxline: 4,controler: DescriptionConroller,hintText: "Description",icon: Icons.edit),
             Row(
               children: [
                Expanded(child: Text("Total No Of Room",style: TextStyle(fontFamily: "Anton",fontSize: 16),)),
                 Expanded(flex: 2,child: MyTextFieldWidget(controler: tRoomConroller,hintText: "Total Room")),
               ],
             ),

              Row(
               children: [
                Expanded(child: Text("One Bad Price",style: TextStyle(fontFamily: "Anton",fontSize: 16),)),
                 Expanded(flex: 2,child: MyTextFieldWidget(controler: NoOfBadConroller,hintText: "Total Bed")),
               ],
             ),
             Row(
               children: [
                Expanded(child: Text("Two Bed Room Price",style: TextStyle(fontFamily: "Anton",fontSize: 16),)),
                 Expanded(flex: 2,child: MyTextFieldWidget(controler: TwoBedConroller,hintText: "Two Bed Price")),
               ],
             ),
              Column(
                children: [
                  Text("Add Your Location",style: TextStyle(fontFamily: "Anton",fontSize: 16),),
                 
                  Center(child: GestureDetector(
              onTap: ()async{
                 position= await CloudFireStoreMethods.getlatlong();
                 log(position!.latitude.toString());
              },
              child: SignUpButton(color: Colors.yellowAccent,text: "Add Location",))),
                
                ],
              ),
             SizedBox(height: 10,),

             Column(
                children: [
                  Text("Add Images",style: TextStyle(fontFamily: "Anton",fontSize: 16),),
                 
                  Center(child: GestureDetector(
              onTap: ()async{
                Uint8List? list =
                  await Utils.pickImage();
                    if (list != null) {
                   setState(() {
                    images = list;
                    });
                   }
              },
              child: SignUpButton(color: Colors.yellowAccent,text: "Browse Images",))),
                
                ],
              ),
               SizedBox(height: 10,),
            Center(child: GestureDetector(
              onTap: ()async{
                
               String output= await CloudFireStoreMethods.uploadHostel(
                url: FirebaseAuth.instance.currentUser!.uid,
                image: images, 
                wardan: WardanNameConroller.text,
                 hostel: HostelNameConroller.text, 
                 city: CityNameConroller.text, 
                 email: EmailConroller.text,
                  number: NumberConroller.text, 
                  Description: DescriptionConroller.text, 
                  TRoom: tRoomConroller.text,
                   TBad: NoOfBadConroller.text,
                    TwoBadPrice: TwoBedConroller.text,
                     lat: position!.latitude,
                      longi: position!.longitude, 
                      );

                      if(output=="success"){
                        Get.snackbar("Congrats", "uploaded");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),));
                      }
                      else{
                        Get.snackbar("Error", "an Error Occured");
                      }
              },
              child: SignUpButton(color: Colors.yellowAccent,text: "Add Hostel",))),
           
            
                
          ],),
        ),
      ),
    );
  }

  // openImages() async {
  //   try {
  //     Uint8List? pickedfiles = await Utils.pickImage();
  //     //you can use ImageCourse.camera for Camera capture
  //     if (pickedfiles != null) {
  //       imagefiles = pickedfiles;

  //       setState(() {
  //         images = pickedfiles;
  //       });
  //     } else {
  //       print("No image is selected.");
  //     }
  //   } catch (e) {
  //     print("error while picking file.");
  //   }
  // }
}