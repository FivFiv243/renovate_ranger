import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:renovate_ranger/features/constans.dart/constants.dart';
import 'package:renovate_ranger/features/database/hive_base.dart';
import 'package:renovate_ranger/main.dart';
import 'package:renovate_ranger/screens/Tools_and_materials_screen.dart';
import 'package:url_launcher/url_launcher.dart' as uLaunch;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

late PageController _pageController;
late PageController _descriptionController;
int _currentPage = 0;
final List<String> _images = [
  'assets/images/onboarding1.png',
  'assets/images/onboarding2.png',
  'assets/images/onboarding3.png',
];

final List<String> descriptonList = ["Дизайн проекты и контакты исполнителей с которыми вы сотрудничали", "Ваши материала и инструменты, а также информация об их наличии и потребности", "Советы профессионалов о технологиях и правилах при выполнении ремонтных работ"];

void _nextImage(BuildContext context) {
  if (_currentPage < _images.length - 1) {
    _currentPage++;
  } else {
    _currentPage = 0;
    HiveBase().SetBoardingFlag();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ToolsAndMaterialsScreen()));
  }
  _pageController.animateToPage(
    _currentPage,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
  _descriptionController.animateToPage(
    _currentPage,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _descriptionController = PageController();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 125.h, 0, 0)),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Image.asset(
                  width: 0.5.sh,
                  height: 0.5.sw,
                  _images[index],
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 0.1.sh,
            width: 0.95.sw,
            child: Expanded(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _descriptionController,
                itemCount: descriptonList.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: Text(
                    descriptonList[index],
                    style: TextStyle(fontSize: 14.sp),
                  ));
                },
              ),
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 75.h, 0, 0)),
          Container(
            width: 0.95.sw,
            child: ElevatedButton(
              onPressed: () {
                _nextImage(context);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4B87FE), // Цвет кнопки
                minimumSize: Size(double.infinity.w, 50.h), // Ширина на весь экран
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r), // <-- Radius
                ),
              ),
              child: Text(
                'Далее',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
              height: 25.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.scale(
                      scale: 1.sh / 1000,
                      child: Radio(
                          splashRadius: 0,
                          value: 0,
                          activeColor: Color(0xff4B87FE),
                          groupValue: _currentPage,
                          onChanged: (value) {
                            null;
                          })),
                  Transform.scale(
                      scale: 1.sh / 1000,
                      child: Radio(
                          splashRadius: 0,
                          value: 1,
                          activeColor: Color(0xff4B87FE),
                          groupValue: _currentPage,
                          onChanged: (value) {
                            null;
                          })),
                  Transform.scale(
                      scale: 1.sh / 1000,
                      child: Radio(
                          splashRadius: 0,
                          value: 2,
                          activeColor: Color(0xff4B87FE),
                          groupValue: _currentPage,
                          onChanged: (value) {
                            null;
                          }))
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  try {
                    await uLaunch.launchUrl(
                      Uri(scheme: "https", host: policyHost, path: policyPath),
                      mode: uLaunch.LaunchMode.externalApplication,
                    );
                  } catch (e) {}
                },
                child: Text(
                  "Условия использования",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ),
              Text(
                ' | ',
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    await uLaunch.launchUrl(
                      Uri(scheme: "https", host: termHost, path: policyPath),
                      mode: uLaunch.LaunchMode.externalApplication,
                    );
                  } catch (e) {}
                },
                child: Text(
                  "Политика конфиденциальности",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 50.h, 0, 0))
        ],
      ),
    );
  }
}
