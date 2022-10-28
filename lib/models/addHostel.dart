import 'package:flutter/material.dart';

class AddHostel {
   String wardan;
   String hostel;
  String city;
   String email;
   String number;
  String Description;
  String TRoom;
   String TBad;
   String TwoBadPrice;
  double lat;
   double longi;
   String url;
   String uid;
AddHostel({
  required this.uid,
  required this.wardan,
  required this.hostel,
  required this.city,
  required this.email,
  required this.number,
  required this.Description,
  required this.TRoom,
  required this.TBad,
  required this.TwoBadPrice,
  required this.lat,
  required this.longi,
  required this.url
});
  



  Map<String, dynamic> getJson() {
    return {
      "uid":uid,
      "wardan": wardan,
      "hostel": hostel,
      "city": city,
      "email": email,
      "number": number,
      "Description": Description,
      "TRoom": TRoom,
      "TBad": TBad,
      "twoBadPrice": TwoBadPrice,
      "lat": lat,
      "longi": longi,
      "url": url
    };
  }

  factory AddHostel.getModelFromJson(Map<String, dynamic> json) {
    return AddHostel(
      uid: json["uid"],
      wardan:json["wardan"], hostel:json["hostel"], city:json["city"],
     email:json["email"],
      number:json["number"],
       Description:json["Description"],
        TRoom:json["TRoom"],
        TBad:json["TBad"],
         TwoBadPrice:json["TwoBadPrice"],
          lat:json["lat"], 
          longi:json["longi"],
           url:json["url"]);
  }
}
