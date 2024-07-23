import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';


// Naming convention for class extending StateNotifier should end Notifier

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> { // its a generic class so theyfore we add type of data need to be handled in this case List<Meals>

// two life of the call are 1, Initial value 2, methods to do logics on that value

  FavoriteMealsNotifier():super([]);  //In this constructor, pass any value specified in SateNotifer class List<Meal> from 
  //to the parent class, initially in this an empty []. 

 /// In StateNotifier Object(List,Map) basically all states ect.. are immutable the reasone for this is Riverpod is build like that
 /// you can .add or .remove is not allowed

  bool toogleMealFavoriteStatus(Meal meal) {
    // state is globally availabe property in StateNotifier class this holds you data
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
    // removing withot using remove method
      state = state.where((m) => m.id != meal.id).toList(); // where() returns a new list
      return false;
    } else {
      //  we are adding all the elements in state as comma sepreated values and last adding meal
      state = [...state, meal];
      return true;
    }
  }
}

// StateNotifierProvider is suitable for dynamic changing values
//                this is added for better type support StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>
final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
