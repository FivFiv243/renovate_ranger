import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/main.dart';
import 'package:renovate_ranger/screens/Tools_and_materials_screen.dart';
import 'package:renovate_ranger/screens/advices_screen.dart';
import 'package:renovate_ranger/screens/contacts_screen.dart';
import 'package:renovate_ranger/screens/finance_screen.dart';
import 'package:renovate_ranger/screens/onboarding_screen.dart';
import 'package:renovate_ranger/screens/projects_screen.dart';
import 'package:renovate_ranger/screens/settings_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

final List<Map<String, dynamic>> menuItems = [
  {'title': 'Инструменты и материалы', 'isSelected': false, 'navigation': ToolsAndMaterialsScreen()},
  {'title': 'Проекты', 'isSelected': false, 'navigation': ProjectsScreen()},
  {'title': 'Контакты', 'isSelected': false, 'navigation': ContactsScreen()},
  {'title': 'Финансы', 'isSelected': false, 'navigation': FinanceScreen()},
  {'title': 'Советы', 'isSelected': false, 'navigation': AdvicesScreen()},
  {'title': 'Настройки', 'isSelected': false, 'navigation': SettingsScreen()},
];

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          height: 1.sh,
          padding: EdgeInsets.all(20).w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(106, 0, 0, 0),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0)),
              Row(children: [
                Padding(padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0)),
                Text(
                  "RenovateRanger",
                  style: TextStyle(fontSize: 24.sp),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OnboardingScreen()));
                  },
                  child: SvgPicture.asset(
                    'assets/icons/Arrows/Round Arrow Left.svg',
                    width: 32.w,
                    height: 32.h,
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0))
              ]),
              Padding(padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0)),
              Container(
                  height: menuItems.length * (74.5.h),
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: menuItems.length,
                      separatorBuilder: (context, index) {
                        return Padding(padding: EdgeInsets.all(7.5).w);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                            margin: EdgeInsets.fromLTRB(0.w, 0, 0.w, 0),
                            child: InkWell(
                                onTap: () {
                                  if (menuItems[index]['navigation'] != null) {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => menuItems[index]['navigation']));
                                  }
                                },
                                child: PhysicalModel(
                                  elevation: 0,
                                  color: const Color.fromARGB(0, 0, 0, 0),
                                  child: Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(28, 0, 0, 0),
                                        blurRadius: 1.25,
                                        spreadRadius: 0.0,
                                        offset: Offset(1.0, 1.0),
                                      )
                                    ], border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(10.r), color: const Color.fromARGB(255, 255, 255, 255)),
                                    child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0)),
                                        Text(
                                          menuItems[index]['title'],
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Spacer(),
                                        SvgPicture.asset(
                                          'assets/icons/Arrows/Round Arrow Right.svg',
                                          width: 32.w,
                                          height: 32.h,
                                        ),
                                        Padding(padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0))
                                      ],
                                    ),
                                  ),
                                )));
                      }))
            ],
          )),
    ));
  }
}
