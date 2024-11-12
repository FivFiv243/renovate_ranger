import 'package:flutter/material.dart';
import 'package:renovate_ranger/features/advices_data.dart';

class AdvicesScreen extends StatefulWidget {
  const AdvicesScreen({super.key});

  @override
  State<AdvicesScreen> createState() => _AdvicesScreenState();
}

final _adviceData = AdvicesData().adviceData;

class _AdvicesScreenState extends State<AdvicesScreen> {
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
          title: Text("Советы"),
          centerTitle: true,
        ),
        body: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent), // Убираем линии
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(QueryHeight / 45),
                child: Column(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('lib/assets/images/advice_image.jpg'),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 45, 0, 0)),
                  Column(
                    children: _adviceData.map((item) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: QueryHeight / 70),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ExpansionTile(
                              collapsedBackgroundColor: Colors.transparent,
                              tilePadding: EdgeInsets.symmetric(horizontal: QueryWidth / 45),
                              title: Text(
                                item['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              childrenPadding: EdgeInsets.symmetric(horizontal: QueryWidth / 45, vertical: QueryHeight / 90),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              children: (item['content'] as List<String>).map((point) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: QueryHeight / 90),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '- ',
                                        style: TextStyle(color: Colors.black87, fontSize: 14),
                                      ),
                                      Expanded(
                                        child: Text(
                                          point,
                                          style: TextStyle(color: Colors.black87, fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ]),
              ),
            )));
  }
}
