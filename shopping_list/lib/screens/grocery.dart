import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_items.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  var _error =null;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https(
        'flutter-prep-6076c-default-rtdb.firebaseio.com', 'shoppinp-list.json');
    final response = await http.get(url);
    if (response.statusCode <=400 ) {
      setState(() {
        _error = "Failed to fetch data! Some internal errors";
      });
    }
    final Map<String, dynamic> listData = json.decode(response.body);
    print("------------------------->>");
    print(response.body);
    final List<GroceryItem> localItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (catItem) => catItem.value.title == item.value['category'],
          )
          .value;
      localItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['qunatity'],
          category: category,
        ),
      );
    }

    setState(() {
      _groceryItems = localItems;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }
    setState(
      () {
        _groceryItems.add(newItem);
        _isLoading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
      itemCount: _groceryItems.length,
      itemBuilder: (context, index) =>
          // insted of row more convintient for list type of styles
          ListTile(
        title: Text(
          _groceryItems[index].name,
          style: const TextStyle(color: Colors.white),
        ),
        leading: Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: _groceryItems[index].category.color,
          ),
        ),
        trailing: Text(
          '${_groceryItems[index].quantity}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

    if (_error != null) {
      content = Center(child: Text(_error),);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
