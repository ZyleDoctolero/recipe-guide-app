import 'package:flutter/material.dart';
import 'navigation.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Categories'),
      ),
      body: ListView(
        children: const <Widget>[
          ListTile(title: Text('Breakfast')),
          ListTile(title: Text('Lunch')),
          ListTile(title: Text('Dinner')),
          ListTile(title: Text('Dessert')),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
