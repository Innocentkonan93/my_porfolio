import 'widgets/portfolio_gallery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../configs/app_colors.dart';
import '../../../data/models/app_model.dart';
import '../../../widgets/app_details_dialog.dart';
import '../controllers/home_controller.dart';

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
      backgroundColor: const Color(0xFF0C1117),
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
                          const Text.rich(
                            TextSpan(
                              text: 'ik',
                              children: [
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ],
                            ),
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (final lang in ['fr', 'en'])
                                TextButton(
                                  onPressed: () =>
                                      controller.changeLanguage(lang),
                                  child: Text(
                                    lang.toUpperCase(),
                                    style: TextStyle(
                                      color: controller.language.value == lang
                                          ? const Color(0xFF6DE2CF)
                                          : const Color(0xFF9AA9B9),
                                    ),
                                  ),
                                ),
                            ],
                          ),
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
                    SizedBox(height: mobile ? 42 : 72),
                    _labHero(mobile),
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
                              borderRadius: BorderRadius.circular(12),
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
                                  color: Color(0xFF9AA9B9),
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
                                  color: Color(0xFF9AA9B9),
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
                      copy('Dans les coulisses', 'Behind the scenes'),
                      mobile,
                    ),
                    const SizedBox(height: 24),
                    PortfolioGallery(
                      images: controller.carouselImages,
                      french: controller.language.value == 'fr',
                    ),
                    SizedBox(height: mobile ? 64 : 100),
                    _heading(
                      '04',
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
                          border: Border.all(color: const Color(0xFF293541)),
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
        style: const TextStyle(color: Color(0xFF6DE2CF), fontSize: 12),
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

  Widget _labHero(bool mobile) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 12,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Icon(
            Icons.terminal_rounded,
            color: Color(0xFF6DE2CF),
            size: 20,
          ),
          label('INNOCENT KONAN / PRODUCT LAB'),
        ],
      ),
      const SizedBox(height: 30),
      Flex(
        direction: mobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandedIf(
            enabled: !mobile,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  copy(
                    'Pensé pour les gens.\nConçu pour durer.',
                    'Built for people.\nEngineered to last.',
                  ),
                  style: TextStyle(
                    fontSize: mobile ? 44 : 72,
                    height: 1.08,
                    letterSpacing: -2.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  copy(
                    'Je transforme des idées en applications mobiles et web. De belles interfaces, une architecture solide et le souci du détail.',
                    'I turn ideas into mobile and web applications. Thoughtful interfaces, solid architecture and attention to detail.',
                  ),
                  style: const TextStyle(
                    color: Color(0xFF9AA9B9),
                    fontSize: 17,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    action(
                      copy('Explorer mes projets', 'Explore my work'),
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
          SizedBox(width: mobile ? 0 : 48, height: mobile ? 32 : 0),
          SizedBox(
            width: mobile ? double.infinity : 320,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF131C25),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF293541)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: Color(0xFF6DE2CF)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'developer.profile',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Color(0xFF9AA9B9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  CircleAvatar(
                    radius: 34,
                    backgroundImage: AssetImage(
                      controller.userProfile.profilePicture,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Innocent Konan',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    copy('Ingénieur produit mobile', 'Mobile product engineer'),
                    style: const TextStyle(color: Color(0xFF9AA9B9)),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'stack: [Flutter, Dart, Firebase]\nplatforms: [iOS, Android, Web]',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Color(0xFF6DE2CF),
                      height: 2,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 48),
      Container(
        height: mobile ? 300 : 400,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF293541)),
          gradient: const RadialGradient(
            center: Alignment(0, 0.8),
            radius: 1.2,
            colors: [Color(0xFF204C4A), Color(0xFF121A24)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 24,
              left: 24,
              child: label(
                copy('EXPÉRIENCES EN PRODUCTION', 'SHIPPED EXPERIENCES'),
              ),
            ),
            Positioned.fill(
              top: 65,
              bottom: -50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final item in [
                    ('assets/images/cutit.png', -0.08),
                    ('assets/images/riise.png', 0.0),
                    ('assets/images/cvf.png', 0.08),
                  ])
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mobile ? 10 : 38,
                        ),
                        child: Transform.rotate(
                          angle: item.$2,
                          child: Image.asset(
                            item.$1,
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
      ),
    ],
  );

  Widget _project(AppModel app, int index, bool mobile) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12),
        color: [
          const Color(0xFF1B2638),
          const Color(0xFF15332F),
          const Color(0xFF2A2538),
          const Color(0xFF182C3B),
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
          color: Color(0xFF9AA9B9),
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
