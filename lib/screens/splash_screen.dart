import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:renovate_ranger/features/constans.dart/Pathkeeper.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/designed_widgets/customDialog.dart';
import 'package:renovate_ranger/features/type_adapters/contact_class_adapter.dart';
import 'package:renovate_ranger/features/type_adapters/finance_adapter.dart';
import 'package:renovate_ranger/features/type_adapters/item_class_adapter.dart';
import 'package:renovate_ranger/features/type_adapters/project_class_adapter.dart';
import 'package:renovate_ranger/screens/Tools_and_materials_screen.dart';
import 'package:renovate_ranger/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;
  late bool onboardingflag;
  startTime(BuildContext context) async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, () => navigationPage(context));
  }

  void navigationPage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => onboardingflag == false ? OnboardingScreen() : ToolsAndMaterialsScreen()));
  }

  void loader() async {
    WidgetsFlutterBinding.ensureInitialized();
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    pathDir = dir.path;
    Hive.registerAdapter(ContactClassAdapter());
    Hive.registerAdapter(ItemClassAdapter());
    Hive.registerAdapter(ProjectClassAdapter());
    Hive.registerAdapter(FinanceAdapter());
    //boxes
    await Hive.openBox('contactsBox');
    HiveBase().initDirectory();
    onboardingflag = HiveBase().GetOnboardingFlag();
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loader();
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );
    animation = new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Renovate Ranger",
                style: TextStyle(fontSize: 24.sp),
              ),
              Image.asset(
                'assets/launch/Group.png',
                width: animation.value * 200.w,
                height: animation.value * 200.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
