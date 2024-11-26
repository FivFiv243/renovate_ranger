import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/models/item_class.dart';

class AddToolsScreen extends StatefulWidget {
  const AddToolsScreen({super.key, required this.toolsList, required this.Typeopen});
  final List<dynamic> toolsList;
  final int Typeopen;
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
  late String typeItem = '';
  int typeChanger = 0;
  int included = 0;
  @override
  @override
  void initState() {
    super.initState();
    if (widget.Typeopen == -1) {
      typeChanger = 0;
      included = 0;
      typeItem = '';
      nameController.text = '';
      priceController.text = '';
      quantityController.text = '';
      commentController.text = '';
    } else {
      typeChanger = widget.toolsList[widget.Typeopen].mtool;
      included = widget.toolsList[widget.Typeopen].isIn;
      typeItem = widget.toolsList[widget.Typeopen].typeCount;
      nameController.text = widget.toolsList[widget.Typeopen].name;
      priceController.text = widget.toolsList[widget.Typeopen].price.toString();
      quantityController.text = widget.toolsList[widget.Typeopen].quantity.toString();
      commentController.text = widget.toolsList[widget.Typeopen].comment;
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
          height: 720.h,
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
                      Container(
                          child: typeChanger == 2
                              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text(
                                    "1.",
                                    style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0.w, 0, 25.w, 0),
                                  ),
                                  GestureDetector(
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        'assets/icons/hammer/hammer=off.svg',
                                        width: 32.w,
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                                      Text(
                                        'Инструмент',
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ]),
                                    onTap: () {
                                      setState(() {
                                        typeChanger = 1;
                                      });
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(12.w, 0, 0, 0)),
                                  GestureDetector(
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        'assets/icons/nail/nail=on.svg',
                                        width: 32.w,
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(7.5.w, 0, 0, 0)),
                                      Text(
                                        "Материал",
                                        style: TextStyle(fontSize: 16.sp),
                                      )
                                    ]),
                                    onTap: () {
                                      setState(() {
                                        typeChanger = 0;
                                      });
                                    },
                                  ),
                                ])
                              : typeChanger == 1
                                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text(
                                        "1.",
                                        style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.w, 0, 25.w, 0),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              typeChanger = 0;
                                            });
                                          },
                                          child: Row(children: [
                                            SvgPicture.asset(
                                              'assets/icons/hammer/hammer=on.svg',
                                              width: 32.w,
                                            ),
                                            Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                                            Text(
                                              'Инструмент',
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                          ])),
                                      Padding(padding: EdgeInsets.fromLTRB(16.w, 0, 0, 0)),
                                      GestureDetector(
                                        child: Row(children: [
                                          SvgPicture.asset(
                                            'assets/icons/nail/nail=off.svg',
                                            width: 32.w,
                                          ),
                                          Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                                          Text(
                                            "Материал",
                                            style: TextStyle(fontSize: 16.sp),
                                          )
                                        ]),
                                        onTap: () {
                                          setState(() {
                                            typeChanger = 2;
                                          });
                                        },
                                      ),
                                    ])
                                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      GestureDetector(
                                        child: Row(children: [
                                          Text(
                                            "1.",
                                            style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0.w, 0, 25.w, 0),
                                          ),
                                          SvgPicture.asset(
                                            'assets/icons/hammer/hammer=off.svg',
                                            width: 32.w,
                                          ),
                                          Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                                          Text(
                                            'Инструмент',
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                        ]),
                                        onTap: () {
                                          setState(() {
                                            typeChanger = 1;
                                          });
                                        },
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(16.w, 0, 0, 0)),
                                      GestureDetector(
                                        child: Row(children: [
                                          SvgPicture.asset(
                                            'assets/icons/nail/nail=off.svg',
                                            width: 32.w,
                                          ),
                                          Padding(padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0)),
                                          Text(
                                            "Материал",
                                            style: TextStyle(fontSize: 16.sp),
                                          )
                                        ]),
                                        onTap: () {
                                          setState(() {
                                            typeChanger = 2;
                                          });
                                        },
                                      ),
                                    ])),
                      Padding(padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0)),
                      Container(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(
                            "2.",
                            style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.w, 0, 5.w, 0),
                          ),
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
                            splashRadius: 20.r,
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0)),
                          Row(children: [
                            Text('В наличии', style: TextStyle(fontSize: 16.sp)),
                          ]),
                          Padding(padding: EdgeInsets.fromLTRB(11.w, 0, 0, 0)),
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
                            splashRadius: 20.r,
                          ),
                          Text('Надо купить', style: TextStyle(fontSize: 16.sp)),
                        ]),
                      ),
                      // Поле для названия проекта
                      Row(children: [
                        Padding(padding: EdgeInsets.all(6).w),
                        Text(
                          "3.",
                          style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 0, 0.w, 0),
                        ),
                        Text(
                          'Название',
                          style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                        ),
                      ]),
                      SizedBox(height: 5.h),
                      Container(
                        margin: EdgeInsets.fromLTRB(35.w, 0, 0, 0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.w, color: const Color.fromARGB(0, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8).w,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: TextField(
                          onEditingComplete: () {
                            setState(() {});
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10).w,
                            border: InputBorder.none,
                            hintText: '  Название',
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Поле для описания проекта
                      Row(children: [
                        Padding(padding: EdgeInsets.all(6).w),
                        Text(
                          "4.",
                          style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 0, 0.w, 0),
                        ),
                        Text(
                          'Стоимость',
                          style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                        ),
                      ]),
                      SizedBox(height: 5.h),
                      Container(
                        margin: EdgeInsets.fromLTRB(35.w, 0, 0, 0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.w, color: const Color.fromARGB(0, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8).w,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: priceController,
                          maxLines: 3,
                          minLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10).w,
                            border: InputBorder.none,
                            hintText: '  Стоимость',
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(children: [
                        Padding(padding: EdgeInsets.all(6).w),
                        Text(
                          "5.",
                          style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 0, 0.w, 0),
                        ),
                        Text(
                          'Колличество',
                          style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                        ),
                      ]),
                      SizedBox(height: 5.h),
                      Container(
                        width: 0.9.sw,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(35.w, 0, 0, 0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.w, color: const Color.fromARGB(0, 0, 0, 0)),
                                borderRadius: BorderRadius.circular(8).w,
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              width: 0.415.sw,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: quantityController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10).w,
                                  border: InputBorder.none,
                                  hintText: '  Колличество',
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(7.5.w, 0, 0, 0)),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.w, color: const Color.fromARGB(0, 146, 30, 30)),
                                  borderRadius: BorderRadius.circular(8).w,
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                width: 0.3.sw,
                                child: DropdownMenu(
                                    hintText: typeItem,
                                    menuHeight: 0.5.sh,
                                    inputDecorationTheme: InputDecorationTheme(
                                      contentPadding: EdgeInsets.all(10).w,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color.fromARGB(0, 244, 67, 54),
                                        ),
                                      ),
                                    ),
                                    onSelected: (value) {
                                      debugPrint(value);
                                      typeItem = value!;
                                      setState(() {});
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
                      SizedBox(height: 8.h),
                      // Поле для комментария
                      Row(children: [
                        Padding(padding: EdgeInsets.all(6).w),
                        Text(
                          "6.",
                          style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 0, 0.w, 0),
                        ),
                        Text(
                          'Комментарий',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ]),
                      SizedBox(height: 5.h),
                      Container(
                        margin: EdgeInsets.fromLTRB(35.w, 0, 0, 0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: TextField(
                          minLines: 1,
                          maxLines: 3,
                          controller: commentController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10).w,
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
                    if ((nameController.text.trim() != '') & (included != 0) & (typeChanger != 0) & (priceController.text.trim() != '') & (quantityController.text.trim() != '') & (typeItem != '')) {
                      if (widget.Typeopen == -1) {
                        if (double.parse(quantityController.text.trim()) < 0) {
                          quantityController.text = '0';
                        }
                        widget.toolsList.add(ItemClass(mtool: typeChanger, isIn: included, name: nameController.text.trim(), price: priceController.text.trim(), quantity: double.parse(quantityController.text.trim()), comment: commentController.text.trim(), typeCount: typeItem));
                        HiveBase().PutToolsOrMaterialInBase(widget.toolsList);
                        Navigator.pop(context);
                      } else {
                        widget.toolsList.removeAt(widget.Typeopen);
                        if (double.parse(quantityController.text.trim()) < 0) {
                          quantityController.text = '0';
                        }
                        widget.toolsList.add(ItemClass(mtool: typeChanger, isIn: included, name: nameController.text.trim(), price: priceController.text.trim(), quantity: double.parse(quantityController.text.trim()), comment: commentController.text.trim(), typeCount: typeItem));
                        HiveBase().PutToolsOrMaterialInBase(widget.toolsList);
                        Navigator.pop(context);
                      }
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ((nameController.text.trim() != '') && (included != 0) && (typeChanger != 0) && (priceController.text.trim() != '') && (quantityController.text.trim() != '') && (typeItem != '') && (typeItem != '')) ? Colors.blue : Colors.grey.shade300,
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
