import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '/models/ingredient.dart';

class IngredientListTile extends StatefulWidget {
  const IngredientListTile({
    super.key,
    required this.ingredient,
    required this.onEdit,
    required this.onDelete,
  });

  final Ingredient ingredient;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

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
                  widget.ingredient.name,
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
                Text(
                  widget.ingredient.measurement,
                  style: TextStyle(
                    /*
                    decoration: widget.ingredient.isChecked
                        ? TextDecoration.lineThrough
                        : null,
                        */
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: widget.onEdit,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
                /*
                Checkbox(
                  //value: widget.ingredient.isChecked,
                  onChanged: (value) {
                    //widget.ingredient.isChecked = value!;
                    setState(() {});
                    Hive.box<Ingredient>('ingredients').put(
                      widget.ingredient.id,
                      Ingredient(
                        id: widget.ingredient.id,
                        name: widget.ingredient.name,
                        img: widget.ingredient.img,
                        count: widget.ingredient.count,
                        measurement: widget.ingredient.measurement,
                      ),
                    );
                  },
                ),
                */
              ],
            ),
          ),
        ],
      ),
    );
  }
}