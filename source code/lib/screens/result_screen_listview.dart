import 'package:flutter/material.dart';
import 'package:mindtales/models/result_model.dart';
import 'package:mindtales/screens/resources_detail_screen.dart';
import 'package:mindtales/screens/result_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/resources.dart';


class ResultScreenListView extends StatefulWidget {
  const ResultScreenListView({Key? key}) : super(key: key);
  @override
  State<ResultScreenListView> createState() => _ResultScreenListViewState();
}

class _ResultScreenListViewState extends State<ResultScreenListView> {
  double screenHeight=0.0;
  double screenWidth=0.0;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<List<String>> _resultList;

  @override
  void initState() {
    super.initState();
    _resultList = _prefs.then((SharedPreferences prefs) {
      return prefs.getStringList('resultList') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50,left: 10,right: 10),
        child: Column(
          children: [
            const Text('Results',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),

            FutureBuilder<List<String>>(
                future: _resultList,
                builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Expanded(
                          child: SizedBox(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return  Column(
                                    children: [
                                      ListTile(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                            return ResultScreen2(result: snapshot.data![index]);
                                          }));

                                        },
                                        title: Text("Result ${index+1}"),
                                        trailing: const Icon(Icons.arrow_forward_ios),
                                      ),
                                      const Divider(),
                                    ],
                                  );
                                }),
                          ),
                        );
                      }
                  }
                })
          ],
        ),
      ),
    );
  }
}
