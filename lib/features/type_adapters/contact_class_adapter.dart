import 'package:hive/hive.dart';
import 'package:renovate_ranger/features/models/contact_class.dart';

final class ContactClassAdapter extends TypeAdapter<ContactClass> {
  @override
  final int typeId = 0;

  @override
  ContactClass read(BinaryReader reader) {
    return ContactClass(
      name: reader.readString(),
      number: reader.readString(),
      email: reader.readString(),
      job: reader.readString(),
      callback: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ContactClass obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.number);
    writer.writeString(obj.email);
    writer.writeString(obj.job);
    writer.writeString(obj.callback);
  }
}
