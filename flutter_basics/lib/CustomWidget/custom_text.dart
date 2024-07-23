import 'package:flutter/material.dart';

// This Class Basically return a text widget with costomizable text value

class CustomText extends StatelessWidget {
  // When we extend Stl we need to override build method

  const CustomText(this.text, this.color,
      {super.key}); // this is constructor which accept text as an argument and set the value to text
  // this.text says "not only accept the text but also map it to the varible text present in the class"
  //this is the special feature of flutter

  final String
      text; // when we add final to this object will not be canged once initialized sp
  // by adding final to this we can use cost for the constructor(for optimiztic performance)

  final color;

  @override
  Widget build(context) {
    // build method accept the context(meta data about this widget) which is automatically called by flutter
    return Text(
      text,
      style: TextStyle(
        color: color
      ),
    );
  }
}

class CustomText2 extends StatelessWidget {
  const CustomText2(String text, {required Key key})
      : this.outputText = text,
        super(key: key); // this another way of assinging value to the variable
  // but dart give the beautiful feature in above snippet
  final String outputText;

  @override
  Widget build(context) {
    return Text(outputText);
  }
}
