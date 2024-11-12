import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:renovate_ranger/features/models/contact_class.dart';
import 'package:renovate_ranger/features/type_adapters/contact_class_adapter.dart';

class HiveBase {
  final boxList = [Hive.box('contactsBox')];

  void PutPhonesInBase(List<dynamic> numbers) async {
    await boxList[0].put('numbers', numbers);
  }

  void jj() async {
    await Hive.deleteFromDisk();
  }

  List<dynamic> GetPhoneFromBase() {
    try {
      List<dynamic> contacts = boxList[0].get('numbers');
      if (contacts == null) {
        return [];
      } else {
        return contacts;
      }
    } catch (e) {
      debugPrint('\n\n' + e.toString() + '\n\n');
      final List<ContactClass> list = [];
      return list;
    }
  }

  void PutProjectsInBase(List<dynamic> projects) async {
    await boxList[0].put('projects', projects);
  }

  List<dynamic> GetProjectsFromBase() {
    try {
      return boxList[0].get('projects');
    } catch (e) {
      debugPrint('\n\n' + e.toString() + '\n\n');
      return [];
    }
  }

  void PutToolsInBase(List<dynamic> tools) {
    boxList[0].put('tools', tools);
  }

  List<dynamic> GetToolsFromBase() {
    try {
      return boxList[0].get('tools');
    } catch (e) {
      debugPrint('\n\n' + e.toString() + '\n\n');
      return [];
    }
  }

  void PutFinanceInBase(List<Map<String, dynamic>> finance) {
    boxList[0].put('finance', finance);
  }

  List? GetFinanceFromBase() {
    try {
      return boxList[0].get('finance');
    } catch (e) {
      return [];
    }
  }

  void PutXfileInBase(List<dynamic> Xfiles) async {
    await boxList[0].put('Xfiles', Xfiles);
  }

  List<dynamic> GetXfileFromBase() {
    try {
      return boxList[0].get('Xfiles');
    } catch (e) {
      debugPrint('\n\n' + e.toString() + '\n\n');
      return [];
    }
  }
}
