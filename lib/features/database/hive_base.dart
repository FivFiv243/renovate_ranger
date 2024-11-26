import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveBase {
  final boxList = [Hive.box('contactsBox')];
  late String appDirectory;

  /// Инициализация директории приложения
  Future<void> initDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    appDirectory = dir.path;
  }

  /// Сохраняет список номеров телефонов в базе
  Future<void> PutPhonesInBase(List<dynamic> numbers) async {
    await boxList[0].put('numbers', numbers);
  }

  /// Удаляет данные из базы
  Future<void> jj() async {
    await Hive.deleteFromDisk();
  }

  /// Получает список номеров телефонов из базы
  List<dynamic> GetPhoneFromBase() {
    try {
      final contacts = boxList[0].get('numbers');
      return contacts ?? [];
    } catch (e) {
      debugPrint('\n\nError: $e\n\n');
      return [];
    }
  }

  /// Сохраняет проекты в базе
  Future<void> PutProjectsInBase(List<dynamic> projects) async {
    await boxList[0].put('projects', projects);
  }

  /// Получает список проектов из базы
  List<dynamic> GetProjectsFromBase() {
    try {
      return boxList[0].get('projects') ?? [];
    } catch (e) {
      debugPrint('\n\nError: $e\n\n');
      return [];
    }
  }

  /// Сохраняет инструменты или материалы в базе
  Future<void> PutToolsOrMaterialInBase(List<dynamic> tools) async {
    await boxList[0].put('tools', tools);
  }

  /// Получает список инструментов или материалов из базы
  List<dynamic> GetToolsOrMaterialFromBase() {
    try {
      return boxList[0].get('tools') ?? [];
    } catch (e) {
      debugPrint('\n\nError: $e\n\n');
      return [];
    }
  }

  /// Устанавливает флаг прохождения онбординга
  Future<void> SetBoardingFlag() async {
    await boxList[0].put("onboarding flag", true);
  }

  /// Получает флаг прохождения онбординга
  bool GetOnboardingFlag() {
    try {
      return boxList[0].get("onboarding flag") ?? false;
    } catch (e) {
      debugPrint('\n\nError: $e\n\n');
      return false;
    }
  }

  /// Сохраняет финансы в базе
  Future<void> PutFinanceInBase(List<dynamic> finance) async {
    await boxList[0].put('finance', finance);
  }

  /// Получает финансы из базы
  List<dynamic> GetFinanceFromBase() {
    try {
      return boxList[0].get('finance') ?? [];
    } catch (e) {
      debugPrint('\n\nError: $e\n\n');
      return [];
    }
  }

  /// Сохраняет файлы с относительными путями
  Future<void> PutXfileInBase(List<String> Xfiles) async {
    await boxList[0].put('Xfiles', Xfiles);
  }

  /// Получает файлы с относительными путями
  List<String> GetXfileFromBase() {
    try {
      return List<String>.from(boxList[0].get('Xfiles') ?? []);
    } catch (e) {
      debugPrint('\n\nError: $e\n\n');
      return [];
    }
  }

  /// Сохраняет используемые инструменты в указанную базу
  Future<void> PutUsedtools(Map<dynamic, dynamic> tools, String boxname) async {
    await boxList[0].put(boxname, tools);
  }

  /// Получает инструменты проекта из указанной базы
  Map<dynamic, dynamic> GetProjTools(String boxname) {
    try {
      return boxList[0].get(boxname) ?? <dynamic, dynamic>{};
    } catch (e) {
      debugPrint('\n\nError: $e\n\n');
      return {};
    }
  }
}
