import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/models/grocery_items.dart'; // This tells Dart all the content provided by package is bundled into http(as object)

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  var _isSending = false;
  var _enteredName = '';
  var _enteredQunatity = 1;
  var _selectedCategory = categories[Categories
      .fruit]!; // to set the initial value for drop down and use this to update the value

  final globalKey = GlobalKey<FormState>();
  void _saveIems() async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https('flutter-prep-6076c-default-rtdb.firebaseio.com',
          'shoppinp-list.json');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'aplication/json'},
        body: json.encode(
          {
            'name': _enteredName,
            'quantity': _enteredQunatity,
            'category': _selectedCategory.title,
          },
        ),
      );
      final Map<String,dynamic> resData = json.decode(response.body);
      print("===================>>>");
      print(response.body);
      print(response.statusCode);

      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop(
        GroceryItem(
          id: resData['name'],
          name: _enteredName,
          quantity: _enteredQunatity,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Item!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length >= 50) {
                    return 'Must be between 1 and 50 charecters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      maxLength: 50,
                      initialValue: _enteredQunatity.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid positive number.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQunatity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value:
                          _selectedCategory, // to set inital value and update in onChanged()
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                              value: category.value,
                              child: Row(children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.title),
                              ]))
                      ],
                      // when onchaged the values is already there so no need on onSaved
                      onChanged: (value) {
                        // SetState for see the changes in the dropDown
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending ? null: () {
                      globalKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed:_isSending ? null:  _saveIems,
                    child: _isSending ? const SizedBox(height: 16,width: 16,child: CircularProgressIndicator(),) :const Text('Add Item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
