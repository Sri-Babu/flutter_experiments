import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  void _takePicture(){

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
        width: 1,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      )),
      alignment: Alignment.center,
      child: TextButton.icon(
        label: const Text('Take Picture'),
        icon: const Icon(Icons.camera),
        onPressed: _takePicture,
      ),
    );
  }
}
