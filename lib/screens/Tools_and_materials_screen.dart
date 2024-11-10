import 'package:flutter/material.dart';

class ToolsAndMaterialsScreen extends StatefulWidget {
  const ToolsAndMaterialsScreen({super.key});

  @override
  State<ToolsAndMaterialsScreen> createState() => _ToolsAndMaterialsScreenState();
}

class _ToolsAndMaterialsScreenState extends State<ToolsAndMaterialsScreen> {
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
          title: Text(
            'Инструменты и материалы',
            style: TextStyle(fontSize: QueryWidth / 20),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Действие при нажатии на меню
              },
            ),
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                // Заглушка для изображения
                // SizedBox(
                //   height: 200,
                //   child: Image.asset('assets/images/illustration.png'),
                // ),
                SizedBox(height: QueryHeight / 40),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 122, 228),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Добавить проект',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
