import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
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
    final QueryWidth = MediaQuery.of(context).size.width;
    final QueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12),
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
                        Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 5, 0, 0)),
                        SizedBox(
                          width: QueryWidth / 1.1,
                          height: QueryHeight / 4,
                          child: Image.asset('lib/assets/images/projectsfiller.x2.png'),
                        ),
                        SizedBox(height: QueryHeight / 40),
                        Text(
                          'Вы пока не добавили проект.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Добавить проект',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Container(
                    width: QueryWidth / 1.1,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: projectList.length,
                          separatorBuilder: (context, index) {
                            return Padding(padding: EdgeInsets.all(QueryHeight / 60));
                          },
                          itemBuilder: (context, index) {
                            return index < projectList.length
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
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
                                        Padding(
                                          padding: EdgeInsets.all(QueryHeight / 90),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.file(
                                              width: QueryWidth / 6,
                                              height: QueryHeight / 6,
                                              File(projectList[index].xfilepath),
                                              scale: 0.5,
                                            ),
                                          ),
                                        ),
                                        Text(projectList[index].projectName.toString().substring(0, projectList[index].projectName.toString().length > 30 ? 30 : projectList[index].projectName.toString().length)),
                                        Spacer(),
                                        GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15.0),
                                                    ),
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                                                                fontSize: QueryWidth / 20,
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
                                                            height: 20.0,
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
                                                                  fontSize: QueryWidth / 20,
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
                                            child: SvgPicture.asset('lib/assets/icons/Essentional, UI/Menu Dots.svg')),
                                        Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 60, 0, 0, 0))
                                      ],
                                    ))
                                : Container();
                          },
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
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
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Добавить проект',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      )
                    ]))));
  }
}
