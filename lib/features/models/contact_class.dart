import 'package:hive/hive.dart';

@HiveType(typeId: 32, adapterName: "ContactClassAdapter")
class ContactClass {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String number;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String job;
  @HiveField(4)
  final String callback;
  ContactClass({
    required this.name,
    required this.number,
    required this.email,
    required this.job,
    required this.callback,
  });
}
