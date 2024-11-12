import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddToolsScreen extends StatefulWidget {
  const AddToolsScreen({super.key});

  @override
  State<AddToolsScreen> createState() => _AddToolsScreenState();
}

bool isTool = true; // Выбор между Инструментом и Материалом
bool isInStock = true; // Выбор статуса наличия
String? unit = 'шт.'; // Выбранная единица
final TextEditingController nameController = TextEditingController();
final TextEditingController priceController = TextEditingController();
final TextEditingController quantityController = TextEditingController();
final TextEditingController commentController = TextEditingController();

class _AddToolsScreenState extends State<AddToolsScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final commentController = TextEditingController();
  late String typeItem = '';
  int typeChanger = 0;
  int included = 0;
  @override
  Widget build(BuildContext context) {
    final QueryHeight = MediaQuery.of(context).size.height;
    final QueryWidth = MediaQuery.of(context).size.width;
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
          title: Text('Добавление пункта'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          height: QueryHeight - QueryHeight / 9,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: typeChanger == 2
                              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  GestureDetector(
                                    child: SvgPicture.asset(
                                      'lib/assets/icons/hammer/hammer=off.svg',
                                      width: 32,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        typeChanger = 1;
                                      });
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 90, 0, 0, 0)),
                                  Text(
                                    'Инструмент',
                                    style: TextStyle(fontSize: QueryWidth / 20),
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 17.5, 0, 0, 0)),
                                  GestureDetector(
                                    child: SvgPicture.asset(
                                      'lib/assets/icons/nail/nail=on.svg',
                                      width: 32,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        typeChanger = 0;
                                      });
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 90, 0, 0, 0)),
                                  Text(
                                    "Материал",
                                    style: TextStyle(fontSize: QueryWidth / 20),
                                  )
                                ])
                              : typeChanger == 1
                                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      GestureDetector(
                                        child: SvgPicture.asset(
                                          'lib/assets/icons/hammer/hammer=on.svg',
                                          width: 32,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            typeChanger = 0;
                                          });
                                        },
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 90, 0, 0, 0)),
                                      Text(
                                        'Инструмент',
                                        style: TextStyle(fontSize: QueryWidth / 20),
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 17.5, 0, 0, 0)),
                                      GestureDetector(
                                        child: SvgPicture.asset(
                                          'lib/assets/icons/nail/nail=off.svg',
                                          width: 32,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            typeChanger = 2;
                                          });
                                        },
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 90, 0, 0, 0)),
                                      Text(
                                        "Материал",
                                        style: TextStyle(fontSize: QueryWidth / 20),
                                      )
                                    ])
                                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      GestureDetector(
                                        child: SvgPicture.asset(
                                          'lib/assets/icons/hammer/hammer=off.svg',
                                          width: 32,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            typeChanger = 1;
                                          });
                                        },
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 90, 0, 0, 0)),
                                      Text(
                                        'Инструмент',
                                        style: TextStyle(fontSize: QueryWidth / 20),
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 17.5, 0, 0, 0)),
                                      GestureDetector(
                                        child: SvgPicture.asset(
                                          'lib/assets/icons/nail/nail=off.svg',
                                          width: 32,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            typeChanger = 2;
                                          });
                                        },
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 90, 0, 0, 0)),
                                      Text(
                                        "Материал",
                                        style: TextStyle(fontSize: QueryWidth / 20),
                                      )
                                    ])),
                      Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 90, 0, 0)),
                      Container(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Radio(
                            value: 1,
                            groupValue: included,
                            onChanged: (int? value) {
                              setState(() {
                                included = value!;
                              });
                            },
                            activeColor: Colors.blue, // Change the active radio button color here
                            fillColor: MaterialStateProperty.all(Colors.blue), // Change the fill color when selected
                            splashRadius: 20,
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 60, 0, 0, 0)),
                          Text('В наличии', style: TextStyle(fontSize: QueryWidth / 20)),
                          Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 23, 0, 0, 0)),
                          Radio(
                            value: 2,
                            groupValue: included,
                            onChanged: (int? value) {
                              setState(() {
                                included = value!;
                              });
                            },
                            activeColor: Colors.blue, // Change the active radio button color here
                            fillColor: MaterialStateProperty.all(Colors.blue), // Change the fill color when selected
                            splashRadius: 20,
                          ),
                          Text('Надо купить', style: TextStyle(fontSize: QueryWidth / 20)),
                        ]),
                      ),
                      // Поле для названия проекта
                      Text(
                        'Название',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      SizedBox(height: QueryHeight / 90),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: TextField(
                          onEditingComplete: () {
                            setState(() {});
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '  Название',
                          ),
                        ),
                      ),

                      SizedBox(height: QueryHeight / 45),

                      // Поле для описания проекта
                      Text(
                        'Стоимость',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      SizedBox(height: QueryHeight / 90),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: TextField(
                          controller: priceController,
                          maxLines: 3,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '  Стоимость',
                          ),
                        ),
                      ),
                      SizedBox(height: QueryHeight / 45),
                      Text(
                        'Колличество',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      SizedBox(height: QueryHeight / 90),
                      Container(
                        width: QueryWidth / 1.05,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              width: QueryWidth / 2,
                              child: TextField(
                                controller: quantityController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '  Колличество',
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(QueryWidth / 50, 0, 0, 0)),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0, color: const Color.fromARGB(0, 146, 30, 30)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                width: QueryWidth / 3.1,
                                child: DropdownMenu(
                                    menuHeight: QueryHeight / 2,
                                    inputDecorationTheme: InputDecorationTheme(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color.fromARGB(0, 244, 67, 54),
                                        ),
                                      ),
                                    ),
                                    onSelected: (value) {
                                      debugPrint(value);
                                      typeItem = value!;
                                    },
                                    dropdownMenuEntries: [
                                      DropdownMenuEntry(value: "шт.", label: "шт."),
                                      DropdownMenuEntry(value: "пар.", label: "пар."),
                                      DropdownMenuEntry(value: "м2", label: "м2"),
                                      DropdownMenuEntry(value: "м", label: "м"),
                                      DropdownMenuEntry(value: "см2", label: "см2"),
                                      DropdownMenuEntry(value: "см", label: "см"),
                                      DropdownMenuEntry(value: "куб.", label: "куб"),
                                    ]))
                          ],
                        ),
                      ),
                      SizedBox(height: QueryHeight / 45),
                      // Поле для комментария
                      Text(
                        'Комментарий',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      SizedBox(height: QueryHeight / 90),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: TextField(
                          controller: commentController,
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
                    if ((nameController.text.trim() != '') & (included != 0) & (typeChanger != 0) & (priceController.text.trim() != '') & (quantityController.text.trim() != '') & (typeItem != '') & (typeItem != null)) {
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ((nameController.text.trim() != '') & (included != 0) & (typeChanger != 0) & (priceController.text.trim() != '') & (quantityController.text.trim() != '') & (typeItem != '') & (typeItem != null)) ? Colors.blue : Colors.grey.shade300,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
