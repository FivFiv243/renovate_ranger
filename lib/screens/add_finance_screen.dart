import 'package:flutter/material.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/models/finance.dart';

class AddFinanceScreen extends StatefulWidget {
  AddFinanceScreen({super.key, required this.TypeOpen, required this.financeList});
  int TypeOpen;
  List<dynamic> financeList;
  @override
  State<AddFinanceScreen> createState() => _AddFinanceScreenState();
}

DateTime? selectedDate;
//controllers
final _nameController = TextEditingController();
final _sumController = TextEditingController();
final _commentController = TextEditingController();

//type
String typefinance = '';

class _AddFinanceScreenState extends State<AddFinanceScreen> {
  @override
  @override
  void initState() {
    super.initState();
    selectedDate = null;
    typefinance = '';
    _nameController.text = '';
    _sumController.text = '';
    _commentController.text = '';
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
          title: Text('Новая запись'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            height: QueryHeight / 1.135,
            child: Column(children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(QueryHeight / 60),
                  child: Container(
                    padding: EdgeInsets.all(QueryHeight / 60),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Поле "Название"
                        Text(
                          "Название",
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        SizedBox(height: QueryHeight / 100),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(hintText: "  Название", hintStyle: TextStyle(color: Colors.grey[400]), border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: QueryHeight / 40),

                        // Поля "Сумма" и "Тип"
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Сумма",
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: QueryHeight / 100),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.withOpacity(0.1),
                                    ),
                                    child: TextField(
                                      controller: _sumController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(hintText: "  Сумма", hintStyle: TextStyle(color: Colors.grey[400]), border: InputBorder.none),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: QueryWidth / 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Тип",
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: QueryHeight / 100),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.withOpacity(0.1),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(border: InputBorder.none),
                                      items: [
                                        DropdownMenuItem(value: "Материалы", child: Text("  Материалы")),
                                        DropdownMenuItem(value: "Инструменты", child: Text("  Инструменты")),
                                        DropdownMenuItem(value: "Проекты", child: Text("  Проекты")),
                                        DropdownMenuItem(value: "Работы", child: Text("  Работы")),
                                        DropdownMenuItem(value: "Другое", child: Text("  Другое")),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          typefinance = value!;
                                        });
                                      },
                                      hint: Text(typefinance == '' ? "  Тип" : typefinance, style: TextStyle(color: Colors.grey[400])),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: QueryHeight / 40),

                        // Поле "Дата"
                        Text(
                          "Дата",
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        SizedBox(height: QueryHeight / 100),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: TextField(
                            readOnly: true,
                            onTap: () async {
                              selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              ).whenComplete(() {
                                setState(() {});
                              });
                              // Обработка выбранной даты
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: InputBorder.none,
                              hintText: selectedDate == null ? "  Дата" : selectedDate.toString(),
                              suffixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: QueryHeight / 40),

                        // Поле "Комментарий"
                        Text(
                          "Комментарий",
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        SizedBox(height: QueryHeight / 100),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: TextField(
                            controller: _commentController,
                            minLines: 1,
                            maxLines: 4,
                            decoration: InputDecoration(hintText: "  Комментарий", hintStyle: TextStyle(color: Colors.grey[400]), border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: QueryHeight / 80),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(QueryHeight / 90),
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.TypeOpen == -1) {
                      if (_nameController.text.trim() != '' && _sumController.text.trim() != '' && _sumController.text.trim() != '' && typefinance != '') {
                        widget.financeList.add(Finance(name: _nameController.text.trim(), expanse: _sumController.text.trim(), date: selectedDate.toString(), type: typefinance));
                        HiveBase().PutFinanceInBase(widget.financeList);
                        Navigator.of(context).pop();
                      }
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (_nameController.text.trim() != '' && _sumController.text.trim() != '' && _sumController.text.trim() != '' && typefinance != '') ? const Color.fromARGB(255, 61, 122, 228) : Colors.grey,
                    minimumSize: Size(double.infinity, QueryHeight / 17.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Сохранить',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
