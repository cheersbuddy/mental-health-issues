import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mindtales/screens/home_screen.dart';
import 'package:mindtales/screens/support_and_resources_screen.dart';
import 'package:mindtales/screens/support_onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key,required this.question_answers}) : super(key: key);
  final String question_answers;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

Future<String> generateResponse(String prompt) async {

  const apiKey = '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';



  try{
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        'Authorization': 'Bearer $apiKey',
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          'temperature' :  0.65,
          "top_p": 1,
          'frequency_penalty' : 0,
          'presence_penalty' : 0.3,
          'max_tokens' : 2048,
          "model": 'gpt-3.5-turbo',
          "messages": [
            {"role": "system", "content": """
                    Analyze the prompt and predict what types of phobias user have and also it's level from 1 to 5.
                    your response must only look like this "You may have phobia phobia1,phobia2... "\n" Level "\n" 1 ".
                    and if no phobia is detected your response must only look like this "No phobia detected"

            """},
            {"role": "user", "content":  prompt}
          ]
        },
      ),
    );

    // Do something with the response

    Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    return jsonResponse["choices"][0]["message"]["content"];
  }catch(err){
    return 'error';
  }
}

class _ResultScreenState extends State<ResultScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<List<String>> _resultList;

  double screenHeight=0.0;
  double screenWidth=0.0;
  String result_phobia = "No detected" ;
  late bool isLoading=false;

  Future<void> addResult(String value) async {
    final SharedPreferences prefs = await _prefs;
    final List<String> resultList = prefs.getStringList('resultList') ?? [] ;
    resultList.add(value);
    setState(() {
      _resultList = prefs.setStringList('resultList', resultList).then((bool success) {
        return resultList;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = true;
    });
    generateResponse(widget.question_answers).then((value) {
      setState(() {
        if (value == 'error'){
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Error in Generating response. Please contact app owner"),
          ));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeScreen()
            ),
                (route) => false,
          );
        }
        else{
          isLoading = false;
          result_phobia = value;
          addResult(value);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: isLoading ? Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  const [
          CircularProgressIndicator(color: Color(0xFFA995D9),),
          Text('Generating your Result\nplease wait...',textAlign: TextAlign.center)
        ],
      ),) : Container(
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
                          Align(alignment: Alignment.topCenter,child: Text(result_phobia,textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
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
                          return const SupportOnboardingScreen();
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
