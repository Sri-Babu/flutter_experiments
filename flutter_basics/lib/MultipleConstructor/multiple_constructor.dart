import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MultipleConstructor extends StatelessWidget{
 
 Object? someValue;

  MultipleConstructor({super.key});  // constructor 1

  MultipleConstructor.don({required this.someValue,super.key}); // Constructor 2

  @override
  Widget build(Object context) {
    return "SomeWidget" as Widget;
  }

}
