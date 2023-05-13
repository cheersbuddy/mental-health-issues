import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mindtales/screens/home_screen.dart';
import 'package:mindtales/screens/support_and_resources_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen2 extends StatefulWidget {
  ResultScreen2({Key? key,required this.result}) : super(key: key);
  final String result;

  @override
  State<ResultScreen2> createState() => _ResultScreen2State();
}

class _ResultScreen2State extends State<ResultScreen2> {

  double screenHeight=0.0;
  double screenWidth=0.0;


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 40),
        child: Column(
          children: [
            const Text('Result',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            const SizedBox(height: 40,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Color(0xFFF8CD69),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),

                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Spacer(flex:2,),
                          Expanded(child: Align(alignment: Alignment.topRight,child: Image.asset('assets/checklist.png')))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListView(
                        children: [
                          const Align(alignment: Alignment.topCenter,child: Text('DIAGNOSED PHOBIA \n',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),)),
                          Align(alignment: Alignment.topCenter,child: Text(widget.result,textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: screenHeight/11,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Color(0xFFA995D9))
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.arrow_back,color: Color(0xFFA995D9),),
                          Text('Back to home',style: TextStyle(color: Color(0xFFA995D9)),),
                        ],
                      ),
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()
                          ),
                              (route) => false,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: SizedBox(
                    height: screenHeight/11,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4741A5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Color(0xFF4741A5))
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text('Resources'),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return const SupportAndResourcesScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
