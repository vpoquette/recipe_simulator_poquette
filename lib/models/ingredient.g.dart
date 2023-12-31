part of 'ingredient.dart';

// generated things

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final int typeId = 0;

  @override
  Ingredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ingredient(
      id: fields[1] as int,
      name: fields[2] as String,
      img: fields[0] as String,
      count: fields[3] as int,
      measurement: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.measurement);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is IngredientAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}