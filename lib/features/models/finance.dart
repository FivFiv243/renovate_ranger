import 'package:hive/hive.dart';

class Finance {
  @HiveField(0)
  String name;
  @HiveField(1)
  String expanse;
  @HiveField(3)
  String date;
  @HiveField(4)
  String type;
  Finance({required this.name, required this.expanse, required this.date, required this.type});
}
