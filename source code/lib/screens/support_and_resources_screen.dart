import 'package:flutter/material.dart';
import 'package:mindtales/screens/resources_detail_screen.dart';
import '../models/resources.dart';

class SupportAndResourcesScreen extends StatefulWidget {
  const SupportAndResourcesScreen({Key? key}) : super(key: key);

  @override
  State<SupportAndResourcesScreen> createState() => _SupportAndResourcesScreenState();
}

class _SupportAndResourcesScreenState extends State<SupportAndResourcesScreen> {
  double screenHeight=0.0;
  double screenWidth=0.0;

  final List<Map<String, dynamic>> resources = resourcesList;
  String dropdownValue = 'Show All';
  List<String> sortedList = [];
  @override
  void initState() {
    sortedList = List.from(resources.map((i) => i['resources']).expand((list) => list).toList());
    sortedList.sort((a, b){ //sorting in ascending order
      return a.compareTo(b);
    });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    List<String> dropMenuItemList = (['Show All'] + List.from(resources.map((i) => i['country'])));
    int _index = 0;

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50,left: 10,right: 10),
        child: Column(
          children: [
            const Text('Support & Resources',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left:30, right:30),
              decoration: BoxDecoration(
                  color:const Color(0xFF4741A5), //background color of dropdown button
                  border: Border.all(color: Colors.black38, width:3), //border of dropdown button
                  borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                  boxShadow: const <BoxShadow>[ //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]
              ),

              child: DropdownButton<String>(
                // Step 3.
                value: dropdownValue,
                // Step 4.
                items: dropMenuItemList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (String? newValue) {
                  setState(() {
                    _index = dropMenuItemList.indexOf(newValue!);
                    dropdownValue = newValue!;
                    setState(() {
                      if (_index == 0){
                        sortedList = List.from(resources.map((i) => i['resources']).expand((list) => list).toList());
                        sortedList.sort((a, b){ //sorting in ascending order
                          return a.compareTo(b);
                        });
                      }
                      else
                      {
                        sortedList = resources[_index-1]['resources'];
                        sortedList.sort((a, b){ //sorting in ascending order
                          return a.compareTo(b);
                        });
                      }
                    });
                  });
                },
                icon: const Padding( //Icon at tail, arrow bottom is default icon
                    padding: EdgeInsets.only(left:20),
                    child:Icon(Icons.arrow_downward)
                ),
                iconEnabledColor: Colors.white, //Icon color
                style: const TextStyle(  //te
                    color: Colors.white, //Font color
                    fontSize: 20 //font size on dropdown button
                ),

                dropdownColor: const Color(0xFF4741A5), //dropdown background color
                underline: Container(), //remove underline
                isExpanded: true,

              ),
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                    itemCount: sortedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  Column(
                        children: [
                          ListTile(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return ResourcesDetailScreen(resources: sortedList[index],);
                              }));
                            },
                            title: Text(sortedList[index].split(RegExp(r'-|:'))[0]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                          const Divider(),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
