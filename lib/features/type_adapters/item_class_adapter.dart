import 'package:hive/hive.dart';

import 'package:renovate_ranger/features/models/item_class.dart';

class ItemClassAdapter extends TypeAdapter<ItemClass> {
  @override
  final int typeId = 1;

  @override
  ItemClass read(BinaryReader reader) {
    return ItemClass(mtool: reader.readBool(), isIn: reader.readBool(), name: reader.readString(), price: reader.readDouble(), quantity: reader.read(), comment: reader.readString());
  }

  @override
  void write(BinaryWriter writer, ItemClass obj) {
    writer.write(obj.mtool);
    writer.write(obj.isIn);
    writer.writeString(obj.name);
    writer.writeDouble(obj.price);
    writer.write(obj.quantity);
    writer.writeString(obj.comment);
  }
}
