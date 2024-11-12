import 'package:hive/hive.dart';

class ProjectsClass {
  @HiveField(0)
  final String projectName;
  @HiveField(1)
  final String comment;
  @HiveField(2)
  final String projectDescription;
  @HiveField(3)
  final String xfilepath;

  ProjectsClass({required this.projectName, required this.comment, required this.projectDescription, required this.xfilepath});
}
