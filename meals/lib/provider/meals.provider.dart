import 'package:meals/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider class is suitable for static list data not for dynamic
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
