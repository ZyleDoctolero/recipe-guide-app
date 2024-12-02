import 'package:flutter/material.dart';

class AddEditRecipePage extends StatelessWidget {
  final Function(Map<String, String>) onSave;
  final Map<String, String>? initialData;

  AddEditRecipePage({super.key, required this.onSave, this.initialData});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    if (initialData != null) {
      _nameController.text = initialData!['name'] ?? '';
      _ingredientsController.text = initialData!['ingredients'] ?? '';
      _instructionsController.text = initialData!['instructions'] ?? '';
      _selectedCategory = initialData!['category'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Edit Recipe'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Recipe Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter recipe name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(labelText: 'Ingredients'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter ingredients' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(labelText: 'Instructions'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter instructions' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: const [
                  DropdownMenuItem(
                      value: 'Breakfast', child: Text('Breakfast')),
                  DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                  DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                  DropdownMenuItem(value: 'Desserts', child: Text('Desserts')),
                ],
                onChanged: (value) {
                  _selectedCategory = value;
                },
                validator: (value) => value == null ? 'Select category' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onSave({
                      'name': _nameController.text,
                      'ingredients': _ingredientsController.text,
                      'instructions': _instructionsController.text,
                      'category': _selectedCategory!,
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
