import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:renovate_ranger/features/type_adapters/contact_class_adapter.dart';
import 'package:renovate_ranger/features/type_adapters/finance_adapter.dart';
import 'package:renovate_ranger/features/type_adapters/item_class_adapter.dart';
import 'package:renovate_ranger/features/type_adapters/project_class_adapter.dart';
import 'package:renovate_ranger/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(ContactClassAdapter());
  Hive.registerAdapter(ItemClassAdapter());
  Hive.registerAdapter(ProjectClassAdapter());
  Hive.registerAdapter(FinanceAdapter());
  //boxes
  await Hive.openBox('contactsBox');
  //main
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffffff)),
            useMaterial3: true,
          ),
          home: const OnboardingScreen(),
        );
      },
      child: OnboardingScreen(),
    );
  }
}
