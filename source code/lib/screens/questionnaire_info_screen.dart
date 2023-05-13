import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mindtales/screens/survey_screen.dart';

class QuestionnaireInfoScreen extends StatefulWidget {
  const QuestionnaireInfoScreen({Key? key}) : super(key: key);

  @override
  State<QuestionnaireInfoScreen> createState() => _QuestionnaireInfoScreenState();
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
                    generate random questionnaire of 5 to 10 questions for a given mental health prompt which will use to detect phobia type and it's level. 
                    response must only contain questions. There should be No extra linebreak, No introduction, and No numbering in response, and following should be the format: do you fell scared?.It must accept yes and no answers only.
            """},
            {"role": "user", "content": prompt}
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

class _QuestionnaireInfoScreenState extends State<QuestionnaireInfoScreen> {
  double screenHeight=0.0;
  double screenWidth=0.0;
  final _textController = TextEditingController();

  late bool isLoading=false;

  @override
  void initState() {
    super.initState();
    isLoading = false;
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
              Text('Generating your questionnaire\nplease wait...',textAlign: TextAlign.center,)
            ],
          ),)
          : Container(
        margin: EdgeInsets.only(top: screenHeight/18,left: 20,right: 20,bottom: screenHeight/26),
        child: ListView(
          children: [
            const Align(alignment:Alignment.center,child: Text('Mind Tales',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
            SizedBox(height: screenHeight/30,),
            Container(
              height: screenHeight/2,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFFA995D9),
                  ),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),

              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Expanded(flex:2,child: Align(alignment: Alignment.topLeft,child: Text('Questionnaire',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),))),
                        Expanded(child: Align(alignment: Alignment.topRight,child: Image.asset('assets/checklist.png')))
                      ],
                    ),
                  ),
                  const Expanded(flex:2,child: Align(alignment: Alignment.centerLeft,child: Text('In this you will be given Multiple question.To Analyze and detect your phobia.',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),))),
                  const Expanded(child: Align(alignment: Alignment.centerLeft,child: Text('Start by telling how you feel about mental health.',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xFFA995D9)),))),
                ],
              ),
            ),
            SizedBox(height: screenHeight/40,),
            Container(
              height: screenHeight/7,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                    offset: Offset(2.0, 2.0),
                  )
                ],
              ),
              child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Type here..',
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                  )
              ),
            ),
            SizedBox(height: screenHeight/40,),
            SizedBox(
              height: screenHeight/11,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA995D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xFFA995D9))
                    )
                ),
                child: const Text('Continue'),
                onPressed: (){
                  setState(() {
                    isLoading = true;
                  });
                  var input = _textController.text ;
                  var temp_intput = _textController.text;

                  generateResponse(input).then((value) {
                    setState(() {
                      if (value == 'error'){
                        isLoading = false;
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Error in Generating response. Please contact app owner"),
                        ));
                      }
                      else{
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                          return SurveyScreen(questions: value);
                        }));

                      }

                    });
                  });

                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
