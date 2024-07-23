import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/ReusableElevatedButton/answer.dart';
import 'package:quiz_app_flutter/data/question_ans.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreens extends StatefulWidget { // Widget Class
  const QuizScreens({
    super.key,
    required this.onSelectedAnswers, // this accept and maps the funtion
  });

  final void Function(String answer) onSelectedAnswers;
  @override
  State<QuizScreens> createState() => _QuizScreensState();
}

class _QuizScreensState extends State<QuizScreens> {  // state class
  var currentQuestionIndex = 0;

  void awnserQuestion(String selectedAwnsers) {
    widget.onSelectedAnswers(selectedAwnsers);  // widget property is used inside state class to access the states of widget class
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final curreentQuestion = questions[currentQuestionIndex];
    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            curreentQuestion.text,
            style: GoogleFonts.eduNswActFoundation(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 25,
          ),
          // ... is Spread Operator used to pull all the values from the list or
          // Iterable and instead place them as comma-seperated values
          ...curreentQuestion.shuffledAnswers.map(
                (awnser) => AnswerButton(
                  awnsertext: awnser,
                  ontap: () {
                    awnserQuestion(awnser);
                  },
                ),
              ), // this Answerbuttons here are pulled out, and added as inividual comma-
          // seperated answers buttons to the list , which is set as the value for children
        ],
      ),
    );
  }
}
