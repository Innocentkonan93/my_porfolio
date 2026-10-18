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
                    const SizedBox(height: 20),
                    _bentoHero(mobile),
                    SizedBox(height: mobile ? 64 : 90),
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
                              borderRadius: BorderRadius.circular(24),
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
                          borderRadius: BorderRadius.circular(24),
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

  Widget _bentoHero(bool mobile) => LayoutBuilder(
    builder: (context, constraints) {
      final full = constraints.maxWidth;
      final third = mobile ? full : (full - 36) / 3;
      return Wrap(
        spacing: 18,
        runSpacing: 18,
        children: [
          SizedBox(
            width: mobile ? full : third * 2 + 18,
            child: _BentoTile(
              color: const Color(0xFFE6E0FA),
              child: Padding(
                padding: EdgeInsets.all(mobile ? 26 : 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label(
                      copy('Bonjour, moi c’est Innocent.', 'Hi, I’m Innocent.'),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      copy(
                        'De l’idée au\nproduit. Ensemble.',
                        'From idea to\nproduct. Together.',
                      ),
                      style: TextStyle(
                        fontSize: mobile ? 42 : 64,
                        height: 1.06,
                        letterSpacing: -2.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      copy(
                        'Ingénieur produit mobile. Je donne vie à vos idées avec Flutter, du premier écran à la mise en ligne.',
                        'Mobile product engineer. I bring your ideas to life with Flutter, from the first screen to launch.',
                      ),
                      style: const TextStyle(fontSize: 17, height: 1.6),
                    ),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
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
            ),
          ),
          SizedBox(
            width: third,
            child: _BentoTile(
              color: const Color(0xFFDCE8DB),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        const Icon(Icons.waving_hand_outlined, size: 20),
                        const SizedBox(width: 12),
                        Expanded(child: label('Innocent Konan')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mobile ? 250 : 310,
                    width: double.infinity,
                    child: Image.asset(
                      controller.userProfile.profilePicture,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      copy(
                        'Le code, avec une touche humaine.',
                        'Good code. A human touch.',
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: third,
            child: _BentoTile(
              color: const Color(0xFF25252B),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.code_rounded,
                      color: Color(0xFFC7B9FF),
                      size: 30,
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Flutter & beyond.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Dart / Firebase / Mobile / Web',
                      style: TextStyle(
                        color: Color(0xFFCECBD8),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      copy(
                        'Des interfaces soignées. Des produits concrets.',
                        'Thoughtful interfaces. Real products.',
                      ),
                      style: const TextStyle(
                        color: Color(0xFFCECBD8),
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: third,
            child: _BentoTile(
              color: const Color(0xFFFFE6CC),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.layers_outlined, size: 30),
                    const SizedBox(height: 16),
                    Text(
                      '${controller.mobileApps.length + controller.webApplications.length}',
                      style: const TextStyle(
                        fontSize: 64,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      copy('projets à découvrir', 'projects to explore'),
                      style: const TextStyle(fontSize: 21),
                    ),
                    const SizedBox(height: 8),
                    action(
                      copy('Voir la collection', 'View collection'),
                      () => scrollTo(projectsKey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: third,
            child: _BentoTile(
              color: const Color(0xFFDEEAF5),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.auto_awesome_outlined, size: 30),
                    const SizedBox(height: 26),
                    Text(
                      copy('On crée la suite ?', 'What’s next?'),
                      style: const TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      copy(
                        'Une idée, un besoin, une envie de collaborer.',
                        'An idea, a challenge, a chance to collaborate.',
                      ),
                      style: const TextStyle(height: 1.6),
                    ),
                    const SizedBox(height: 12),
                    action(
                      copy('Prenons contact', 'Get in touch'),
                      controller.contactMe,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );

  Widget _project(AppModel app, int index, bool mobile) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(24),
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

class _BentoTile extends StatefulWidget {
  const _BentoTile({required this.color, required this.child});
  final Color color;
  final Widget child;
  @override
  State<_BentoTile> createState() => _BentoTileState();
}

class _BentoTileState extends State<_BentoTile> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hovered = true),
    onExit: (_) => setState(() => hovered = false),
    child: AnimatedContainer(
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 200),
      transform: Matrix4.translationValues(0, hovered ? -4 : 0, 0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
      ),
      child: widget.child,
    ),
  );
}
