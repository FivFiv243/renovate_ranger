import 'package:hive/hive.dart';

@HiveType(typeId: 33, adapterName: "ItemClassAdapter")
class ItemClass {
  @HiveField(0)
  final bool mtool;
  @HiveField(1)
  late final bool isIn;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final double price;
  @HiveField(4)
  late final dynamic quantity;
  @HiveField(5)
  final String comment;

  ItemClass({required this.mtool, required this.isIn, required this.name, required this.price, required this.quantity, required this.comment});
}
