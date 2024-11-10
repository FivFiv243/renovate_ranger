import 'package:flutter/material.dart';
import 'package:renovate_ranger/screens/navigation_screen.dart';
import 'package:url_launcher/url_launcher.dart' as uLaunch;
import 'package:url_launcher/url_launcher.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

late PageController _pageController;
late PageController _descriptionController;
int _currentPage = 0;
final List<String> _images = [
  'lib/assets/images/onboarding1.png',
  'lib/assets/images/onboarding2.png',
  'lib/assets/images/onboarding3.png',
];

final List<String> descriptonList = ["Дизайн проекты и контакты исполнителей с которыми вы сотрудничали", "Ваши материала и инструменты, а также информация об их наличии и потребности", "Советы профессионалов о технологиях и правилах при выполнении ремонтных работ"];

void _nextImage(BuildContext context) {
  if (_currentPage < _images.length - 1) {
    _currentPage++;
  } else {
    _currentPage = 0;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavigationScreen()));
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
    final QueryHeight = MediaQuery.of(context).size.height;
    final QueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 5, 0, 0)),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  width: QueryWidth / 3,
                  height: QueryHeight / 2,
                  _images[index],
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: QueryHeight / 5,
            width: QueryWidth / 1.05,
            child: Expanded(
              child: PageView.builder(
                controller: _descriptionController,
                itemCount: descriptonList.length,
                itemBuilder: (context, index) {
                  return Center(child: Text(descriptonList[index]));
                },
              ),
            ),
          ),
          Spacer(),
          Container(
            width: QueryWidth / 1.1,
            child: ElevatedButton(
              onPressed: () {
                _nextImage(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 122, 228), // Цвет кнопки
                minimumSize: Size(double.infinity, 50), // Ширина на весь экран
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
              child: Text(
                'Далее',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uLaunch.launchUrl(
                    Uri(scheme: "https", host: "policies.google.com", path: "/terms?hl=ru"),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  "Условия использования",
                  style: TextStyle(fontSize: QueryWidth / 30, color: Colors.grey),
                ),
              ),
              Text(
                ' | ',
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () async {
                  await uLaunch.launchUrl(
                    Uri(scheme: "https", host: "ru-ru.facebook.com", path: "/payments_terms/privacy"),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  "Политика конфиденциальности",
                  style: TextStyle(fontSize: QueryWidth / 30, color: Colors.grey),
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, QueryHeight / 15, 0, 0))
        ],
      ),
    );
  }
}
