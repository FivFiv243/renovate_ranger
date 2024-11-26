import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/features/constans.dart/routerConst.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/models/contact_class.dart';
import 'package:renovate_ranger/main.dart';
import 'package:renovate_ranger/screens/add_contact_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

late List<dynamic> contacts;

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  @override
  void initState() {
    super.initState();
    setState(() {
      contacts = HiveBase().GetPhoneFromBase();
    });
  }

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
                bottom: Radius.circular(12),
              ),
            ),
            title: Text('Контакты'),
            centerTitle: true,
            actions: []),
        body: contacts.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Column(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 0.25.sh, 0, 0)),
                      SizedBox(
                        width: 0.9.sw,
                        height: 0.25.sh,
                        child: Image.asset('assets/images/contactsfiller.x2.png'),
                      ),
                      SizedBox(height: 30.h),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          'У вас нет сохраненных контактов. ',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => NewContactScreen(
                                          num: -1,
                                          PhonesList: contacts,
                                        )))
                                .then((_) => setState(() {}));
                          },
                          child: Text(
                            "Добавить контакт",
                            style: TextStyle(fontSize: 13.sp, color: const Color(0xff4B87FE), decoration: TextDecoration.underline, decorationColor: const Color.fromARGB(255, 23, 62, 235)),
                          ),
                        ),
                      ]),
                    ],
                  )),
                  Spacer(),
                ],
              )
            : Center(
                child: Container(
                    height: 1.sh,
                    child: Expanded(
                      child: Column(children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.fromLTRB(0, 12.h, 0, 0),
                          width: 0.9.sw,
                          child: Expanded(
                              child: ListView.separated(
                                  itemCount: contacts.length + 1,
                                  separatorBuilder: (context, index) {
                                    return Padding(padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0));
                                  },
                                  itemBuilder: (context, index) {
                                    return index < contacts.length
                                        ? Container(
                                            width: 0.90.sw,
                                            padding: EdgeInsets.all(7.5).w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(children: [
                                                  Text(
                                                    contacts[index].name,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(15.0),
                                                            ),
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.0.w),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(15.0).w,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  TextButton(
                                                                    child: Text(
                                                                      "Редактировать",
                                                                      style: TextStyle(
                                                                        fontSize: 16.sp,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: Colors.black87,
                                                                      ),
                                                                    ),
                                                                    onPressed: () {
                                                                      Navigator.pop(context);
                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewContactScreen(PhonesList: contacts, num: index))).then((_) => setState(() {}));
                                                                    },
                                                                  ),
                                                                  Divider(
                                                                    color: Colors.grey.shade300,
                                                                    thickness: 1.0,
                                                                    height: 20.0.h,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      // Добавьте логику для удаления
                                                                      Navigator.of(context).pop(); // Закрыть диалог после нажатия
                                                                    },
                                                                    child: TextButton(
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          contacts.removeAt(index);
                                                                        });
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child: Text(
                                                                        "Удалить",
                                                                        style: TextStyle(
                                                                          fontSize: 16.sp,
                                                                          fontWeight: FontWeight.w500,
                                                                          color: Colors.red,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: SvgPicture.asset('assets/icons/Essentional, UI/Menu Dots.svg'),
                                                  ),
                                                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 5.w, 0))
                                                ]),
                                                SizedBox(height: 5.h),

                                                // Phone number and Email row
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/Call/Phone Rounded.svg',
                                                      width: 24,
                                                    ),
                                                    SizedBox(width: 7.5.w),
                                                    Text(
                                                      contacts[index].number,
                                                      style: TextStyle(
                                                        fontSize: 12.w,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    contacts[index].email != '' ? SvgPicture.asset('assets/icons/email/Property 1=Linear, Property 2=Messages, Conversation, Property 3=Letter.svg') : Container(),
                                                    SizedBox(width: 2.5.w),
                                                    contacts[index].email != ''
                                                        ? Text(
                                                            contacts[index].email,
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: Colors.black87,
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),

                                                contacts[index].job != '' ? SizedBox(height: 7.5.sp) : Container(),

                                                // Service description
                                                contacts[index].job != ''
                                                    ? Text(
                                                        contacts[index].job,
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.black87,
                                                        ),
                                                      )
                                                    : Container(),
                                                SizedBox(height: 5.h),

                                                // Additional description
                                                contacts[index].callback != ''
                                                    ? Text(
                                                        contacts[index].callback,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.black54,
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          )
                                        : Container();
                                  })),
                        )),
                        Container(
                          width: 0.9.sw,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => NewContactScreen(
                                            num: -1,
                                            PhonesList: contacts,
                                          )))
                                  .then((_) => setState(() {}));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff4B87FE),
                              minimumSize: Size(double.infinity.w, 50.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12).w,
                              ),
                            ),
                            child: Text(
                              'Добавить контакт',
                              style: TextStyle(fontSize: 16.sp, color: Colors.white),
                            ),
                          ),
                        )
                      ]),
                    ))));
  }
}
