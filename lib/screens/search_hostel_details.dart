import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
class SearchHostelDetail extends StatefulWidget {
   final String Name;
   final String City;
   final String totalRoom;
   final String oneBedprice;
   final String TwoBedP;
   final String url;
   final String phone;
   final String desc;
  

 SearchHostelDetail({super.key, required this.desc,required this.phone,required this.url, required this.Name,required this.City, required this.totalRoom,required this.oneBedprice,required this.TwoBedP});


  @override
  State<SearchHostelDetail> createState() => _SearchHostelDetailState();
}

class _SearchHostelDetailState extends State<SearchHostelDetail> {
 
  @override
  Widget build(BuildContext context) {
    // ConvertToAddress();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(border: Border.all(color: Colors.red),image: DecorationImage(image: NetworkImage(widget.url,),fit: BoxFit.fill)),
              ),
            ),
        
            ListTile(leading: Text(widget.Name,style: TextStyle(fontFamily: "Anton",fontSize: 18),
            
            ),
            trailing: Text(widget.City),
            ),
            ListTile(leading: Text("Phone",style: TextStyle(fontFamily: "Anton",fontSize: 18),
            
            ),
            trailing: Text("${widget.phone}",),
            ),
        
            Column(children: [
              Text("Description",style: TextStyle(fontFamily: "Anton",fontSize: 18),),
              Text(widget.desc),
            ],),
        
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Column(children: [
              Row(children: [
                Text("Total Room : ",style: TextStyle(fontFamily: "Anton",fontSize: 18),),
                Text(widget.totalRoom),
              ],),
               Row(children: [
                Text("One Bed Room Price : ",style: TextStyle(fontFamily: "Anton",fontSize: 18),),
                Text(widget.oneBedprice),
              ],),
               Row(children: [
                Text("Two Bed Price : ",style: TextStyle(fontFamily: "Anton",fontSize: 18),),
                Text(widget.TwoBedP),
              ],),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.040,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Row(children: [
                  Expanded(
                    child: MyFindButtons(icon: Icons.location_on,color: Colors.lightBlue,)),
                    SizedBox(width: 20,),
                     Expanded(
                    child: GestureDetector(
                      onTap: (){
                        sendSMS(message: "" , recipients: [widget.phone]);
                      },
                      child: MyFindButtons(icon: Icons.message,color: Colors.lightBlue,))),
                    SizedBox(width: 20,),
                     Expanded(
                       child: GestureDetector(
                        onTap: makingPhoneCall,
                         child: MyFindButtons(icon: Icons.call,color: Colors.red,),
                       ),
                     ),
                    
                  
                ],),
              ),
            ],),
          ]),
        ),
      ),
    );
  }
makingPhoneCall() async {
  var url = Uri.parse("tel:${widget.phone}");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

 sending_SMS(String sms , List<String> list_receipents) async {
 String send_result = await sendSMS(message:sms, recipients: list_receipents)
        .catchError((err) {
      print(err);
    });
print(send_result);
}
}

class MyFindButtons extends StatelessWidget {
  final IconData icon;
 final Color color;

  const MyFindButtons({super.key, required this.icon, required this.color});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      color: Colors.yellow,
      
      ),
      child: Icon(icon,color:color),
    );
  }
}

