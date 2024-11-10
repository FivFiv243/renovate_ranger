import 'package:flutter/material.dart';
import 'package:renovate_ranger/screens/add_contact_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
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
          title: Text('Контакты'),
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
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'У вас нет сохраненных контактов. ',
                    style: TextStyle(
                      fontSize: QueryWidth / 30,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewContactScreen()));
                    },
                    child: Text(
                      "Добавить контакт",
                      style: TextStyle(fontSize: QueryWidth / 30, color: const Color.fromARGB(255, 23, 62, 235), decoration: TextDecoration.underline, decorationColor: const Color.fromARGB(255, 23, 62, 235)),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
