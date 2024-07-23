import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/Start_screen.dart';
import 'package:quiz_app_flutter/data/question_ans.dart';
import 'package:quiz_app_flutter/quiz_screens.dart';
import 'package:quiz_app_flutter/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // Widget activeScreen =  StartScreen(switchScreen);  // this is not possible because the veriable and method creation happens
  // at the same time to avoid that we can use init method

  // Widget? activeScreen ;

  // @override
  // void initState() { // this method will be executed first when the object of the class is created
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }
  // another way using ternary operator

  var activeScreen = 'start_screen';
  List<String> selectedAwnsers = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'quiz_questions';
    });
  }

  void chooseAnswer(String answer) {
    selectedAwnsers.add(answer);
    if (selectedAwnsers.length == questions.length) {
      setState(() {
        activeScreen = 'result_screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAwnsers = [];
      activeScreen = 'quiz_questions';
    });
  }

  Widget routing() {
    if (activeScreen == 'result_screen') {
      return ResultScreen(
        chooseAnswer: selectedAwnsers,
        restartQuiz: restartQuiz,
      );
    } else if (activeScreen == 'start_screen') {
      return StartScreen(switchScreen);
    } else {
      return QuizScreens(
        onSelectedAnswers: chooseAnswer,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 88, 3, 245),
                Color.fromARGB(255, 116, 39, 112)
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child:
              // activeScreen,

              // another way
              routing(),
        ),
      ),
    );
  }
}
