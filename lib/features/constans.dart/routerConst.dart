import 'package:renovate_ranger/screens/Tools_and_materials_screen.dart';
import 'package:renovate_ranger/screens/advices_screen.dart';
import 'package:renovate_ranger/screens/contacts_screen.dart';
import 'package:renovate_ranger/screens/finance_screen.dart';
import 'package:renovate_ranger/screens/projects_screen.dart';
import 'package:renovate_ranger/screens/settings_screen.dart';

const List<Map<String, dynamic>> menuItems = [
  {'title': 'Инструменты и материалы', 'navigation': ToolsAndMaterialsScreen()},
  {'title': 'Проекты', 'navigation': ProjectsScreen()},
  {'title': 'Контакты', 'navigation': ContactsScreen()},
  {'title': 'Финансы', 'navigation': FinanceScreen()},
  {'title': 'Советы', 'navigation': AdvicesScreen()},
  {'title': 'Настройки', 'navigation': SettingsScreen()},
];

int selectedscreen = 0;
