import 'package:favorite_places/provider/user_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlacesScreen extends ConsumerStatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  ConsumerState<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends ConsumerState<AddPlacesScreen> {
  final _titleController = TextEditingController();


  void _savePlace(){
    final enteredText = _titleController.text;
    if (enteredText.isEmpty) {
      return;
    }

    ref.read(UserPlacesProvider.notifier).addPlace(enteredText); 
    Navigator.of(context).pop();
  }


  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Places'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titel'),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            const ImageInput(),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: _savePlace,
              label: const Text('Add Places'),
            )
          ],
        ),
      ),
    );
  }
}
