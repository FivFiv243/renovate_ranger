import 'package:hive/hive.dart';

@HiveType(typeId: 32, adapterName: "ContactClassAdapter")
class ContactClass {
  @HiveField(0)
  String name;
  @HiveField(1)
  String number;
  @HiveField(2)
  String email;
  @HiveField(3)
  String job;
  @HiveField(4)
  String callback;
  ContactClass({
    required this.name,
    required this.number,
    required this.email,
    required this.job,
    required this.callback,
  });
}
