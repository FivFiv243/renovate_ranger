import 'package:flutter/material.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
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
        title: Text('Новый контакт'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(QueryHeight / 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Поле для ввода ФИО
            Text(
              'ФИО',
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '  ФИО',
                ),
              ),
            ),
            SizedBox(height: QueryHeight / 45),

            // Поле для ввода номера телефона
            Text(
              'Номер телефона',
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '  Номер телефона',
                ),
              ),
            ),
            SizedBox(height: QueryHeight / 45),

            // Поле для ввода электронной почты
            Text(
              'Электронная почта',
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '  Электронная почта',
                ),
              ),
            ),
            SizedBox(height: 16),

            // Поле для ввода выполненных работ
            Text(
              'Выполненные работы',
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '  Выполненные работы',
                ),
              ),
            ),
            SizedBox(height: 16),

            // Поле для ввода отзыва
            Text(
              'Отзыв',
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '  Отзыв',
                ),
              ),
            ),
            Spacer(),

            // Кнопка сохранения
            ElevatedButton(
              onPressed: () {
                // Действие при нажатии на кнопку "Сохранить"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Сохранить',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
