import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hostel_management_app/screens/search_hostel_details.dart';
class HostelNearYou extends StatefulWidget {
  const HostelNearYou({Key? key}) : super(key: key);

  @override
  State<HostelNearYou> createState() => _HostelNearYouState();
}

class _HostelNearYouState extends State<HostelNearYou> {
  TextEditingController search=TextEditingController();
  String text="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hostel Near You",style: TextStyle(fontFamily: "Anton",color: Colors.black),),centerTitle: true,
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
      body:  Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 15),
          child: TextField(
            controller: search,
            onChanged: (String s){
              setState(() {
                
              });
            },
            decoration: InputDecoration(border: OutlineInputBorder(),fillColor: Colors.grey.shade300,filled: true),
          ),

        ),

        Column(children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("addHostel").where("city",isEqualTo: search.text).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            else{
              var query=snapshot.data;
              
             return ListView.builder(
              shrinkWrap: true,
              itemCount: query!.docs.length,
              itemBuilder: (context, index)  {
               
               
               return  GestureDetector(
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchHostelDetail(
                      Name: query.docs[index]["hostel"],
                      desc:query.docs[index]["Description"] ,
                       City: query.docs[index]["city"], 
                       totalRoom: query.docs[index]["TRoom"],
                        oneBedprice: query.docs[index]["TBad"],
                         TwoBedP: query.docs[index]["twoBadPrice"],
                         url:query.docs[index]["url"] ,
                         phone:query.docs[index]["number"] ,
                        //  lat:query.docs[index]["lat"]  ,
                        //  lon:query.docs[index]["longi"] ,
                         )));
                },
                 child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height *0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                      child: Row(children: [
                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                           
                           decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(query.docs[index]["url"])),
                            border: Border.all(color: Colors.blue)),
                            ),
                        )),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                             Text(query.docs[index]["hostel"],style: TextStyle(fontFamily: "Anton"),),
                            Text(query.docs[index]["Description"]),
                            Text(query.docs[index]["city"],style: TextStyle(fontFamily: "Anton"),)
                            ]),
                          ))
                      ]),
                    ),
                  ),
                 ),
               );
               
              });
            }
          },)
        ],),
      ]),
    );
  }
  Future convertData(double lat,double lon) async{
 var data1= await Geocoder2.getDataFromCoordinates(latitude: lat, longitude:lon, googleMapApiKey: "AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI");
 return data1;
  }
}