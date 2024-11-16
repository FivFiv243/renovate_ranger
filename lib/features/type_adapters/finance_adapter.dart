import 'package:hive/hive.dart';
import 'package:renovate_ranger/features/models/finance.dart';

final class FinanceAdapter extends TypeAdapter<Finance> {
  @override
  final int typeId = 3;

  @override
  Finance read(BinaryReader reader) {
    return Finance(name: reader.readString(), expanse: reader.readString(), date: reader.read(), type: reader.readString());
  }

  @override
  void write(BinaryWriter writer, Finance obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.expanse);
    writer.write(obj.date);
    writer.writeString(obj.type);
  }
}
