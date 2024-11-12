import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
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
    Listtools = HiveBase().GetToolsFromBase();
  }

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
            title: Text(
              'Инструменты и материалы',
              style: TextStyle(fontSize: QueryWidth / 20),
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
                    'lib/assets/icons/Notes/Document Add.svg',
                    width: 30,
                    height: 30,
                  )),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, QueryWidth / 30, 0))
            ]),
        body: Listtools.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 5, 0, 0)),
                        SizedBox(
                          width: QueryWidth / 1.1,
                          height: QueryHeight / 4,
                          child: Image.asset('lib/assets/images/toolsfiller.x2.png'),
                        ),
                        SizedBox(height: QueryHeight / 90),
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
                height: QueryHeight,
                child: Column(children: [
                  Padding(padding: EdgeInsets.all(QueryWidth / 60)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: filterbuttonType == 1 ? Colors.blue : const Color.fromARGB(0, 255, 193, 7),
                            side: BorderSide(width: 2.0, color: Colors.blue),
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
                            style: TextStyle(color: Colors.black),
                          )),
                      Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 90, 0, 0, 0)),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: filterbuttonType == 2 ? Colors.blue : const Color.fromARGB(0, 255, 193, 7),
                            side: BorderSide(width: 2.0, color: Colors.blue),
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
                            style: TextStyle(color: Colors.black),
                          )),
                      Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 60, 0, 0, 0)),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0, color: const Color.fromARGB(0, 146, 30, 30)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          width: QueryWidth / 3.3,
                          child: DropdownMenu(
                              hintText: filterdrop == 0
                                  ? "Все"
                                  : filterdrop == 1
                                      ? "Материалы"
                                      : "Инструменты",
                              menuHeight: QueryHeight / 2,
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
                  Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 60, 0, 0)),
                  Expanded(
                    child: ListView.separated(
                      itemCount: Listtools.length,
                      separatorBuilder: (context, index) {
                        return (((Listtools[index].isIn == filterbuttonType) || (filterbuttonType == 0)) && ((Listtools[index].mtool == filterdrop) || (filterdrop == 0))) ? Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 60, 0, 0)) : Container();
                      },
                      itemBuilder: (context, index) {
                        final quantityController = TextEditingController();
                        return (((Listtools[index].isIn == filterbuttonType) || (filterbuttonType == 0)) && ((Listtools[index].mtool == filterdrop) || (filterdrop == 0)))
                            ? Container(
                                width: QueryWidth / 1.1,
                                padding: EdgeInsets.all(QueryHeight / 60),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Listtools[index].mtool == 2 ? SvgPicture.asset('lib/assets/icons/nail/nail=off.svg') : SvgPicture.asset('lib/assets/icons/hammer/hammer=off.svg'),
                                        Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 45, 0, 0, 0)),
                                        Text(Listtools[index].name),
                                        Spacer(),
                                        Radio(
                                            value: 1,
                                            groupValue: Listtools[index].isIn,
                                            onChanged: (value) {
                                              setState(() {
                                                Listtools[index].isIn = value;
                                              });
                                              HiveBase().PutToolsInBase(Listtools);
                                            }),
                                        Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 45, 0, 0, 0)),
                                        Text('В наличии'),
                                        Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 10, 0, 0, 0)),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
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
                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddToolsScreen(toolsList: Listtools, Typeopen: index))).then((_) => setState(() {}));
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
                                                                    Listtools.removeAt(index);
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
                                              });
                                              HiveBase().PutToolsInBase(Listtools);
                                            },
                                            child: SvgPicture.asset('lib/assets/icons/Essentional, UI/Menu Dots.svg'))
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
                                              HiveBase().PutToolsInBase(Listtools);
                                            }
                                          },
                                          child: SvgPicture.asset('lib/assets/icons/Essentional, UI/Minus Circle.svg'),
                                        ),
                                        Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 90, 0, 0, 0)),
                                        Container(
                                          width: QueryWidth / 5,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                                            borderRadius: BorderRadius.circular(8),
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
                                              HiveBase().PutToolsInBase(Listtools);
                                            },
                                            keyboardType: TextInputType.number,
                                            controller: quantityController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '  ' + quantityController.text.trim() == '' ? quantityController.text.trim() : Listtools[index].quantity.toString(),
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 90, 0, 0, 0)),
                                        GestureDetector(
                                          onTap: () {
                                            if (Listtools[index].quantity > -9000) {
                                              Listtools[index].quantity = Listtools[index].quantity + 1;
                                              setState(() {});
                                              HiveBase().PutToolsInBase(Listtools);
                                            }
                                          },
                                          child: SvgPicture.asset('lib/assets/icons/Essentional, UI/Add Circle.svg'),
                                        ),
                                        Spacer(),
                                        Radio(
                                            value: 2,
                                            groupValue: Listtools[index].isIn,
                                            onChanged: (value) {
                                              setState(() {
                                                Listtools[index].isIn = value;
                                              });
                                              HiveBase().PutToolsInBase(Listtools);
                                            }),
                                        Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 45, 0, 0, 0)),
                                        Text('Надо купить'),
                                        Spacer()
                                      ],
                                    )
                                  ],
                                ))
                            : Container();
                      },
                    ),
                  )
                ])));
  }
}
