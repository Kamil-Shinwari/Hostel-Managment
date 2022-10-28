import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hostel_management_app/models/addHostel.dart';
import 'package:hostel_management_app/models/user_detailModels.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CloudFireStoreMethods {
  static Future UploadDataToFireStor({required UserModel model}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(model.getJson());
  }

  static getNameAndEmail() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserModel model = UserModel.fromJson(snapshot.data() as dynamic);
    return model;
  }

 static Future<String> uploadHostel({
     required Uint8List? image,
    required String wardan,
    required String hostel,
    required String city,
    required String email,
    required String number,
    required String Description,
    required String TRoom,
    required String TBad,
    required String TwoBadPrice,
    required double lat,
    required double longi,
    required String url,
  }) async {
    String output = "Something went Wrong";
    if (wardan != "" &&
        hostel != "" &&
        city != "" &&
        email != "" &&
        number != null &&
        Description != "" &&
        TRoom != "" &&
        TBad !="" && TwoBadPrice!=""
        && lat!=null
        && longi!=null
        
        ) {
          try{
            String uid= FirebaseAuth.instance.currentUser!.uid;
            String url=await uploadImageToDatabase(image: image!, uid: uid);
           AddHostel addHostel= AddHostel(uid: uid, 
            wardan: wardan,
             hostel: hostel, 
             city: city,
              email: email, 
              number: number, 
              Description: Description, 
              TRoom: TRoom, 
              TBad: TBad,
               TwoBadPrice: TwoBadPrice,
                lat: lat, 
                longi: longi,
                 url: url);

            await FirebaseFirestore.instance.collection("addHostel")
            .doc(uid).
            set(addHostel.getJson()).then((value) {
              output="success";
            });
          }on FirebaseAuthException catch(e){
            output=e.message.toString();
                 Get.snackbar("error", output);
          }
        }else{
          output="plz make sure all field are not empty";
        }
        return output;
  }

  static Future<Position> getlatlong() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
    
  }

 static Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageref =
        FirebaseStorage.instance.ref().child('products').child(uid);
    UploadTask uploadTask = storageref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }
}
