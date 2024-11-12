import 'dart:ffi';

import 'package:hive/hive.dart';

@HiveType(typeId: 33, adapterName: "ItemClassAdapter")
class ItemClass {
  @HiveField(0)
  int mtool;
  @HiveField(1)
  int isIn;
  @HiveField(2)
  String name;
  @HiveField(3)
  String price;
  @HiveField(4)
  dynamic quantity;
  @HiveField(5)
  String comment;
  @HiveField(6)
  String typeCount;

  ItemClass({required this.mtool, required this.isIn, required this.name, required this.price, required this.quantity, required this.comment, required this.typeCount});
}
