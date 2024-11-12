import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/models/contact_class.dart';
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
          actions: []),
      body: contacts.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Column(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 5, 0, 0)),
                    SizedBox(
                      width: QueryWidth / 1.1,
                      height: QueryHeight / 4,
                      child: Image.asset('lib/assets/images/contactsfiller.x2.png'),
                    ),
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
                          style: TextStyle(fontSize: QueryWidth / 30, color: const Color.fromARGB(255, 23, 62, 235), decoration: TextDecoration.underline, decorationColor: const Color.fromARGB(255, 23, 62, 235)),
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
                height: QueryHeight,
                child: ListView.separated(
                    itemCount: contacts.length + 1,
                    separatorBuilder: (context, index) {
                      return Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 45, 0, 0));
                    },
                    itemBuilder: (context, index) {
                      return index < contacts.length
                          ? Container(
                              width: QueryWidth / 1.1,
                              padding: EdgeInsets.all(QueryHeight / 60),
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
                                        fontSize: QueryWidth / 32,
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
                                                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    TextButton(
                                                      child: Text(
                                                        "Редактировать",
                                                        style: TextStyle(
                                                          fontSize: QueryWidth / 20,
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
                                                      height: 20.0,
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
                                                            fontSize: QueryWidth / 20,
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
                                      child: SvgPicture.asset('lib/assets/icons/Essentional, UI/Menu Dots.svg'),
                                    ),
                                    Padding(padding: EdgeInsets.fromLTRB(0, 0, QueryWidth / 60, 0))
                                  ]),
                                  SizedBox(height: QueryHeight / 80),

                                  // Phone number and Email row
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'lib/assets/icons/Call/Phone Rounded.svg',
                                        width: 24,
                                      ),
                                      SizedBox(width: QueryWidth / 60),
                                      Text(
                                        contacts[index].number,
                                        style: TextStyle(
                                          fontSize: QueryWidth / 30,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(width: QueryWidth / 30),
                                      contacts[index].email != '' ? SvgPicture.asset('lib/assets/icons/email/Property 1=Linear, Property 2=Messages, Conversation, Property 3=Letter.svg') : Container(),
                                      SizedBox(width: QueryWidth / 60),
                                      contacts[index].email != ''
                                          ? Text(
                                              contacts[index].email,
                                              style: TextStyle(
                                                fontSize: QueryWidth / 30,
                                                color: Colors.black87,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),

                                  contacts[index].job != '' ? SizedBox(height: QueryHeight / 60) : Container(),

                                  // Service description
                                  contacts[index].job != ''
                                      ? Text(
                                          contacts[index].job,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(height: QueryHeight / 90),

                                  // Additional description
                                  contacts[index].callback != ''
                                      ? Text(
                                          contacts[index].callback,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            )
                          : Center(
                              child: GestureDetector(
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
                                style: TextStyle(fontSize: QueryWidth / 30, color: const Color.fromARGB(255, 23, 62, 235), decoration: TextDecoration.underline, decorationColor: const Color.fromARGB(255, 23, 62, 235)),
                              ),
                            ));
                    }),
              ),
            ),
    );
  }
}
