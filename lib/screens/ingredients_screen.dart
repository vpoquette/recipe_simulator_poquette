import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '/models/ingredient.dart';
import '/utils/utils.dart';
import '/widgets/ingredient_list_tile.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Ingredient>('ingredients').listenable(),
        builder: (context, box, child) {
          final ingredients = box.values;
          return ListView.builder(
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              final ingredient = ingredients.elementAt(index);
              return IngredientListTile(
                ingredient: ingredient,
                onAdd: () {
                  // just printing for now
                  print(Hive.box<Ingredient>('ingredients').get(ingredient.count));
                },
                onCook: () {
                  // just printing for now
                  print(Hive.box<Ingredient>('ingredients').get(ingredient.count));
                },
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ingredient = await openAddIngredientDialog(context: context);
          if (ingredient != null) {
            Hive.box<Ingredient>('ingredients').put(ingredient.id, ingredient);
          }
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}