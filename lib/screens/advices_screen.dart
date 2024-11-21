import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:renovate_ranger/features/advices_data.dart';
import 'package:renovate_ranger/features/constans.dart/routerConst.dart';
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
        drawer: Container(
            width: 1.sw,
            child: Drawer(
                child: Container(
                    height: 1.sh,
                    width: 1.sw,
                    padding: EdgeInsets.all(20).w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(106, 0, 0, 0),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, 30.h, 0, 0)),
                        Row(children: [
                          Padding(padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0)),
                          Text(
                            "RenovateRanger",
                            style: TextStyle(fontSize: 24.sp),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              'assets/icons/Arrows/Round Arrow Left.svg',
                              width: 32.w,
                              height: 32.h,
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0))
                        ]),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0.h, 0, 0)),
                        Container(
                            height: menuItems.length * (74.5.h),
                            child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: menuItems.length,
                                separatorBuilder: (context, index) {
                                  return Padding(padding: EdgeInsets.all(7.5).w);
                                },
                                itemBuilder: (context, index) {
                                  return Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                                      margin: EdgeInsets.fromLTRB(0.w, 0, 0.w, 0),
                                      child: InkWell(
                                          onTap: () {
                                            if (menuItems[index]['navigation'] != null) {
                                              if (selectedscreen != index) {
                                                setState(() {
                                                  selectedscreen = index;
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => menuItems[index]['navigation'])).then((_) => setState(() {}));
                                                });
                                              }
                                            }
                                          },
                                          child: PhysicalModel(
                                            elevation: 0,
                                            color: const Color.fromARGB(0, 0, 0, 0),
                                            child: Container(
                                              height: 50.h,
                                              decoration: BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: const Color.fromARGB(28, 0, 0, 0),
                                                  blurRadius: 1.25,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(1.0, 1.0),
                                                )
                                              ], border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(10.r), color: const Color.fromARGB(255, 255, 255, 255)),
                                              child: Row(
                                                children: [
                                                  Padding(padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0)),
                                                  Text(
                                                    menuItems[index]['title'],
                                                    style: TextStyle(fontSize: 16.sp),
                                                  ),
                                                  Spacer(),
                                                  SvgPicture.asset(
                                                    'assets/icons/Arrows/Round Arrow Right.svg',
                                                    width: 32.w,
                                                    height: 32.h,
                                                  ),
                                                  Padding(padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0))
                                                ],
                                              ),
                                            ),
                                          )));
                                }))
                      ],
                    )))),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                  width: 32.w,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/icons/Essentional, UI/Sort.svg",
                    width: 32.w,
                  )),
            ),
          ),
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
