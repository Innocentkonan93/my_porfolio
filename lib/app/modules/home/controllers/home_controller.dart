import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/app/data/models/app_model.dart';
import 'package:my_portfolio/app/data/utils/constants.dart';
import 'package:my_portfolio/app/services/pdf_generator.dart';
import 'package:my_portfolio/app/widgets/contact_dialog.dart';

class HomeController extends GetxController {
  PdfGenerator pdfGenerator = PdfGenerator();
  final currentTab = 0.obs;
  final language = ''.obs;

  @override
  void onInit() {
    language.value = Get.locale?.languageCode ?? 'en';
    super.onInit();
    loadLanguage();
  }

  void loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('language_code');
    if (savedLang != null) {
      language.value = savedLang;
      Get.updateLocale(Locale(savedLang));
    } else {
      language.value = Get.deviceLocale?.languageCode ?? 'en';
    }
  }

  void changeLanguage(String langCode) async {
    Get.updateLocale(Locale(langCode));
    language.value = langCode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
  }

  final carouselImages = [
    'assets/images/caroussels/1.jpeg',
    'assets/images/caroussels/2.jpeg',
    'assets/images/caroussels/3.jpeg',
    'assets/images/caroussels/4.jpeg',
    'assets/images/caroussels/5.jpeg',
    'assets/images/caroussels/6.jpeg',
    'assets/images/caroussels/7.jpeg',
    'assets/images/caroussels/8.jpg',
    'assets/images/caroussels/9.jpeg',
    'assets/images/caroussels/10.jpeg',
    'assets/images/caroussels/11.jpeg',
    'assets/images/caroussels/12.jpeg',
    'assets/images/caroussels/13.jpeg',
    'assets/images/caroussels/14.jpeg',
    'assets/images/caroussels/15.jpeg',
    'assets/images/caroussels/16.jpeg',
    'assets/images/caroussels/17.jpeg',
  ];

  final userProfile = user;
  final apps = appsList
      .where((app) => app.category == 'cat_mobile_app')
      .toList();
  final webApps = appsList
      .where((app) => app.category == 'cat_web_app')
      .toList();
  // Note: currently appsList usually contains mobile apps based on previous view,
  // but let's filter just in case or keep logic flexible.
  // Since the original view passed `controller` to `ExpListView` and `AppsListView`,
  // we'll keep the logic simple here.

  // We can just expose the raw lists and let the UI filter or filter here.
  // The original view used `ExpListView` and `AppsListView` which imported constants directly.
  // We will pass data to them or let them access controller.

  List<AppModel> get mobileApps =>
      appsList.where((e) => e.category == 'cat_mobile_app').toList();
  // Assuming there might be web apps later, currently list seems to be all mobile in constants
  List<AppModel> get webApplications =>
      appsList.where((e) => e.category != 'cat_mobile_app').toList();

  Future<void> openLink(String link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link));
    } else {
      return;
    }
  }

  void contactMe() {
    showGeneralDialog(
      context: Get.context!,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const ContactDialog();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          ),
        );
      },
    );
  }

  Future<void> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        await launchUrl(url); // fallback
      }
    } catch (e) {
      debugPrint("Error launching $urlString: $e");
    }
  }

  void downloadCV() async {
    await pdfGenerator.generateAndPrintCV(userProfile);
  }
}
