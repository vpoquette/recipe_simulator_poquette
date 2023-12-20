import 'package:hive/hive.dart';
part 'ingredient.g.dart';

// set up Ingredient class with name, id, img path, count, and measurement attributes

@HiveType(typeId: 0)
class Ingredient {
  @HiveField(0)
  String name;
  @HiveField(1)
  int id;
  @HiveField(2)
  String img;
  @HiveField(3)
  int count;
  @HiveField(4)
  String measurement;

  // constructor
  Ingredient({required this.id,
    required this.name,
    required this.img,
    required this.count,
    required this.measurement});

  // getters
  int getID(){return this.id;}
  String getName(){return this.name;}
  String getImg(){return this.img;}
  int getCount(){return this.count;}
  String getMeasurement(){return this.measurement;}
  // setters
  void increase(int amount){this.count += amount;}
  void resetCount(){this.count = 0;}
}
