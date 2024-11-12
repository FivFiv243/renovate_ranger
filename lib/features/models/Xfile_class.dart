import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

@HiveType(typeId: 1)
class MyXFile extends XFile {
  @override
  @HiveField(1)
  final String path;

  @override
  @HiveField(2)
  final String? mimeType;

  @HiveField(3)
  final String? _name;

  /// The base implementation of `XFileBase.name` throws an
  /// [UnimplementedError] so we are overriding it to return a known
  /// [_name] value.
  @override
  String get name {
    if (_name != null) {
      return _name!;
    }
    return super.name;
  }

  @HiveField(4)
  final int? _length;

  /// The base implementation of `XFileBase.length()` throws an
  /// [UnimplementedError] so we are overriding it to return a known
  /// [_length] value.
  @override
  Future<int> length() {
    return _length != null ? Future.value(_length!) : super.length();
  }

  @HiveField(5)
  final Uint8List? bytes;

  @HiveField(6)
  final DateTime? _lastModified;

  /// The base implementation of `XFileBase.lastModified()` throws an
  /// [UnimplementedError] so we are overriding it to return a known
  /// [_lastModified] value.
  @override
  Future<DateTime> lastModified() {
    return _lastModified != null ? Future.value(_lastModified!) : super.lastModified();
  }

  MyXFile(
    this.path, {
    this.mimeType,
    String? name,
    int? length,
    this.bytes,
    DateTime? lastModified,
  })  : _name = name,
        _length = length,
        _lastModified = lastModified,
        super(
          path,
          mimeType: mimeType,
          name: name,
          length: length,
          bytes: bytes,
          lastModified: lastModified,
        );
}
