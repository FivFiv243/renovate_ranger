import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/features/constans.dart/routerConst.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/screens/add_project_screen.dart';
import 'package:path/path.dart' as path;

import '../features/constans.dart/Pathkeeper.dart' as AppPath;

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

List<dynamic> projectList = HiveBase().GetProjectsFromBase();
List<dynamic> xfileList = HiveBase().GetXfileFromBase();
var appPath = AppPath.pathDir;

class _ProjectsScreenState extends State<ProjectsScreen> {
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
            title: Text('Проекты'),
            centerTitle: true,
            actions: []),
        body: projectList.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        // Заглушка для изображения
                        Padding(padding: EdgeInsets.fromLTRB(0, 0.2.sh, 0, 0)),
                        SizedBox(
                          width: 0.9.sw,
                          height: 0.25.sh,
                          child: Image.asset('assets/images/projectsfiller.x2.png'),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Вы пока не добавили проект.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0).w,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => AddProjectScreen(
                                      projectList: projectList,
                                      typeOpen: -1,
                                    )))
                            .then((_) {
                          setState(() {});
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4B87FE),
                        minimumSize: Size(double.infinity.w, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12).w,
                        ),
                      ),
                      child: Text(
                        'Добавить проект',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Container(
                    width: 0.9.sw,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        height: 0.69.sh,
                        child: ListView.separated(
                          itemCount: projectList.length,
                          separatorBuilder: (context, index) {
                            return Padding(padding: EdgeInsets.all(7.5).w);
                          },
                          itemBuilder: (context, index) {
                            return index < projectList.length
                                ? Container(
                                    margin: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
                                    padding: EdgeInsets.all(5).w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12).w,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.all(6).w),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8).w,
                                          child: Image.file(
                                            fit: BoxFit.cover,
                                            width: 0.2.sw,
                                            height: 0.125.sh,
                                            File(path.join(appPath, projectList[index].xfilepath)),
                                            scale: 1,
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(5).w),
                                        Text(projectList[index].projectName.toString().substring(0, projectList[index].projectName.toString().length > 30 ? 30 : projectList[index].projectName.toString().length)),
                                        Spacer(),
                                        GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15.0).w,
                                                    ),
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.0.w),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          TextButton(
                                                            child: Text(
                                                              "Редактировать",
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.black87,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              Navigator.of(context)
                                                                  .push(MaterialPageRoute(
                                                                      builder: (context) => AddProjectScreen(
                                                                            projectList: projectList,
                                                                            typeOpen: index,
                                                                          )))
                                                                  .then((_) => setState(() {}));
                                                            },
                                                          ),
                                                          Divider(
                                                            color: Colors.grey.shade300,
                                                            thickness: 1.0,
                                                            height: 20.0.h,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Добавьте логику для удаления
                                                              Navigator.of(context).pop(); // Закрыть диалог после нажатия
                                                            },
                                                            child: TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  projectList.removeAt(index);
                                                                });
                                                                Navigator.pop(context);
                                                              },
                                                              child: Text(
                                                                "Удалить",
                                                                style: TextStyle(
                                                                  fontSize: 16.sp,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Colors.red,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: SvgPicture.asset('assets/icons/Essentional, UI/Menu Dots.svg')),
                                        Padding(padding: EdgeInsets.fromLTRB(7.5.w, 0, 0, 0))
                                      ],
                                    ))
                                : Container();
                          },
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0).w,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => AddProjectScreen(
                                          projectList: projectList,
                                          typeOpen: -1,
                                        )))
                                .then((_) {
                              setState(() {});
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4B87FE),
                            minimumSize: Size(double.infinity.w, 50.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12).w,
                            ),
                          ),
                          child: Text(
                            'Добавить проект',
                            style: TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      )
                    ]))));
  }
}
