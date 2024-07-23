import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal,required this.singelMeal});

  final void Function() singelMeal;

  final Meal meal;

  // getter to convert the meal complexity to String an First letter to UpperCase
  String get getMealComplexity {
    //              this name property coneverts enum to string so we can use string properties
    return meal.complexity.name[0].toString() +
        meal.complexity.name.substring(1);
  }
  String get getMealAffordability {
    return meal.affordability.name[0].toString() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),kf
      ),
      // clips the widget remove unwanted extening of child
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: singelMeal,
        child: Stack(
          children: [
            // Images will fade in smoothly
            FadeInImage(
              // transperent image for place holder thnanks to transperent image package
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow:
                          TextOverflow.ellipsis, // The text is OverFlowi...
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        
                        MealItemTrait(
                          icon: Icons.work,
                          label: getMealComplexity,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: getMealAffordability,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
