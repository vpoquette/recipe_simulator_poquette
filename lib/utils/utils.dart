import 'package:flutter/material.dart';

import '/models/ingredient.dart';
import '/widgets/add_ingredient_dialog.dart';

// generated things

Future<Ingredient?> openAddIngredientDialog({
  required BuildContext context,
  Ingredient? ingredient,
}) {
  return showDialog<Ingredient?>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AddIngredientDialog(
        ingredient: ingredient,
      );
    },
  );
}