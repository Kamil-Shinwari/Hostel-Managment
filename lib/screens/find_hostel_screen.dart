import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management_app/screens/hostel_near_you.dart';
import 'package:hostel_management_app/widgets/signUp_Button.dart';
class FindHostelScreen extends StatefulWidget {
  const FindHostelScreen({Key? key}) : super(key: key);

  @override
  State<FindHostelScreen> createState() => _FindHostelScreenState();
}

class _FindHostelScreenState extends State<FindHostelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      child: Column(children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
         child: Image.asset("images/find.png",fit: BoxFit.fill,),
        ),

        SizedBox(height: MediaQuery.of(context).size.height *0.010,),

        Text("Find Your Hostel",style: TextStyle(color: Colors.deepPurple,fontFamily: "Anton",fontSize: 25),),
        SizedBox(height:MediaQuery.of(context).size.height *0.020 ,),
        Text("We will help you to find your Hostel",style: TextStyle(color: Colors.grey,fontSize: 20),),
       SizedBox(height:MediaQuery.of(context).size.height *0.020 ,),
       GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HostelNearYou(),));
        },
        child: SignUpButton(color: Colors.yellow, text: "Find Hostels"))

      ]),
    ),
    );
  }
}