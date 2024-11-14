import 'package:flutter/material.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';

class SelectionDialog extends StatefulWidget {
  SelectionDialog({super.key, required this.Listtools});
  late Map<dynamic, dynamic> Listtools;
  @override
  _SelectionDialogState createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  bool isToolsSelected = true; // Переключатель между "Инструменты" и "Материалы"
  List<dynamic> Listtools = HiveBase().GetToolsFromBase();
  Map<dynamic, dynamic> selectedItems = {}; // Состояние чекбоксов по имени элемента

  @override
  void initState() {
    super.initState();
    // Инициализируем состояние для каждого элемента в списке Listtools
    for (var item in Listtools) {
      selectedItems[item.name] = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Выберите инструменты и материалы',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Переключение между "Инструменты" и "Материалы"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isToolsSelected = true;
                    });
                  },
                  child: Text(
                    'Инструменты',
                    style: TextStyle(
                      color: isToolsSelected ? Colors.blue : Colors.black54,
                      fontWeight: isToolsSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isToolsSelected = false;
                    });
                  },
                  child: Text(
                    'Материалы',
                    style: TextStyle(
                      color: !isToolsSelected ? Colors.blue : Colors.black54,
                      fontWeight: !isToolsSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            // Список элементов (Инструменты или Материалы)
            Column(
              children: Listtools.where((item) => isToolsSelected ? item.mtool == 1 : item.mtool == 2)
                  .map<Widget>((item) => ListTile(
                        leading: Icon(
                          isToolsSelected ? Icons.gavel : Icons.layers,
                        ),
                        title: Text(item.name),
                        trailing: Checkbox(
                          value: selectedItems[item.name] == 0 ? false : true,
                          onChanged: (bool? value) {
                            setState(() {
                              selectedItems[item.name] == 0 ? selectedItems[item.name] = 1.0 : selectedItems[item.name] = 0.0;
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Закрыть'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Логика для выбранных элементов
                    setState(() {
                      widget.Listtools = selectedItems;
                    });
                    Navigator.of(context).pop(selectedItems);
                  },
                  child: Text('Выбрать'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
