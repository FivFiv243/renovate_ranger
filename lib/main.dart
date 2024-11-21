import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/type_adapters/contact_class_adapter.dart';
import 'package:renovate_ranger/features/type_adapters/finance_adapter.dart';
import 'package:renovate_ranger/features/type_adapters/item_class_adapter.dart';
import 'package:renovate_ranger/features/type_adapters/project_class_adapter.dart';
import 'package:renovate_ranger/screens/Tools_and_materials_screen.dart';
import 'package:renovate_ranger/screens/onboarding_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/constans.dart/Pathkeeper.dart' as AppPath;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  AppPath.pathDir = dir.path;
  Hive.registerAdapter(ContactClassAdapter());
  Hive.registerAdapter(ItemClassAdapter());
  Hive.registerAdapter(ProjectClassAdapter());
  Hive.registerAdapter(FinanceAdapter());
  //boxes
  await Hive.openBox('contactsBox');
  HiveBase().initDirectory();
  //main
  runApp(const MyApp());
}

bool onboardingflag = HiveBase().GetOnboardingFlag();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('ru', ''),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "Alegreya",
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffffff)),
            useMaterial3: true,
          ),
          home: onboardingflag == false ? OnboardingScreen() : OnboardingScreen(),
        );
      },
    );
  }
}
