import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/screens/add_tools_screen.dart';

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
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddToolsScreen()));
                },
                child: SvgPicture.asset(
                  'lib/assets/icons/Notes/Document Add.svg',
                  width: 30,
                  height: 30,
                )),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, QueryWidth / 30, 0))
          ]),
      body: Column(
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
      ),
    );
  }
}
