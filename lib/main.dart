import 'package:flutter/material.dart';
import 'recipe_dashboard.dart';

void main() => runApp(FoodRecipeGuideApp());

class FoodRecipeGuideApp extends StatelessWidget {
  const FoodRecipeGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe Guide',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: RecipeDashboardPage(),
    );
  }
}
