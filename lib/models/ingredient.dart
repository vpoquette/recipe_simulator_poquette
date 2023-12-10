import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_simulator_poquette/models/ingredient.dart';

@HiveType(typeId: 0)
class Ingredient {
  @HiveField(1)
  int id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String img;
  @HiveField(4)
  int count;
  @HiveField(5)
  String measurement;

  Ingredient(this.id, this.name, this.img, this.count, this.measurement);

  int getID(){return this.id;}
  String getName(){return this.name;}
  String getImg(){return this.img;}
  int getCount(){return this.count;}
  String getMeasurement(){return this.measurement;}

  void increase(int amount){this.count += amount;}
}
