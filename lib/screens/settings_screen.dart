import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:renovate_ranger/features/constans.dart/constants.dart';
import 'package:renovate_ranger/features/designed_widgets/settings_item.dart';
import 'package:renovate_ranger/main.dart';
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
        title: Text('Настройки'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10).w,
        child: Column(
          children: [
            SettingsItem(
              title: 'Политика конфиденциальности',
              svgname: 'assets/icons/Security/Lock Unlocked.svg',
              onTap: () async {
                try {
                  await uLaunch.launchUrl(
                    Uri(scheme: "https", host: termHost, path: termPath),
                    mode: uLaunch.LaunchMode.externalApplication,
                  );
                } catch (e) {}
              },
            ),
            SizedBox(height: 5.h),
            SettingsItem(
              title: 'Пользовательское соглашение',
              svgname: 'assets/icons/School/Notebook Bookmark.svg',
              onTap: () async {
                try {
                  await uLaunch.launchUrl(
                    Uri(scheme: "https", host: policyHost, path: policyPath),
                    mode: uLaunch.LaunchMode.externalApplication,
                  );
                } catch (e) {}
              },
            ),
            SizedBox(height: 5.h),
            Divider(
              height: 5.h,
              color: const Color.fromARGB(66, 158, 158, 158),
            ),
            SizedBox(height: 5.h),
            SettingsItem(
              title: 'Оценить приложение',
              svgname: 'assets/icons/Hands/Hand Stars.svg',
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
