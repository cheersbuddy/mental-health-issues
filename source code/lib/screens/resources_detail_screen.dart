import 'package:flutter/material.dart';
import '../models/resources.dart';

class ResourcesDetailScreen extends StatefulWidget {
  const ResourcesDetailScreen({Key? key,required this.resources}) : super(key: key);
  final String resources;

  @override
  State<ResourcesDetailScreen> createState() => _ResourcesDetailScreenState();
}

class _ResourcesDetailScreenState extends State<ResourcesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 40),
        child: Column(
          children: [
            Text(widget.resources.split(RegExp(r'-|:'))[0],style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: const Color(0xFF4741A5),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),

                child: Column(
                  children: [
                    Expanded(
                      child: SelectableText(widget.resources,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
