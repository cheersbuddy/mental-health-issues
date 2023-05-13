import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindtales/models/survey_model.dart' as survey_model;
import 'package:mindtales/screens/home_screen.dart';
import 'package:mindtales/screens/result_screen.dart';
import 'package:mindtales/screens/support_onboarding_screen.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:mindtales/models/result_model.dart' as result_model;


class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key,required this.questions,}) : super(key: key);
  final String questions;


  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {

  late List<String> questions_list;

  @override
  Widget build(BuildContext context) {
    var _context = context;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                FutureBuilder<Task>(
                  future: getJsonTask(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data != null) {
                      final task = snapshot.data!;
                      return Expanded(
                        child: SurveyKit(
                          onResult: (SurveyResult result) {

                            if (result.finishReason.toString() == 'FinishReason.COMPLETED'){
                              final jsonResult = result.toJson();
                              result_model.Result resulobj = result_model.Result(results: []) ;

                              for (int i = 0;i<jsonResult["results"].length;i++ ){
                                resulobj.results!.add(result_model.Results(question: questions_list[i],answer: jsonResult["results"][i]["results"][0]["valueIdentifier"]));
                              }
                              final result_json = jsonEncode(resulobj.toJson());
                              print(jsonEncode(result_json));

                              Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (_context){
                                return ResultScreen(question_answers: jsonEncode(result_json),);
                              }));

                            }
                            else{
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_context) => const HomeScreen()
                                ),
                                    (route) => false,
                              );
                            }


                          },
                          task: task,
                          showProgress: true,
                          localizations: const {
                            'cancel': 'Cancel',
                            'next': 'Next',
                          },
                          themeData: Theme.of(context).copyWith(
                            primaryColor: const Color(0xFFA995D9),
                            appBarTheme: const AppBarTheme(
                              color: Colors.white,
                              iconTheme: IconThemeData(
                                color: const Color(0xFFA995D9),
                              ),
                              titleTextStyle: TextStyle(
                                color: const Color(0xFFA995D9),
                              ),
                            ),
                            iconTheme: const IconThemeData(
                              color: const Color(0xFFA995D9),
                            ),
                            textSelectionTheme: const TextSelectionThemeData(
                              cursorColor: const Color(0xFFA995D9),
                              selectionColor: const Color(0xFFA995D9),
                              selectionHandleColor: const Color(0xFFA995D9),
                            ),
                            cupertinoOverrideTheme: const CupertinoThemeData(
                              primaryColor: const Color(0xFFA995D9),
                            ),
                            outlinedButtonTheme: OutlinedButtonThemeData(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  const Size(150.0, 60.0),
                                ),
                                side: MaterialStateProperty.resolveWith(
                                      (Set<MaterialState> state) {
                                    if (state.contains(MaterialState.disabled)) {
                                      return const BorderSide(
                                        color: Colors.grey,
                                      );
                                    }
                                    return const BorderSide(
                                      color: const Color(0xFFA995D9),
                                    );
                                  },
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                textStyle: MaterialStateProperty.resolveWith(
                                      (Set<MaterialState> state) {
                                    if (state.contains(MaterialState.disabled)) {
                                      return Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                        color: Colors.grey,
                                      );
                                    }
                                    return Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                      color: const Color(0xFFA995D9),
                                    );
                                  },
                                ),
                              ),
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(
                                  Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: const Color(0xFFA995D9),
                                  ),
                                ),
                              ),
                            ),
                            textTheme: const TextTheme(

                              displayMedium: TextStyle(
                                fontSize: 28.0,
                                color: Colors.black,
                              ),
                              headlineSmall: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              bodyMedium: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                              titleMedium: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),

                            ),

                            inputDecorationTheme: const InputDecorationTheme(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            colorScheme: ColorScheme.fromSwatch(
                              primarySwatch: Colors.purple,
                            )
                                .copyWith(
                              onPrimary: Colors.white,
                            )
                                .copyWith(background: Colors.white),
                          ),
                          surveyProgressbarConfiguration: SurveyProgressConfiguration(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      );
                    }
                    return const CircularProgressIndicator.adaptive(backgroundColor: Colors.red,);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Task> getJsonTask() async {
    questions_list = widget.questions.split(RegExp(r'\||\n'));

    var survey_obj = survey_model.Survey(id: "Anxietysurvey",type: "navigable",steps:
    [

    ]);

    for( var i = 0 ; i<questions_list.length ; i++ ) {
      survey_obj.steps!.add(survey_model.Steps(
          stepIdentifier: survey_model.StepIdentifier(id:'${i+2}'),
          type: "question",
          text: questions_list[i],
          answerFormat: survey_model.AnswerFormat(
              type: "bool",
              positiveAnswer: "Yes",
              negativeAnswer: "No",
              result: "POSITIVE"
          )
      ));
    }

    var jsontext = survey_obj.toJson();
    return Task.fromJson(jsontext);
  }
}