import 'package:flutter/material.dart';
import '/models/ingredient.dart';

// Not sure this file gets used anymore since the dialog box is pretty much readonly

class AddIngredientDialog extends StatefulWidget {
  const AddIngredientDialog({
    Key? key,
    this.ingredient,
  }) : super(key: key);

  final Ingredient? ingredient;

  @override
  State<AddIngredientDialog> createState() => _AddIngredientDialogState();
}

class _AddIngredientDialogState extends State<AddIngredientDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _imageController;
  late final TextEditingController _countController;
  late final TextEditingController _measureController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _imageController = TextEditingController();
    _countController = TextEditingController();
    _measureController = TextEditingController();
    if (widget.ingredient != null) {
      _nameController.text = widget.ingredient!.name;
      _imageController.text = widget.ingredient!.img;
      _countController.text = widget.ingredient!.count as String;
      _measureController.text = widget.ingredient!.measurement;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _imageController.dispose();
    _countController.dispose();
    _measureController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Ingredient'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image',
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Ingredient ingredient = Ingredient(
              id: int.parse(DateTime.now().toString()),
              name: _nameController.text,
              img: _imageController.text,
              count: int.parse(_countController.text),
              measurement: _measureController.text,
            );
            if (widget.ingredient != null) {
              ingredient = Ingredient(
                id: widget.ingredient!.id,
                name: _nameController.text,
                img: _imageController.text,
                count: int.parse(_countController.text),
                measurement: _measureController.text,
              );
            }
            Navigator.of(context).pop(ingredient);
          },
          child: const Text('Add Ingredient'),
        ),
      ],
    );
  }
}