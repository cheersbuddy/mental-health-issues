import 'package:flutter/material.dart';
import 'package:mindtales/screens/questionnaire_info_screen.dart';
import 'package:mindtales/screens/result_screen_listview.dart';
import 'package:mindtales/screens/support_onboarding_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          children: [
            const Text('Mind Tales',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            const SizedBox(height: 40,),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const QuestionnaireInfoScreen();
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color(0xFFA995D9),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),

                  child: Row(
                    children: [
                      const Expanded(flex:2,child: Align(alignment: Alignment.bottomLeft,child: Text('Questionnaire',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),))),
                      Expanded(child: Image.asset('assets/checklist.png'))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const ResultScreenListView();
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF8CD69),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    children: [
                      const Expanded(flex:2,child: Align(alignment: Alignment.bottomLeft,child: Text('Result',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),))),
                      Expanded(child: Image.asset('assets/results.png'))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const SupportOnboardingScreen();
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color(0xFF4741A5),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    children:  [
                      const Expanded(flex:2,child: Align(alignment: Alignment.bottomLeft,child: Text('Support & Resources',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),))),
                      Expanded(child: Image.asset('assets/support.png'))
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}
