import 'package:flutter/material.dart';
import 'add_edit_recipe_page.dart';
import 'recipe_details_page.dart';
import 'navigation.dart';

class RecipeDashboardPage extends StatefulWidget {
  const RecipeDashboardPage({super.key});

  @override
  _RecipeDashboardPageState createState() => _RecipeDashboardPageState();
}

class _RecipeDashboardPageState extends State<RecipeDashboardPage> {
  final List<Map<String, String>> _recipes = [];
  String _selectedCategory = 'All';

  void _addOrEditRecipe(Map<String, String> recipe, [int? index]) {
    setState(() {
      if (index == null) {
        _recipes.add(recipe);
      } else {
        _recipes[index] = recipe;
      }
    });
  }

  void _deleteRecipe(int index) {
    setState(() {
      _recipes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = _recipes.where((recipe) {
      return _selectedCategory == 'All' ||
          recipe['category'] == _selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Dashboard', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedCategory,
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All')),
                DropdownMenuItem(value: 'Breakfast', child: Text('Breakfast')),
                DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                DropdownMenuItem(value: 'Desserts', child: Text('Desserts')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredRecipes.isEmpty
                  ? const Center(child: Text('No recipes added yet.'))
                  : ListView.builder(
                      itemCount: filteredRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = filteredRecipes[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(recipe['name'] ?? ''),
                            subtitle: Text('Category: ${recipe['category']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddEditRecipePage(
                                          onSave: (updatedRecipe) =>
                                              _addOrEditRecipe(
                                                  updatedRecipe, index),
                                          initialData: recipe,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteRecipe(index),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailsPage(
                                    recipe: recipe,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditRecipePage(onSave: _addOrEditRecipe),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
