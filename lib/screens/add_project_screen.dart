import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/designed_widgets/customDialog.dart';
import 'package:renovate_ranger/features/models/projects_class.dart';
import 'package:renovate_ranger/main.dart';

class AddProjectScreen extends StatefulWidget {
  AddProjectScreen({super.key, required this.projectList, required this.typeOpen});
  List<dynamic> projectList;
  final int typeOpen;
  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

String selectedFileName = '';
XFile? file = null;
String xfilePath = '';

//Text editing controllers
final _projectnameControler = TextEditingController();
final _projectdescriptionControler = TextEditingController();
final _projectcommentControler = TextEditingController();
int typesetedtool = 1;
Future setImageProject() async {
  try {
    file = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    xfilePath = file!.path;
    selectedFileName = file!.name;
  } catch (e) {}
}

List<dynamic> selectedTools = HiveBase().GetToolsOrMaterialFromBase();
Map<dynamic, dynamic> listtools = {};

class _AddProjectScreenState extends State<AddProjectScreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.typeOpen == -1) {
      file = null;
      xfilePath = '';
      _projectcommentControler.text = '';
      _projectnameControler.text = '';
      _projectdescriptionControler.text = '';
      selectedFileName = '';
      listtools = {};
      setState(() {});
    } else {
      file = null;
      xfilePath = widget.projectList[widget.typeOpen].xfilepath;
      _projectcommentControler.text = widget.projectList[widget.typeOpen].comment;
      _projectnameControler.text = widget.projectList[widget.typeOpen].projectName;
      _projectdescriptionControler.text = widget.projectList[widget.typeOpen].projectDescription;
      selectedFileName = '';
      listtools = HiveBase().GetProjTools(widget.projectList[widget.typeOpen].projectName);
      setState(() {});
    }
  }

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
          title: Text('Добавление пункта'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          height: 722.5.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0).w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12).w,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Поле для названия проекта
                      Text(
                        'Название',
                        style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8).w,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: TextField(
                          onEditingComplete: () {
                            setState(() {});
                          },
                          controller: _projectnameControler,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '  Название',
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      Center(
                        child: xfilePath == ''
                            ? Container()
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  width: 0.9.sw,
                                  height: 0.125.sh,
                                  File(xfilePath),
                                  scale: 0.5,
                                ),
                              ),
                      ),
                      Center(
                          child: OutlinedButton(
                        onPressed: () {
                          setImageProject().whenComplete(() => setState(() {}));
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          SvgPicture.asset(
                            'assets/icons/download/Download Minimalistic.svg',
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                          Text(
                            'Добавьте изображение проекта',
                            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                          ),
                        ]),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8).w,
                          ),
                          side: BorderSide(color: const Color.fromARGB(76, 224, 224, 224)),
                        ),
                      )),
                      SizedBox(height: 10.h),

                      // Поле для описания проекта
                      Text(
                        'Описание проекта',
                        style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8).w,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: TextField(
                          controller: _projectdescriptionControler,
                          maxLines: 3,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '  Описание проекта',
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Кнопка для добавления инструментов и материалов
                      listtools.length > 0
                          ? Container(
                              height: 80.h,
                              child: ListView.separated(
                                  itemCount: listtools.length,
                                  separatorBuilder: (context, index) => Padding(padding: EdgeInsets.all(5).w),
                                  itemBuilder: (context, index) {
                                    final quantityController = TextEditingController();
                                    return listtools[listtools.keys.toList()[index]] != 0
                                        ? Container(
                                            padding: EdgeInsets.all(16.0).w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12).w,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(padding: EdgeInsets.all(5).w),
                                                SvgPicture.asset('assets/icons/hammer/hammer=off.svg'),
                                                Text(listtools.keys.toList()[index]),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (listtools[listtools.keys.toList()[index]] > 0) {
                                                      listtools[listtools.keys.toList()[index]] = listtools[listtools.keys.toList()[index]] - 1;
                                                      setState(() {});
                                                    }
                                                  },
                                                  child: SvgPicture.asset('assets/icons/Essentional, UI/Minus Circle.svg'),
                                                ),
                                                Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                                                Container(
                                                  width: 0.2.sw,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                                                    borderRadius: BorderRadius.circular(8).w,
                                                    color: Colors.grey.withOpacity(0.1),
                                                  ),
                                                  child: TextField(
                                                    onTap: () {
                                                      quantityController.text = listtools[listtools.keys.toList()[index]].toString();
                                                    },
                                                    onEditingComplete: () {
                                                      setState(() {
                                                        if (quantityController.text == '' || double.parse(quantityController.text.trim()) < -1) {
                                                          quantityController.text = '0';
                                                        }
                                                        listtools[listtools.keys.toList()[index]] = double.parse(quantityController.text.trim());
                                                        quantityController.text = '';
                                                      });
                                                    },
                                                    keyboardType: TextInputType.number,
                                                    controller: quantityController,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: '  ' + quantityController.text.trim() == '' ? quantityController.text.trim() : listtools[listtools.keys.toList()[index]].toString(),
                                                    ),
                                                  ),
                                                ),
                                                Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (listtools[listtools.keys.toList()[index]] > -9000) {
                                                      listtools[listtools.keys.toList()[index]] = listtools[listtools.keys.toList()[index]] + 1;
                                                      setState(() {});
                                                    }
                                                  },
                                                  child: SvgPicture.asset('assets/icons/Essentional, UI/Add Circle.svg'),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container();
                                  }))
                          : Container(),
                      Center(
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => SelectionDialog(
                                      Listtools: listtools,
                                    )).then((value) => setState(() {
                                  listtools = value;
                                }));
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(
                              'Добавьте инструменты и материалы',
                              style: TextStyle(color: Colors.black, fontSize: 14.sp),
                            ),
                          ]),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8).w,
                            ),
                            side: BorderSide(color: const Color.fromARGB(255, 3, 67, 244)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Поле для комментария
                      Text(
                        'Комментарий',
                        style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8).w,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: TextField(
                          controller: _projectcommentControler,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '  Комментарий',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),

                // Кнопка сохранения
                ElevatedButton(
                  onPressed: () {
                    // Действие при нажатии на кнопку "Сохранить"
                    if ((_projectnameControler.text.trim() != '') & (xfilePath != '')) {
                      if (widget.typeOpen == -1) {
                        widget.projectList.add(ProjectsClass(projectName: _projectnameControler.text.trim(), comment: _projectcommentControler.text.trim(), projectDescription: _projectdescriptionControler.text.trim(), xfilepath: xfilePath));
                        HiveBase().PutProjectsInBase(widget.projectList);
                        HiveBase().PutUsedtools(listtools, _projectnameControler.text.trim());
                        Navigator.pop(context);
                      } else {
                        widget.projectList.removeAt(widget.typeOpen);
                        widget.projectList.add(ProjectsClass(projectName: _projectnameControler.text.trim(), comment: _projectcommentControler.text.trim(), projectDescription: _projectdescriptionControler.text.trim(), xfilepath: xfilePath));
                        HiveBase().PutProjectsInBase(widget.projectList);
                        Navigator.pop(context);
                      }
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ((_projectnameControler.text.trim() != '') & (xfilePath != '')) ? Colors.blue : Colors.grey.shade300,
                    minimumSize: Size(double.infinity.w, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8).w,
                    ),
                  ),
                  child: Text(
                    'Сохранить',
                    style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
