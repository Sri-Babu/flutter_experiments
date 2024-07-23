import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_flutter/data/question_ans.dart';
import 'package:quiz_app_flutter/question_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chooseAnswer, required this.restartQuiz});
  final List<String> chooseAnswer;
  final void Function() restartQuiz;

  List<Map<String, Object>> get summaryData {  // getter is initialized () should be not present and this act like same as method
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chooseAnswer.length; i++) {
      summary.add({
        'Question_Index': i,
        'Questions': questions[i].text,
        'Correct_Answers': questions[i].answers[0],
        'User_Answers': chooseAnswer[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectAnwsers = summaryData.where((data) {
      return data['User_Answers'] == data['Correct_Answers'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Your answered $numCorrectAnwsers out of $numTotalQuestions is corrtectly!",
                style: GoogleFonts.eduNswActFoundation(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color.fromARGB(150, 255, 255, 255),
              ),
            ),
                ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            side: const BorderSide(
         color: Colors.transparent,
      ),
              
            ),
            
            icon: const Icon(Icons.refresh),
            onPressed: restartQuiz,
            // but child should be changed as lable if we want to add icon
            label:  Text(
              'Restart Quiz!',
               style: GoogleFonts.eduNswActFoundation(
               textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,

              ),
            ) ,
            ),
          ),
          ],
        ),
      ),
    );
  }
}
