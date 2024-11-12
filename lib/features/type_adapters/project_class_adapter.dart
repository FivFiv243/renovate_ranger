import 'package:hive/hive.dart';
import 'package:renovate_ranger/features/models/projects_class.dart';

class ProjectClassAdapter extends TypeAdapter<ProjectsClass> {
  @override
  ProjectsClass read(BinaryReader reader) {
    return ProjectsClass(projectName: reader.readString(), comment: reader.readString(), projectDescription: reader.readString(), xfilepath: reader.readString());
  }

  @override
  final int typeId = 2;
  @override
  void write(BinaryWriter writer, ProjectsClass obj) {
    writer.writeString(obj.projectName);
    writer.writeString(obj.comment);
    writer.writeString(obj.projectDescription);
    writer.writeString(obj.xfilepath);
  }
}
