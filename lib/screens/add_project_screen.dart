import 'package:flutter/material.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
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
      body: Padding(
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '  Название',
                      ),
                    ),
                  ),
                  SizedBox(height: QueryHeight / 45),

                  // Кнопка для добавления изображения
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Действие для добавления изображения проекта
                      },
                      icon: Icon(Icons.cloud_upload, color: Colors.blue),
                      label: Text(
                        'Добавьте изображение проекта',
                        style: TextStyle(color: Colors.grey),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: const Color.fromARGB(76, 224, 224, 224)),
                      ),
                    ),
                  ),
                  SizedBox(height: QueryHeight / 45),

                  // Поле для описания проекта
                  Text(
                    'Описание проекта',
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
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '  Описание проекта',
                      ),
                    ),
                  ),
                  SizedBox(height: QueryHeight / 45),

                  // Кнопка для добавления инструментов и материалов
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        // Действие для добавления инструментов и материалов
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          'Добавьте инструменты и материалы',
                          style: TextStyle(color: Colors.black),
                        ),
                      ]),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: const Color.fromARGB(255, 3, 67, 244)),
                      ),
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
