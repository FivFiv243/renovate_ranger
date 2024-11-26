import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/features/constans.dart/routerConst.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/main.dart';
import 'package:renovate_ranger/screens/add_tools_screen.dart';

class ToolsAndMaterialsScreen extends StatefulWidget {
  const ToolsAndMaterialsScreen({super.key});

  @override
  State<ToolsAndMaterialsScreen> createState() => _ToolsAndMaterialsScreenState();
}

List<dynamic> Listtools = [];
int filterbuttonType = 0;
int filterdrop = 0;

class _ToolsAndMaterialsScreenState extends State<ToolsAndMaterialsScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Listtools = HiveBase().GetToolsOrMaterialFromBase();
  }

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
            title: Text(
              'Инструменты и материалы',
              style: TextStyle(fontSize: 14.sp),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => AddToolsScreen(
                                  toolsList: Listtools,
                                  Typeopen: -1,
                                )))
                        .then((_) => setState(() {}));
                  },
                  child: SvgPicture.asset(
                    'assets/icons/Notes/Document Add.svg',
                    width: 30,
                    height: 30,
                  )),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 5.w, 0))
            ]),
        body: Listtools.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, 110.h, 0, 0)),
                        SizedBox(
                          width: 0.8.sh,
                          height: 0.75.sw,
                          child: Image.asset('assets/images/toolsfiller.x2.png'),
                        ),
                        SizedBox(height: 0.h),
                        Text(
                          'Список пуст.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              )
            : Container(
                height: 1.sh,
                child: Column(children: [
                  Padding(padding: EdgeInsets.all(7.5).w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0).w,
                            ),
                            backgroundColor: filterbuttonType == 1 ? Colors.blue : const Color.fromARGB(0, 255, 193, 7),
                            side: BorderSide(width: 2.0.w, color: Colors.blue),
                          ),
                          onPressed: () {
                            setState(() {
                              if (filterbuttonType == 1) {
                                filterbuttonType = 0;
                              } else {
                                filterbuttonType = 1;
                              }
                            });
                          },
                          child: Text(
                            "В наличии",
                            style: TextStyle(color: Colors.black, fontSize: 12.sp),
                          )),
                      Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0).w,
                            ),
                            backgroundColor: filterbuttonType == 2 ? Colors.blue : const Color.fromARGB(0, 255, 193, 7),
                            side: BorderSide(width: 2.0.w, color: Colors.blue),
                          ),
                          onPressed: () {
                            setState(() {
                              if (filterbuttonType == 2) {
                                filterbuttonType = 0;
                              } else {
                                filterbuttonType = 2;
                              }
                            });
                          },
                          child: Text(
                            "Надо купить",
                            style: TextStyle(color: Colors.black, fontSize: 12.sp),
                          )),
                      Padding(padding: EdgeInsets.fromLTRB(7.5.w, 0, 0, 0)),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0, color: const Color.fromARGB(0, 146, 30, 30)),
                            borderRadius: BorderRadius.circular(8).w,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          width: 0.30.sw,
                          child: DropdownMenu(
                              hintText: filterdrop == 0
                                  ? "Все"
                                  : filterdrop == 1
                                      ? "Материалы"
                                      : "Инструменты",
                              menuHeight: 0.5.sh,
                              inputDecorationTheme: InputDecorationTheme(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(0, 244, 67, 54),
                                  ),
                                ),
                              ),
                              onSelected: (value) {
                                setState(() {
                                  filterdrop = value!;
                                });
                              },
                              dropdownMenuEntries: [
                                DropdownMenuEntry(value: 0, label: "Все"),
                                DropdownMenuEntry(value: 2, label: "Материалы"),
                                DropdownMenuEntry(value: 1, label: "Инструменты"),
                              ])),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 7.5.h, 0, 0)),
                  Expanded(
                      child: Container(
                    width: 0.95.sw,
                    child: ListView.separated(
                      itemCount: Listtools.length,
                      separatorBuilder: (context, index) {
                        return (((Listtools[index].isIn == filterbuttonType) || (filterbuttonType == 0)) && ((Listtools[index].mtool == filterdrop) || (filterdrop == 0))) ? Padding(padding: EdgeInsets.fromLTRB(0, 7.5.h, 0, 0)) : Container();
                      },
                      itemBuilder: (context, index) {
                        final quantityController = TextEditingController();
                        return (((Listtools[index].isIn == filterbuttonType) || (filterbuttonType == 0)) && ((Listtools[index].mtool == filterdrop) || (filterdrop == 0)))
                            ? Container(
                                width: 0.8.sw,
                                padding: EdgeInsets.all(7.5).w,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Listtools[index].mtool == 2 ? SvgPicture.asset('assets/icons/nail/nail=off.svg') : SvgPicture.asset('assets/icons/hammer/hammer=off.svg'),
                                        Padding(padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0)),
                                        Text(Listtools[index].name),
                                        Spacer(),
                                        Radio(
                                            value: 1,
                                            groupValue: Listtools[index].isIn,
                                            onChanged: (value) {
                                              setState(() {
                                                Listtools[index].isIn = value;
                                              });
                                              HiveBase().PutToolsOrMaterialInBase(Listtools);
                                            }),
                                        Padding(padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0)),
                                        Text('В наличии'),
                                        Padding(padding: EdgeInsets.fromLTRB(0.1.sw, 0, 0, 0)),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return Dialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(16.0).w,
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.0.w),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(16.0).w,
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
                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddToolsScreen(toolsList: Listtools, Typeopen: index))).then((_) => setState(() {}));
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
                                                                    Listtools.removeAt(index);
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
                                              });
                                              HiveBase().PutToolsOrMaterialInBase(Listtools);
                                            },
                                            child: SvgPicture.asset('assets/icons/Essentional, UI/Menu Dots.svg'))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (Listtools[index].quantity > 0) {
                                              Listtools[index].quantity = Listtools[index].quantity - 1;
                                              setState(() {});
                                              HiveBase().PutToolsOrMaterialInBase(Listtools);
                                            }
                                          },
                                          child: SvgPicture.asset('assets/icons/Essentional, UI/Minus Circle.svg'),
                                        ),
                                        Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                                        Container(
                                          width: 0.2.sw,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 0.w, color: const Color.fromARGB(0, 0, 0, 0)),
                                            borderRadius: BorderRadius.circular(8).w,
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                          child: TextField(
                                            onTap: () {
                                              quantityController.text = Listtools[index].quantity.toString();
                                            },
                                            onEditingComplete: () {
                                              setState(() {
                                                if (quantityController.text == '' || double.parse(quantityController.text.trim()) < -1) {
                                                  quantityController.text = '0';
                                                }
                                                Listtools[index].quantity = double.parse(quantityController.text.trim());
                                                quantityController.text = '';
                                              });
                                              HiveBase().PutToolsOrMaterialInBase(Listtools);
                                            },
                                            keyboardType: TextInputType.number,
                                            controller: quantityController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '  ' + quantityController.text.trim() == '' ? quantityController.text.trim() : Listtools[index].quantity.toString(),
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                                        GestureDetector(
                                          onTap: () {
                                            if (Listtools[index].quantity > -9000) {
                                              Listtools[index].quantity = Listtools[index].quantity + 1;
                                              setState(() {});
                                              HiveBase().PutToolsOrMaterialInBase(Listtools);
                                            }
                                          },
                                          child: SvgPicture.asset('assets/icons/Essentional, UI/Add Circle.svg'),
                                        ),
                                        Spacer(),
                                        Radio(
                                            value: 2,
                                            groupValue: Listtools[index].isIn,
                                            onChanged: (value) {
                                              setState(() {
                                                Listtools[index].isIn = value;
                                              });
                                              HiveBase().PutToolsOrMaterialInBase(Listtools);
                                            }),
                                        Padding(padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0)),
                                        Text('Надо купить'),
                                        Spacer()
                                      ],
                                    )
                                  ],
                                ))
                            : Container();
                      },
                    ),
                  ))
                ])));
  }
}
