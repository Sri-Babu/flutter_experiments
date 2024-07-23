import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(
    this.summarydata, {
    super.key,
  });
  final List<Map<String, Object>> summarydata;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
            children: summarydata.map((data) { // map basically transform an list element from one type to another type
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 30,
                  width: 30,
                    alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color:  data['User_Answers'] == data['Correct_Answers'] ?
                    const Color(0xFF76BDF0)
                   : const Color(0xFFFE68F2),
                  ), //FE68F2  //76BDF0
                  child: Text(
                    ((data['Question_Index'] as int) + 1)
                        .toString(), // typecasted as to int because the value of the Map is object
                    style: GoogleFonts.eduNswActFoundation(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['Questions'].toString(),
                        style: GoogleFonts.eduNswActFoundation(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data['User_Answers'].toString(),
                        style: GoogleFonts.eduNswActFoundation(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color.fromARGB(120, 255, 255, 255),
                          ),
                        ),
                      ),
                      Text(
                        data['Correct_Answers'].toString(),
                        style: GoogleFonts.eduNswActFoundation(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color:  Color(0xFF76BDF0)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList()),
      ),
    );
  }
}
