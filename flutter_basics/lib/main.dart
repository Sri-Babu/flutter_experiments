import 'package:flutter/material.dart';
import 'package:flutter_basics/CustomWidget/custom_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const CustomText('Dai!!!',Color.fromARGB(221, 223, 7, 7)),
    );
  }
}
