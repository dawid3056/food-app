import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/widgets/meal_item_trait.dart';

class MealDetailsPage extends StatelessWidget {
  const MealDetailsPage({
    super.key,
    required this.meal,
  });

  final Meal meal;

  String get complextityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MealItemTrait(
                    icon: Icons.schedule,
                    label: '${meal.duration}min',
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  MealItemTrait(
                    icon: Icons.work,
                    label: complextityText,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  MealItemTrait(
                    icon: Icons.attach_money,
                    label: affordabilityText,
                  ),
                ],
              ),
              Text(
                meal.ingredients.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
