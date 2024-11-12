import 'package:hive/hive.dart';

import 'package:renovate_ranger/features/models/item_class.dart';

class ItemClassAdapter extends TypeAdapter<ItemClass> {
  @override
  final int typeId = 1;

  @override
  ItemClass read(BinaryReader reader) {
    return ItemClass(mtool: reader.readInt(), isIn: reader.readInt(), name: reader.readString(), price: reader.readString(), quantity: reader.read(), comment: reader.readString(), typeCount: reader.readString());
  }

  @override
  void write(BinaryWriter writer, ItemClass obj) {
    writer.writeInt(obj.mtool);
    writer.writeInt(obj.isIn);
    writer.writeString(obj.name);
    writer.writeString(obj.price);
    writer.write(obj.quantity);
    writer.writeString(obj.comment);
    writer.writeString(obj.typeCount);
  }
}
