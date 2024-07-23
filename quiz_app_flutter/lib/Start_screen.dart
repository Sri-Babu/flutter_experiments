import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      // this center widget defaultly takes the entire width and height because its inside the scaffold and container
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Opacity(
          //   opacity: 0.7,
          //   child: Image.asset("assets/images/question_mark.png"), // opacity do some intence work so avoid it to max
          // ),
          Image.asset(
            "assets/images/question_mark.png",
            color: const Color.fromARGB(70, 255, 255, 255),
          ),
          Text(
            "Learn Flutter the fun way!",
            style: GoogleFonts.eduNswActFoundation(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color.fromARGB(150, 255, 255, 255),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          OutlinedButton.icon(
            // This allows us to add icon inside the button
            style: OutlinedButton.styleFrom(
              // This styling is aplicable for all buttons  --> OutlinedButton.styleForm()
              // Text Color
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 42, 5, 129),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
            ),
            icon: const Icon(Icons.arrow_right_alt),
            onPressed: startQuiz,
            // but child should be changed as lable if we want to add icon
            label:  Text(
              'Start Quiz!!!',
               style: GoogleFonts.eduNswActFoundation(
               textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white,

              ),
            ) ,
            ),
          ),
        ],
      ),
    );
  }
}
