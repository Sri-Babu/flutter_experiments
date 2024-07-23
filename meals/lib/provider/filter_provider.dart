import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meals.provider.dart';
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}
class FiltersNotifier extends StateNotifier<Map<Filter,bool>>{
  FiltersNotifier():super({
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegetarian:false,
  Filter.vegan:false,
  });

  void setFilters(Map<Filter,bool>chosenFilters){
    state=chosenFilters;

  }
  void setFilter(Filter filter,bool isActive){
    //state[filter] = isActive; // not allowed! => mutatnig state
    state={
      // all the states will be coped
     ...state,
     // and this will override the value in the copied state
     filter:isActive,
    };
  }
}

final filterProvider = StateNotifierProvider<FiltersNotifier,Map<Filter,bool>>((ref) => FiltersNotifier());
final filterMealProvider =  Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
    return   meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
});

