import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/features/models/contact_class.dart';
import 'package:renovate_ranger/main.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({
    super.key,
    required this.PhonesList,
    required this.num,
  });
  final List<dynamic> PhonesList;
  final int num;
  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

//controllers
final _fsnameController = TextEditingController();
final _phoneNumberController = TextEditingController();
final _emailController = TextEditingController();
final _workDoneController = TextEditingController();
final _callbackController = TextEditingController();

class _NewContactScreenState extends State<NewContactScreen> {
  @override
  @override
  void initState() {
    super.initState();
    if (widget.num == -1) {
      _fsnameController.text = '';
      _phoneNumberController.text = '';
      _emailController.text = '';
      _workDoneController.text = '';
      _callbackController.text = '';
    } else {
      _fsnameController.text = widget.PhonesList[widget.num].name;
      _phoneNumberController.text = widget.PhonesList[widget.num].number;
      _emailController.text = widget.PhonesList[widget.num].email;
      _workDoneController.text = widget.PhonesList[widget.num].job;
      _callbackController.text = widget.PhonesList[widget.num].callback;
    }
  }

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
          title: Text('Новый контакт'),
          centerTitle: true,
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Container(
          alignment: Alignment.center,
          width: 0.9.sw,
          height: 700.h,
          child: Padding(
            padding: EdgeInsets.all(5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 5.h),
                // Поле для ввода ФИО
                Text(
                  'ФИО',
                  style: TextStyle(color: Color(0xff4B87FE), fontSize: 16.sp),
                ),
                SizedBox(height: 5.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(8).w,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: TextField(
                    maxLength: 30,
                    onEditingComplete: () {
                      setState(() {});
                    },
                    controller: _fsnameController,
                    decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: '  ФИО',
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // Поле для ввода номера телефона
                Text(
                  'Номер телефона',
                  style: TextStyle(color: Color(0xff4B87FE), fontSize: 16.sp),
                ),
                SizedBox(height: 5.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(8).w,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 14,
                    controller: _phoneNumberController,
                    onEditingComplete: () {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: '  Номер телефона',
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // Поле для ввода электронной почты
                Text(
                  'Электронная почта',
                  style: TextStyle(color: Color(0xff4B87FE), fontSize: 16.sp),
                ),
                SizedBox(height: 5.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(8).w,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: TextField(
                    maxLength: 20,
                    controller: _emailController,
                    decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: '  Электронная почта',
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Поле для ввода выполненных работ
                Text(
                  'Выполненные работы',
                  style: TextStyle(color: Color(0xff4B87FE), fontSize: 16),
                ),
                SizedBox(height: 5.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(8).w,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: TextField(
                    controller: _workDoneController,
                    decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: '  Выполненные работы',
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Поле для ввода отзыва
                Text(
                  'Отзыв',
                  style: TextStyle(color: Color(0xff4B87FE), fontSize: 16.sp),
                ),
                SizedBox(height: 5.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(8).w,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: TextField(
                    controller: _callbackController,
                    decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: '  Отзыв',
                    ),
                  ),
                ),
                Spacer(),

                // Кнопка сохранения
                ElevatedButton(
                  onPressed: () {
                    // Действие при нажатии на кнопку "Сохранить"
                    if (((_fsnameController.text.trim() != '') & (_phoneNumberController.text.trim() != ''))) {
                      if (widget.num == -1) {
                        widget.PhonesList.add(ContactClass(name: _fsnameController.text.trim(), number: _phoneNumberController.text.trim(), email: _emailController.text.trim(), job: _workDoneController.text.trim(), callback: _callbackController.text.trim()));
                        HiveBase().PutPhonesInBase(widget.PhonesList);
                        setState(() {});
                      } else {
                        widget.PhonesList.removeAt(widget.num);
                        widget.PhonesList.add(ContactClass(name: _fsnameController.text.trim(), number: _phoneNumberController.text.trim(), email: _emailController.text.trim(), job: _workDoneController.text.trim(), callback: _callbackController.text.trim()));
                        HiveBase().PutPhonesInBase(widget.PhonesList);
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ((_fsnameController.text.trim() != '') & (_phoneNumberController.text.trim() != '')) ? Color(0xff4B87FE) : Colors.grey.shade300,
                    minimumSize: Size(double.infinity.w, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8).w,
                    ),
                  ),
                  child: Text(
                    'Сохранить',
                    style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
          ),
        ))));
  }
}
