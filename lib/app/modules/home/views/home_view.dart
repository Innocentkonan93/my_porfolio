import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../configs/app_colors.dart';
import '../../../data/models/app_model.dart';
import '../../../widgets/app_details_dialog.dart';
import '../controllers/home_controller.dart';
import 'widgets/language_switcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.find<HomeController>();
  final projectsKey = GlobalKey();
  final aboutKey = GlobalKey();
  int category = 0;
  bool showAll = false;

  String copy(String fr, String en) =>
      controller.language.value == 'fr' ? fr : en;

  void scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Text label(String text) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      fontSize: 11,
      letterSpacing: 2,
      fontWeight: FontWeight.w600,
    ),
  );

  Widget action(String text, VoidCallback onTap, {bool filled = false}) {
    return filled
        ? FilledButton.icon(
            onPressed: onTap,
            label: Text(text),
            icon: const Icon(Icons.north_east, size: 17),
          )
        : TextButton.icon(
            onPressed: onTap,
            label: Text(text),
            icon: const Icon(Icons.north_east, size: 17),
          );
  }

  @override
  Widget build(BuildContext context) => Obx(() {
    final mobile = MediaQuery.sizeOf(context).width < 1000;
    final apps = category == 0
        ? controller.mobileApps
        : controller.webApplications;
    final visibleApps = showAll ? apps : apps.take(4).toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1240),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mobile ? 22 : 64),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: [
                          const Text(
                            'ik.',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -3,
                            ),
                          ),
                          const Spacer(),
                          if (!mobile) ...[
                            TextButton(
                              onPressed: () => scrollTo(projectsKey),
                              child: Text(copy('Projets', 'Work')),
                            ),
                            TextButton(
                              onPressed: () => scrollTo(aboutKey),
                              child: Text(copy('À propos', 'About')),
                            ),
                            const SizedBox(width: 24),
                          ],
                          const LanguageSwitcher(),
                          if (!mobile)
                            action(
                              'Contact',
                              controller.contactMe,
                              filled: true,
                            ),
                        ],
                      ),
                    ),
                    const Divider(),
                    SizedBox(height: mobile ? 48 : 76),
                    Wrap(
                      spacing: 14,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        label(
                          copy(
                            'Innocent Konan · Ingénieur produit mobile',
                            'Innocent Konan · Mobile product engineer',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text(
                      copy(
                        'Des idées claires.\nDes produits qui\nfont la différence.',
                        'Clear ideas.\nProducts that\nmake a difference.',
                      ),
                      style: TextStyle(
                        fontSize: mobile ? 48 : 88,
                        height: 1.04,
                        letterSpacing: mobile ? -2.5 : -5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Flex(
                      direction: mobile ? Axis.vertical : Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!mobile)
                          const Expanded(
                            child: Text(
                              'DESIGN → CODE → PRODUIT',
                              style: TextStyle(
                                fontSize: 11,
                                letterSpacing: 1.8,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        SizedBox(
                          width: mobile ? double.infinity : 420,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                copy(
                                  'Je conçois et développe des applications mobiles et web. Du premier écran au produit livré, chaque détail compte.',
                                  'I design and build mobile and web applications. From the first screen to the shipped product, every detail matters.',
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  height: 1.6,
                                  color: Color(0xFF65615B),
                                ),
                              ),
                              const SizedBox(height: 22),
                              Wrap(
                                spacing: 12,
                                runSpacing: 10,
                                children: [
                                  action(
                                    copy(
                                      'Explorer mes projets',
                                      'Explore my work',
                                    ),
                                    () => scrollTo(projectsKey),
                                    filled: true,
                                  ),
                                  action(
                                    copy('Discutons', 'Let’s talk'),
                                    controller.contactMe,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 58),
                    _heroStrip(mobile),
                    SizedBox(height: mobile ? 64 : 100),
                    Container(
                      key: projectsKey,
                      child: _heading(
                        '01',
                        copy('Une sélection de projets.', 'Selected work.'),
                        mobile,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (var i = 0; i < 2; i++)
                          ChoiceChip(
                            label: Text(
                              i == 0
                                  ? copy(
                                      'Applications mobiles',
                                      'Mobile applications',
                                    )
                                  : copy(
                                      'Sites & applications web',
                                      'Websites & web apps',
                                    ),
                            ),
                            selected: category == i,
                            onSelected: (_) => setState(() {
                              category = i;
                              showAll = false;
                            }),
                          ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = mobile
                            ? constraints.maxWidth
                            : (constraints.maxWidth - 28) / 2;
                        return Wrap(
                          spacing: 28,
                          runSpacing: 40,
                          children: [
                            for (var i = 0; i < visibleApps.length; i++)
                              SizedBox(
                                width: width,
                                child: _project(visibleApps[i], i, mobile),
                              ),
                          ],
                        );
                      },
                    ),
                    if (apps.length > 4)
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: action(
                          showAll
                              ? copy('Réduire la sélection', 'Show less')
                              : copy(
                                  'Voir tous les projets (${apps.length})',
                                  'View all projects (${apps.length})',
                                ),
                          () => setState(() => showAll = !showAll),
                        ),
                      ),
                    SizedBox(height: mobile ? 64 : 100),
                    Container(
                      key: aboutKey,
                      child: _heading(
                        '02',
                        copy(
                          'Le soin du détail.\nLa vision du produit.',
                          'An eye for detail.\nA product mindset.',
                        ),
                        mobile,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Flex(
                      direction: mobile ? Axis.vertical : Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: mobile ? double.infinity : 300,
                          child: AspectRatio(
                            aspectRatio: 0.95,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Image.asset(
                                controller.userProfile.profilePicture,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: mobile ? 0 : 56,
                          height: mobile ? 28 : 0,
                        ),
                        ExpandedIf(
                          enabled: !mobile,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                copy('Moi, c’est Innocent.', 'I’m Innocent.'),
                                style: const TextStyle(
                                  fontSize: 32,
                                  letterSpacing: -1,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                copy(
                                  'J’aime transformer des besoins concrets en expériences simples à utiliser. Mon travail relie la conception des interfaces, le développement et la livraison d’applications mobiles et web.',
                                  'I turn real needs into experiences that feel simple to use. My work connects interface design, development and the delivery of mobile and web applications.',
                                ),
                                style: const TextStyle(
                                  fontSize: 17,
                                  height: 1.7,
                                  color: Color(0xFF65615B),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final skill in [
                                    'Flutter',
                                    'Dart',
                                    'Firebase',
                                    'Mobile & Web',
                                  ])
                                    Chip(label: Text(skill)),
                                ],
                              ),
                              const SizedBox(height: 16),
                              action(
                                copy('Mon CV', 'My résumé'),
                                controller.downloadCV,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    for (final exp in controller.userProfile.experiences) ...[
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Wrap(
                          spacing: 30,
                          runSpacing: 8,
                          children: [
                            SizedBox(
                              width: 130,
                              child: Text(
                                '${exp.beginDate.year} — ${exp.endDate.year}',
                                style: const TextStyle(
                                  color: Color(0xFF65615B),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: mobile ? 230 : 320,
                              child: Text(
                                exp.organizationName,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              exp.role.tr,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const Divider(),
                    SizedBox(height: mobile ? 64 : 100),
                    _heading(
                      '03',
                      copy('Construire. Partager.', 'Build. Share.'),
                      mobile,
                    ),
                    const SizedBox(height: 28),
                    for (final package in controller.openSourcePackages)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.all(mobile ? 24 : 36),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label('OPEN SOURCE / FLUTTER'),
                            const SizedBox(height: 20),
                            Text(
                              package.title,
                              style: TextStyle(
                                fontSize: mobile ? 26 : 36,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              package.description.tr,
                              style: const TextStyle(fontSize: 16, height: 1.6),
                            ),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 16,
                              children: [
                                action(
                                  'Pub.dev',
                                  () => controller.openLink(package.pubLink),
                                ),
                                action(
                                  'GitHub',
                                  () => controller.openLink(package.githubLink),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: mobile ? 64 : 100),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(mobile ? 28 : 52),
                      color: AppColors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            copy(
                              'ET SI ON CONSTRUISAIT LA SUITE ?',
                              'LET’S BUILD WHAT’S NEXT.',
                            ),
                            style: const TextStyle(
                              color: Color(0xFFBEB8AE),
                              fontSize: 11,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            copy(
                              'Votre prochaine\nidée commence ici.',
                              'Your next idea\nstarts here.',
                            ),
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: mobile ? 40 : 64,
                              height: 1.1,
                              letterSpacing: -2,
                            ),
                          ),
                          const SizedBox(height: 28),
                          FilledButton.icon(
                            onPressed: controller.contactMe,
                            icon: const Icon(Icons.north_east, size: 18),
                            label: Text(
                              copy(
                                'Parlons de votre projet',
                                'Let’s talk about your project',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 32,
                        runSpacing: 16,
                        children: [
                          Text(
                            '© ${DateTime.now().year} Innocent Konan',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Wrap(
                            spacing: 12,
                            children: [
                              for (final social
                                  in controller.userProfile.socialLinks)
                                TextButton(
                                  onPressed: () =>
                                      controller.openLink(social.url),
                                  child: Text('${social.name} ↗'),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  });

  Widget _heading(String number, String title, bool mobile) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(),
      const SizedBox(height: 22),
      Text(
        '/ $number',
        style: const TextStyle(color: AppColors.primary, fontSize: 12),
      ),
      const SizedBox(height: 16),
      Text(
        title,
        style: TextStyle(
          fontSize: mobile ? 36 : 52,
          height: 1.1,
          letterSpacing: -2,
        ),
      ),
    ],
  );

  Widget _heroStrip(bool mobile) => Container(
    height: mobile ? 280 : 390,
    clipBehavior: Clip.hardEdge,
    decoration: const BoxDecoration(color: Color(0xFFE7E0D5)),
    child: Stack(
      children: [
        Positioned(
          top: 22,
          left: 24,
          child: label(
            copy('Du concept à l’écran.', 'From concept to screen.'),
          ),
        ),
        Positioned(
          bottom: 22,
          right: 24,
          child: label('FLUTTER / IOS / ANDROID'),
        ),
        Positioned.fill(
          top: 62,
          bottom: -65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final entry in [
                ('assets/images/cutit.png', -0.09),
                ('assets/images/riise.png', 0.06),
                ('assets/images/cvf.png', 0.12),
              ])
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mobile ? 7 : 28),
                    child: Transform.rotate(
                      angle: entry.$2,
                      child: Image.asset(
                        entry.$1,
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _project(AppModel app, int index, bool mobile) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Material(
        color: [
          const Color(0xFFE5DFEE),
          const Color(0xFFE1E5DB),
          const Color(0xFFE9DED4),
          const Color(0xFFDDE4E7),
        ][index % 4],
        child: InkWell(
          onTap: () => showDialog<void>(
            context: context,
            builder: (_) => AppDetailsDialog(app: app),
          ),
          child: SizedBox(
            height: mobile ? 300 : 370,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 18,
                  left: 20,
                  child: label(
                    '${(index + 1).toString().padLeft(2, '0')} / ${app.isMobileApp ? 'MOBILE' : 'WEB'}',
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Icon(
                    Icons.north_east,
                    size: 22,
                    semanticLabel: copy('Voir le projet', 'View project'),
                  ),
                ),
                Positioned.fill(
                  top: 60,
                  bottom: 0,
                  left: 30,
                  right: 30,
                  child: Image.asset(
                    app.image,
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 18),
      Text(
        app.title,
        style: const TextStyle(
          fontSize: 26,
          letterSpacing: -0.6,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        app.description.tr,
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
          color: Color(0xFF65615B),
        ),
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 10,
        children: [
          for (final link in app.links)
            action(
              link.contains('apple.com')
                  ? 'App Store'
                  : link.contains('play.google')
                  ? 'Google Play'
                  : copy('Voir le site', 'Visit website'),
              () => controller.openLink(link),
            ),
        ],
      ),
    ],
  );
}

class ExpandedIf extends StatelessWidget {
  const ExpandedIf({super.key, required this.enabled, required this.child});
  final bool enabled;
  final Widget child;
  @override
  Widget build(BuildContext context) =>
      enabled ? Expanded(child: child) : child;
}
