import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/layout/welcome_screen.dart';
import 'package:quiz_app/quiz/quiz_screen.dart';
import 'package:quiz_app/result/result_screen.dart';
import 'package:quiz_app/utils/binding.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'quiz app',
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: ()=>WelcomeScreen()),
        GetPage(name: ResultScreen.routeName, page: ()=>ResultScreen()),
        GetPage(name: QuizScreen.routeName, page: ()=>QuizScreen()),
      ],
      home: WelcomeScreen(),
    );
  }
}
