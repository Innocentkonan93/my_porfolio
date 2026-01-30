import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/app/data/models/app_model.dart';
import 'package:my_portfolio/app/data/utils/constants.dart';

class HomeController extends GetxController {
  final currentTab = 0.obs;
  final language = ''.obs;

  @override
  void onInit() {
    language.value = Get.locale?.languageCode ?? 'en';
    super.onInit();
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

  Future<void> sendMeMail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'konankoffiinnocent@gmail.com',
      query: Uri.encodeFull('subject=Hello&body=I want to work with you'),
    );
    if (await canLaunchUrl(params)) {
      print('Email sending...');
      await launchUrl(params);
    } else {
      // Could add error handling or user feedback here if desired
      return;
    }
  }

  void downloadCV() {}
}
