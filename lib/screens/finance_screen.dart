import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/models/finance.dart';
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

List<dynamic> categoryExpenses = HiveBase().GetFinanceFromBase();

class _FinanceScreenState extends State<FinanceScreen> {
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
            title: Text('Финансы'),
            centerTitle: true,
            actions: []),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(QueryHeight / 60),
          child: Container(
            height: QueryHeight,
            child: Column(
              children: [
                // Блок с круговой диаграммой и общей суммой
                Container(
                  padding: EdgeInsets.all(QueryWidth / 180),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: _buildChartSection(QueryWidth, QueryHeight),
                ),
                SizedBox(height: QueryHeight / 40),
                // Блок с историей расходов
                _buildExpenseHistory(QueryHeight),
                Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, QueryHeight / 6),
                  child: ElevatedButton(
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 61, 122, 228),
                      minimumSize: Size(double.infinity, QueryHeight / 17.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Добавить запись',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  Widget _buildExpenseHistory(double Qh) {
    return Container(
      height: Qh / 2.5,
      child: ListView.builder(
        itemCount: categoryExpenses.length,
        itemBuilder: (context, index) {
          final expense = categoryExpenses[index];
          return ListTileTheme(
              data: ListTileThemeData(),
              child: ListTile(
                title: Text(expense.name),
                subtitle: Text('${expense.type} • ${expense.date}'),
                trailing: Text(
                  '${expense.expanse} руб',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ));
        },
      ),
    );
  }

  List<PieChartSectionData> _getPieChartSections() {
    return categoryExpenses.map((entry) {
      int index = categoryExpenses.toList().indexOf(entry);
      return PieChartSectionData(color: ColorPieSetter(categoryExpenses[index].type), value: double.parse(categoryExpenses[index].expanse), title: '${entry.expanse} руб', radius: 75, showTitle: false);
    }).toList();
  }

  Widget _buildChartSection(double Qw, double Qh) {
    double total = 0;
    double material = 0;
    double tools = 0;
    double projects = 0;
    double works = 0;
    double other = 0;
    try {
      setState(() {
        categoryExpenses.forEach((e) {
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
        Row(children: [
          Text("Всего ", style: TextStyle(fontSize: 18)),
          Spacer(),
          Text(
            '${total.toStringAsFixed(0)} руб',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          Padding(padding: EdgeInsets.all(Qw / 30)),
          Container(
            width: Qw / 2.95,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
                setState(() {
                  typefinance = value!;
                });
              },
              hint: Text(typefinance == '' ? "  Тип" : typefinance, style: TextStyle(color: Colors.grey[400])),
            ),
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Qw / 2,
              child: AspectRatio(
                aspectRatio: 1.5,
                child: PieChart(
                  PieChartData(
                    sections: _getPieChartSections(),
                    centerSpaceRadius: 20,
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
                  decoration: BoxDecoration(color: const Color(0xff3ED0AD), borderRadius: BorderRadius.circular(60)),
                ),
                Padding(padding: EdgeInsets.all(Qw / 160)),
                Text(
                  "Материалы ",
                  style: TextStyle(fontSize: Qw / 40),
                ),
                Text(
                  material.toString() + " руб",
                  style: TextStyle(fontSize: Qw / 40),
                )
              ]),
              Padding(padding: EdgeInsets.fromLTRB(0, Qh / 160, 0, 0)),
              Row(children: [
                Container(
                  height: Qh / 40,
                  width: Qh / 40,
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 243, 153, 49), borderRadius: BorderRadius.circular(60)),
                ),
                Padding(padding: EdgeInsets.all(Qw / 120)),
                Text(
                  "Инструменты ",
                  style: TextStyle(fontSize: Qw / 40),
                ),
                Text(
                  tools.toString() + " руб",
                  style: TextStyle(fontSize: Qw / 40),
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
                  style: TextStyle(fontSize: Qw / 40),
                ),
                Text(
                  projects.toString() + " руб",
                  style: TextStyle(fontSize: Qw / 40),
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
                  style: TextStyle(fontSize: Qw / 40),
                ),
                Text(
                  works.toString() + " руб",
                  style: TextStyle(fontSize: Qw / 40),
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
                  style: TextStyle(fontSize: Qw / 40),
                ),
                Text(
                  other.toString() + " руб",
                  style: TextStyle(fontSize: Qw / 40),
                )
              ]),
              Padding(padding: EdgeInsets.fromLTRB(0, Qh / 12, 0, 0)),
            ])
          ],
        )
      ],
    );
  }

  // Функция для добавления новой записи расходов
  void _addExpense() {
    // Здесь должна быть логика добавления новой записи (например, открытие нового экрана или диалогового окна)
    // Пока просто добавим пример в список и обновим экран
    setState(() {
      categoryExpenses.add(Finance(name: 'Новый расход', expanse: '1000.0', date: DateTime.now().toString(), type: 'Другое'));
    });
  }
}
