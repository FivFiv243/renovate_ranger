import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:renovate_ranger/features/advices_data.dart';
import 'package:renovate_ranger/features/designed_widgets/customDialog.dart';

class AdvicesScreen extends StatefulWidget {
  const AdvicesScreen({super.key});

  @override
  State<AdvicesScreen> createState() => _AdvicesScreenState();
}

final _adviceData = AdvicesData().adviceData;

class _AdvicesScreenState extends State<AdvicesScreen> {
  @override
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
          title: Text("Советы"),
          centerTitle: true,
        ),
        body: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent), // Убираем линии
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10).w,
                child: Column(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8).w,
                    child: Image.asset('assets/images/advice_image.jpg'),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0)),
                  Column(
                    children: _adviceData.map((item) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 6.5.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12).w,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12).w,
                            child: ExpansionTile(
                              collapsedBackgroundColor: Colors.transparent,
                              tilePadding: EdgeInsets.symmetric(horizontal: 10.h),
                              title: Text(
                                item['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              childrenPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              children: (item['content'] as List<String>).map((point) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 5.h),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '- ',
                                        style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                                      ),
                                      Expanded(
                                        child: Text(
                                          point,
                                          style: TextStyle(color: Colors.black87, fontSize: 14.sp),
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
