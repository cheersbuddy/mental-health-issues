import 'package:flutter/material.dart';

class UnbordingContent {
  String title;
  String ? discription;
  final Color headingColor;
  UnbordingContent({required this.title,this.discription,required this.headingColor});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Welcome to Mind Tales',
      headingColor: const Color(0xFFA995D9),
  ),
  UnbordingContent(
      title: 'Lets get started',
      discription: "Our app helps you identify and understand your mental health issues and offer a"
          "confidential and secure way to explore your mental health.",
    headingColor: const Color(0xFF4741A5),
  ),
  UnbordingContent(
      title: 'How It Works',
      discription: "Our app uses evidence-based assessments to help diagnose common mental health issues such as anxiety, depression, and stress. Based on your assessment results"
          "we provide personalized recommendations for treatment and provide you information to connect with professionals who can help.",
    headingColor: const Color(0xFFF8CD69),
  ),
];