import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mindtales/screens/support_and_resources_screen.dart';
import 'package:mindtales/screens/survey_screen.dart';

class SupportOnboardingScreen extends StatefulWidget {
  const SupportOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<SupportOnboardingScreen> createState() => _SupportOnboardingScreenState();
}



class _SupportOnboardingScreenState extends State<SupportOnboardingScreen> {
  double screenHeight=0.0;
  double screenWidth=0.0;


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: screenHeight/18,left: 20,right: 20,bottom: screenHeight/26),
        child: Column(
          children: [
            const Align(alignment:Alignment.center,child: Text('Support & Resources',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
            SizedBox(height: screenHeight/30,),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF4741A5),
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                ),

                child: Column(
                  children: const [
                    Expanded(child: Align(alignment: Alignment.centerLeft,child: Text("It's important to remember that seeking help for mental health issues is a sign of strength, not weakness. If you or someone you know is struggling with anxiety, depression, or phobias, don't hesitate to reach out for help.",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xFF4741A5)),))),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight/40,),
            SizedBox(
              height: screenHeight/11,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4741A5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xFF4741A5))
                    )
                ),
                child: const Text('Continue'),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const SupportAndResourcesScreen();
                  }));
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
