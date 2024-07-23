import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid(); // Initializer List  gives uniqu valuse anutomatically

final formatter =
    DateFormat.yMd(); // Data formatter object third party package intl

enum Categories {
  food,
  traval,
  leisure,
  work,
}

// this is map values we are using enum as key and Icons as values
const categoryIcons = {
  //   key           :     value
  Categories.food: Icons.lunch_dining,
  Categories.traval: Icons.flight_takeoff,
  Categories.leisure: Icons.movie,
  Categories.work: Icons.work,
};

class Expense {
  Expense({
    required this.amount,
    required this.title,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); // In dart 'initializer List' can be used to initialize class property without receving in constructor

  // properties
  final String id;
  // mandatory to create Expenses object
  final String title;
  final double amount;
  final DateTime date;
  // constant values used defalutly by expenses which can be used without passing values in constructor
  final Categories category;

  // methods

  // getter
  String get formatDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  // another constructor
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category, ) .toList();

  final Categories category;
  final List<Expense> expenses;

  // getter
  double get totelExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
