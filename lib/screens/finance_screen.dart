import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:renovate_ranger/features/constans.dart/routerConst.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/models/finance.dart';
import 'package:renovate_ranger/main.dart';
import 'package:renovate_ranger/screens/add_finance_screen.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

Color ColorPieSetter(String type) {
  if (type == "Материалы") {
    return const Color(0xff3ED0AD);
  }
  if (type == "Инструменты") {
    return const Color.fromARGB(255, 243, 153, 49);
  }
  if (type == "Проект") {
    return const Color(0xffFF7373);
  }
  if (type == "Работы") {
    return const Color(0xffAFFE4B);
  } else {
    return const Color(0xff4BC8FE);
  }
}

String filter = 'Все время';
List<dynamic> categoryExpenses = HiveBase().GetFinanceFromBase();

class _FinanceScreenState extends State<FinanceScreen> {
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
            title: Text('Финансы'),
            centerTitle: true,
            actions: []),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(7.5).w,
          child: Container(
            height: 0.8885.sh,
            child: Column(
              children: [
                // Блок с круговой диаграммой и общей суммой
                Container(
                  padding: EdgeInsets.all(2.5).w,
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
                  child: _buildChartSection(1.sw, 1.sh),
                ),
                SizedBox(height: 10.h),
                // Блок с историей расходов
                _buildExpenseHistory(1.sh, 1.sw),
              ],
            ),
          ),
        )));
  }

  Widget _buildExpenseHistory(double Qh, double Qw) {
    int FilterSetter = -1;
    return Container(
        padding: EdgeInsets.all(2.5).w,
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
        height: 0.4445.sh,
        child: Column(children: [
          Expanded(
            flex: 150,
            child: ListView.builder(
              itemCount: categoryExpenses.length,
              itemBuilder: (context, index) {
                final expense = categoryExpenses[index];
                if (filter == "Все время") {
                  FilterSetter = 100000;
                }
                if (filter == "Месяц") {
                  FilterSetter = 30;
                }
                if (filter == "3 Месяца") {
                  FilterSetter = 91;
                }
                if (filter == "6 Месяцев") {
                  FilterSetter = 182;
                }
                if (filter == "Год") {
                  FilterSetter = 365;
                }
                if (DateTime.now().difference(DateTime.parse(expense.date)).inDays <= FilterSetter) {
                  return ListTileTheme(
                      data: ListTileThemeData(),
                      child: ListTile(
                        title: Text(expense.name.toString().substring(0, expense.name.toString().length > 30 ? 30 : expense.name.toString().length)),
                        subtitle: Text('${expense.type} • ${expense.date}'),
                        trailing: Text(
                          '${expense.expanse} руб',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ));
                }
              },
            ),
          ),
          Spacer(),
          Container(
            width: 350.w,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => AddFinanceScreen(
                                TypeOpen: -1,
                                financeList: categoryExpenses,
                              )))
                      .then((_) {
                    setState(() {});
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xff4B87FE), width: 2), // Цвет и толщина границы
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12).w, // Скругление углов
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.w), // Внутренние отступы
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Добавить запись',
                    style: TextStyle(
                      color: Colors.black, // Цвет текста
                      fontSize: 16.sp, // Размер текста
                    ),
                  ),
                ])),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
          )
        ]));
  }

  List<PieChartSectionData> _getPieChartSections() {
    int FilterSetter = -1;
    if (categoryExpenses.length > 0) {
      return categoryExpenses.map((entry) {
        if (filter == "Все время") {
          FilterSetter = 100000;
        }
        if (filter == "Месяц") {
          FilterSetter = 30;
        }
        if (filter == "3 Месяца") {
          FilterSetter = 91;
        }
        if (filter == "6 Месяцев") {
          FilterSetter = 182;
        }
        if (filter == "Год") {
          FilterSetter = 365;
        }
        if (DateTime.now().difference(DateTime.parse(entry.date)).inDays <= FilterSetter) {
          int index = categoryExpenses.toList().indexOf(entry);
          return PieChartSectionData(color: ColorPieSetter(categoryExpenses[index].type), value: double.parse(categoryExpenses[index].expanse), title: '${entry.expanse} руб', radius: 60.r, showTitle: false);
        } else {
          return PieChartSectionData(color: Colors.grey, value: 0, title: '${entry.expanse} руб', radius: 60.r, showTitle: false);
        }
      }).toList();
    } else {
      return [PieChartSectionData(color: Colors.grey, value: 100, radius: 60.r, showTitle: false)];
    }
  }

  Widget _buildChartSection(double Qw, double Qh) {
    double total = 0;
    double material = 0;
    double tools = 0;
    double projects = 0;
    double works = 0;
    double other = 0;
    try {
      int FilterSetter = -1;
      setState(() {
        categoryExpenses.forEach((e) {
          if (filter == "Все время") {
            FilterSetter = 100000;
          }
          if (filter == "Месяц") {
            FilterSetter = 30;
          }
          if (filter == "3 Месяца") {
            FilterSetter = 91;
          }
          if (filter == "6 Месяцев") {
            FilterSetter = 182;
          }
          if (filter == "Год") {
            FilterSetter = 365;
          }
          if (DateTime.now().difference(DateTime.parse(e.date)).inDays <= FilterSetter) {
            debugPrint(DateTime.parse(e.date).difference(DateTime.now()).inDays.toString());
            if (e.type == "Материалы") {
              material += double.parse(e.expanse);
            }
            if (e.type == "Инструменты") {
              tools += double.parse(e.expanse);
            }
            if (e.type == "Проекты") {
              projects += double.parse(e.expanse);
            }
            if (e.type == "Работы") {
              works += double.parse(e.expanse);
            } else {
              other += double.parse(e.expanse);
            }

            total += double.parse(e.expanse);
          }
        });
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        total = 0;
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(2.5.w, 10.h, 0, 0),
            child: Text(
              "Статистка расходов",
              style: TextStyle(fontSize: 18.sp, color: const Color(0xff4B87FE)),
            )),
        Row(children: [
          Text("Всего ", style: TextStyle(fontSize: 18.sp)),
          Spacer(),
          Text(
            '${total.toStringAsFixed(0)} руб',
            style: TextStyle(fontSize: 20.sp, color: const Color(0xff4B87FE)),
          ),
          Padding(padding: EdgeInsets.all(Qw / 30).w),
          Container(
            width: Qw / 2.80,
            padding: EdgeInsets.all(0).w,
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
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(border: InputBorder.none),
              items: [
                DropdownMenuItem(value: "Все время", child: Text("  Все время")),
                DropdownMenuItem(value: "Месяц", child: Text("  Месяц")),
                DropdownMenuItem(value: "3 Месяца", child: Text("  3 Месяц")),
                DropdownMenuItem(value: "6 Месяцев", child: Text("  6 Месяц")),
                DropdownMenuItem(value: "Год", child: Text("  Год")),
              ],
              onChanged: (value) {
                filter = value!;
                setState(() {});
              },
              hint: Text(typefinance == '' ? "  Тип" : typefinance, style: TextStyle(color: Colors.grey[400])),
            ),
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Qw / 2.35,
              child: AspectRatio(
                aspectRatio: 1.5,
                child: PieChart(
                  PieChartData(
                    sections: _getPieChartSections(),
                    centerSpaceRadius: 10.0.r,
                    sectionsSpace: 0,
                  ),
                ),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: EdgeInsets.fromLTRB(0, Qh / 15, 0, 0)),
              Row(children: [
                Container(
                  height: Qh / 40,
                  width: Qh / 40,
                  decoration: BoxDecoration(color: const Color(0xff3ED0AD), borderRadius: BorderRadius.circular(60).w),
                ),
                Padding(padding: EdgeInsets.all(Qw / 160).w),
                Text(
                  "Материалы ",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Text(
                  material.toString() + " руб",
                  style: TextStyle(fontSize: 12.sp),
                )
              ]),
              Padding(padding: EdgeInsets.fromLTRB(0, Qh / 160, 0, 0)),
              Row(children: [
                Container(
                  height: Qh / 40,
                  width: Qh / 40,
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 243, 153, 49), borderRadius: BorderRadius.circular(60)),
                ),
                Padding(padding: EdgeInsets.all(Qw / 120).w),
                Text(
                  "Инструменты ",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Text(
                  tools.toString() + " руб",
                  style: TextStyle(fontSize: 12.sp),
                )
              ]),
              Padding(padding: EdgeInsets.fromLTRB(0, Qh / 160, 0, 0)),
              Row(children: [
                Container(
                  height: Qh / 40,
                  width: Qh / 40,
                  decoration: BoxDecoration(color: const Color(0xffFF7373), borderRadius: BorderRadius.circular(60)),
                ),
                Padding(padding: EdgeInsets.all(Qw / 120)),
                Text(
                  "Проекты ",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Text(
                  projects.toString() + " руб",
                  style: TextStyle(fontSize: 12.sp),
                )
              ]),
              Padding(padding: EdgeInsets.fromLTRB(0, Qh / 160, 0, 0)),
              Row(children: [
                Container(
                  height: Qh / 40,
                  width: Qh / 40,
                  decoration: BoxDecoration(color: const Color(0xffAFFE4B), borderRadius: BorderRadius.circular(60)),
                ),
                Padding(padding: EdgeInsets.all(Qw / 120)),
                Text(
                  "Работы ",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Text(
                  works.toString() + " руб",
                  style: TextStyle(fontSize: 12.sp),
                )
              ]),
              Padding(padding: EdgeInsets.fromLTRB(0, Qh / 160, 0, 0)),
              Row(children: [
                Container(
                  height: Qh / 40,
                  width: Qh / 40,
                  decoration: BoxDecoration(color: const Color(0xff4BC8FE), borderRadius: BorderRadius.circular(60)),
                ),
                Padding(padding: EdgeInsets.all(Qw / 120)),
                Text(
                  "Другое ",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Text(
                  other.toString() + " руб",
                  style: TextStyle(fontSize: 12.sp),
                )
              ]),
              Padding(padding: EdgeInsets.fromLTRB(0, 15.h, 0, 0)),
            ])
          ],
        )
      ],
    );
  }
}
