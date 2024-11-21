import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/main.dart';
import 'package:renovate_ranger/screens/add_project_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

List<dynamic> projectList = HiveBase().GetProjectsFromBase();
List<dynamic> xfileList = HiveBase().GetXfileFromBase();

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 2,
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
                        backgroundColor: const Color.fromARGB(255, 61, 122, 228),
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
                                        Padding(padding: EdgeInsets.all(5).w),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8).w,
                                          child: Image.file(
                                            width: 0.2.sw,
                                            height: 0.2.sh,
                                            File(projectList[index].xfilepath),
                                            scale: 0.5,
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
                                                        borderRadius: BorderRadius.circular(15.0).w,
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
                            backgroundColor: const Color.fromARGB(255, 61, 122, 228),
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
