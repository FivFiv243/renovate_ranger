import 'package:flutter/material.dart';
import 'package:renovate_ranger/features/designed_widgets/settings_item.dart';
import 'package:url_launcher/url_launcher.dart' as uLaunch;
import 'package:in_app_review/in_app_review.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final InAppReview inAppReview = InAppReview.instance;

class _SettingsScreenState extends State<SettingsScreen> {
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
        title: Text('Настройки'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(QueryHeight / 45),
        child: Column(
          children: [
            SettingsItem(
              title: 'Политика конфиденциальности',
              svgname: 'lib/assets/icons/Security/Lock Unlocked.svg',
              onTap: () async {
                try {
                  await uLaunch.launchUrl(
                    Uri(scheme: "https", host: "ru-ru.facebook.com", path: "/payments_terms/privacy"),
                    mode: uLaunch.LaunchMode.externalApplication,
                  );
                } catch (e) {}
              },
            ),
            SizedBox(height: QueryHeight / 90),
            SettingsItem(
              title: 'Пользовательское соглашение',
              svgname: 'lib/assets/icons/School/Notebook Bookmark.svg',
              onTap: () async {
                try {
                  await uLaunch.launchUrl(
                    Uri(scheme: "https", host: "policies.google.com", path: "/terms?hl=ru"),
                    mode: uLaunch.LaunchMode.externalApplication,
                  );
                } catch (e) {}
              },
            ),
            SizedBox(height: QueryHeight / 90),
            Divider(
              height: 5,
              color: const Color.fromARGB(66, 158, 158, 158),
            ),
            SizedBox(height: QueryHeight / 90),
            SettingsItem(
              title: 'Оценить приложение',
              svgname: 'lib/assets/icons/Hands/Hand Stars.svg',
              onTap: () async {
                try {
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                } catch (e) {}
                //App reviewing module here
              },
            ),
          ],
        ),
      ),
    );
  }
}
