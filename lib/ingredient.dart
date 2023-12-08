class Ingredient {
  String name;
  String img;
  int count;
  String measurement;

  Ingredient(this.name, this.img, this.count, this.measurement);

  String getName(){return this.name;}
  String getImg(){return this.img;}
  int getCount(){return this.count;}
  String getMeasurement(){return this.measurement;}

  void increase(int amount){this.count += amount;}
}
