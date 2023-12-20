import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '/models/ingredient.dart';

class IngredientListTile extends StatefulWidget {
  const IngredientListTile({
    super.key,
    required this.ingredient,
    required this.onAdd,
  });

  final Ingredient ingredient;
  final VoidCallback onAdd;

  @override
  State<IngredientListTile> createState() => _IngredientListTileState();
}

class _IngredientListTileState extends State<IngredientListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // for some reason the img filepath sometimes shows up instead of the name
                  widget.ingredient.name + ': ' + widget.ingredient.count.toString() + ' ' + widget.ingredient.measurement + 's',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    /*
                    decoration: widget.ingredient.isChecked
                        ? TextDecoration.lineThrough
                        : null,
                     */
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onAdd,
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}