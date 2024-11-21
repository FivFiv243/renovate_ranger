import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:renovate_ranger/features/constans.dart/constants.dart';
import 'package:renovate_ranger/features/constans.dart/routerConst.dart';
import 'package:renovate_ranger/features/designed_widgets/settings_item.dart';
import 'package:renovate_ranger/main.dart';
import 'package:url_launcher/url_launcher.dart' as uLaunch;
import 'package:in_app_review/in_app_review.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final InAppReview inAppReview = InAppReview.instance;

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
          width: 1.sw,
          child: Drawer(
              child: Container(
                  height: 1.sh,
                  width: 1.sw,
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
                      Padding(padding: EdgeInsets.fromLTRB(0, 30.h, 0, 0)),
                      Row(children: [
                        Padding(padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0)),
                        Text(
                          "RenovateRanger",
                          style: TextStyle(fontSize: 24.sp),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/Arrows/Round Arrow Left.svg',
                            width: 32.w,
                            height: 32.h,
                          ),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0))
                      ]),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0.h, 0, 0)),
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
                                            if (selectedscreen != index) {
                                              setState(() {
                                                selectedscreen = index;
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => menuItems[index]['navigation'])).then((_) => setState(() {}));
                                              });
                                            }
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
                  )))),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
                width: 32.w,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/icons/Essentional, UI/Sort.svg",
                  width: 32.w,
                )),
          ),
        ),
        shadowColor: Colors.black.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12).w,
          ),
        ),
        title: Text('Настройки'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10).w,
        child: Column(
          children: [
            SettingsItem(
              title: 'Политика конфиденциальности',
              svgname: 'assets/icons/Security/Lock Unlocked.svg',
              onTap: () async {
                try {
                  await uLaunch.launchUrl(
                    Uri(scheme: "https", host: termHost, path: termPath),
                    mode: uLaunch.LaunchMode.externalApplication,
                  );
                } catch (e) {}
              },
            ),
            SizedBox(height: 5.h),
            SettingsItem(
              title: 'Пользовательское соглашение',
              svgname: 'assets/icons/School/Notebook Bookmark.svg',
              onTap: () async {
                try {
                  await uLaunch.launchUrl(
                    Uri(scheme: "https", host: policyHost, path: policyPath),
                    mode: uLaunch.LaunchMode.externalApplication,
                  );
                } catch (e) {}
              },
            ),
            SizedBox(height: 5.h),
            Divider(
              height: 5.h,
              color: const Color.fromARGB(66, 158, 158, 158),
            ),
            SizedBox(height: 5.h),
            SettingsItem(
              title: 'Оценить приложение',
              svgname: 'assets/icons/Hands/Hand Stars.svg',
              onTap: () async {
                try {
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                } catch (e) {}
                //App reviewing module here
              },
            ),
          ],
        ),
      ),
    );
  }
}
