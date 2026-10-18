import 'package:flutter/services.dart';
import 'package:my_portfolio/app/data/models/user_model.dart';
import 'package:my_portfolio/app/data/utils/constants.dart';
import 'package:my_portfolio/app/services/localizations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

enum CvTheme { editorial, bento, productLab }

class PdfGenerator {
  Future<void> generateAndPrintCV(
    UserModel user, {
    String languageCode = 'fr',
    CvTheme theme = CvTheme.productLab,
  }) async {
    await Printing.sharePdf(
      bytes: await generateCV(user, languageCode: languageCode, theme: theme),
      filename:
          'CV_Innocent_Konan_${theme.name}_${languageCode == 'fr' ? 'FR' : 'EN'}.pdf',
    );
  }

  /// Generates the same document for download, preview and verification.
  Future<Uint8List> generateCV(
    UserModel user, {
    String languageCode = 'fr',
    CvTheme theme = CvTheme.productLab,
  }) async {
    final fr = languageCode == 'fr';
    String copy(String french, String english) => fr ? french : english;
    final strings = Localization().keys[fr ? 'fr' : 'en']!;
    String translated(String key) => strings[key] ?? key;
    final regularFont = await rootBundle.load(
      'assets/fonts/FiraSans-Regular.ttf',
    );
    final boldFont = await rootBundle.load('assets/fonts/FiraSans-Bold.ttf');
    final italicFont = await rootBundle.load(
      'assets/fonts/FiraSans-Italic.ttf',
    );
    final portrait = pw.MemoryImage(
      (await rootBundle.load(user.profilePicture)).buffer.asUint8List(),
    );
    final dark = theme == CvTheme.productLab;
    final bento = theme == CvTheme.bento;
    final ink = PdfColor.fromHex(dark ? '#F0F5FA' : '#24231F');
    final teal = PdfColor.fromHex(
      dark
          ? '#6DE2CF'
          : bento
          ? '#6650A4'
          : '#B84825',
    );
    final cyan = teal;
    final muted = PdfColor.fromHex(dark ? '#ACBBC8' : '#536471');
    final line = PdfColor.fromHex(
      dark
          ? '#35434F'
          : bento
          ? '#DDD6ED'
          : '#D9D4CA',
    );
    final paper = PdfColor.fromHex(
      dark
          ? '#131C25'
          : bento
          ? '#E6E0FA'
          : '#EEE7DC',
    );
    final background = PdfColor.fromHex(
      dark
          ? '#0C1117'
          : bento
          ? '#F7F8FA'
          : '#F6F3EC',
    );
    final pdf = pw.Document(
      title: '${user.name} - ${copy('CV', 'Resume')}',
      author: user.name,
      subject: copy(
        'Ingénieur produit mobile | Flutter',
        'Mobile Product Engineer | Flutter',
      ),
      creator: 'Innocent Konan Portfolio',
    );
    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (_) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Container(color: background),
      ),
      margin: const pw.EdgeInsets.all(38),
      theme: pw.ThemeData.withFont(
        base: pw.Font.ttf(regularFont),
        bold: pw.Font.ttf(boldFont),
        italic: pw.Font.ttf(italicFont),
      ),
    );
    pw.Text text(
      String value, {
      double size = 10,
      PdfColor? color,
      bool bold = false,
    }) => pw.Text(
      value,
      style: pw.TextStyle(
        fontSize: size,
        color: color ?? ink,
        fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        lineSpacing: 2,
      ),
    );
    pw.Widget link(String label, String url, {PdfColor? color}) => pw.UrlLink(
      destination: url,
      child: text(label, size: 9, color: color ?? teal),
    );
    pw.Widget section(String number, String title) => pw.Padding(
      padding: const pw.EdgeInsets.only(top: 19, bottom: 11),
      child: pw.Row(
        children: [
          text(number, size: 9, color: teal, bold: true),
          pw.SizedBox(width: 10),
          text(title.toUpperCase(), size: 11, bold: true),
          pw.SizedBox(width: 14),
          pw.Expanded(child: pw.Divider(color: line)),
        ],
      ),
    );
    pw.Widget footer(pw.Context context) => pw.Column(
      children: [
        pw.Divider(color: line),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            link('ikonan.com', 'https://ikonan.com'),
            text(
              '${user.name}  /  ${context.pageNumber} - ${context.pagesCount}',
              size: 8,
              color: muted,
            ),
          ],
        ),
      ],
    );
    final experiences = [...user.experiences]
      ..sort((a, b) => b.endDate.compareTo(a.endDate));
    final now = DateTime.now();
    pdf.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        footer: footer,
        build: (_) => [
          pw.Container(
            padding: const pw.EdgeInsets.all(22),
            decoration: pw.BoxDecoration(
              color: paper,
              borderRadius: pw.BorderRadius.circular(
                bento
                    ? 20
                    : dark
                    ? 8
                    : 2,
              ),
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      text(
                        'MOBILE / WEB / FLUTTER',
                        size: 8,
                        color: cyan,
                        bold: true,
                      ),
                      pw.SizedBox(height: 12),
                      text(user.name, size: 28, color: ink, bold: true),
                      pw.SizedBox(height: 5),
                      text(
                        copy(
                          'Ingénieur produit mobile',
                          'Mobile Product Engineer',
                        ),
                        size: 13,
                        color: cyan,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(width: 18),
                pw.ClipRRect(
                  horizontalRadius: 6,
                  verticalRadius: 6,
                  child: pw.Image(
                    portrait,
                    width: 76,
                    height: 90,
                    fit: pw.BoxFit.cover,
                    alignment: pw.Alignment.topCenter,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 13),
          pw.Wrap(
            spacing: 18,
            runSpacing: 6,
            children: [
              link(user.email, 'mailto:${user.email}'),
              link(user.phone, 'tel:${user.phone.replaceAll(' ', '')}'),
              link('ikonan.com', 'https://ikonan.com'),
              for (final social in user.socialLinks.where(
                (s) => ['LinkedIn', 'GitHub'].contains(s.name),
              ))
                link(social.name, social.url),
            ],
          ),
          section('01', copy('Profil', 'Profile')),
          text(
            copy(
              'Je conçois et développe des applications mobiles et web avec Flutter. Mon travail couvre les interfaces, l’intégration d’API et les fonctionnalités métier, avec une attention particulière à la simplicité d’utilisation et à la qualité du produit.',
              'I design and develop mobile and web applications with Flutter. My work spans interfaces, API integration and business features, with a focus on usability and product quality.',
            ),
            size: 10.5,
          ),
          pw.SizedBox(height: 12),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(12),
            color: paper,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                text(
                  copy('COMPÉTENCES CLÉS', 'CORE SKILLS'),
                  size: 8,
                  color: teal,
                  bold: true,
                ),
                pw.SizedBox(height: 5),
                text(
                  'Flutter / Dart / Firebase / REST / GraphQL / GetX',
                  size: 10,
                ),
                pw.SizedBox(height: 3),
                text(
                  copy(
                    'Applications iOS, Android et web - interfaces adaptatives - intégration de services',
                    'iOS, Android and web applications - responsive interfaces - service integration',
                  ),
                  size: 9,
                  color: muted,
                ),
              ],
            ),
          ),
          section(
            '02',
            copy('Expériences professionnelles', 'Professional experience'),
          ),
          for (final exp in experiences)
            pw.Container(
              padding: const pw.EdgeInsets.only(top: 8, bottom: 9),
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(color: line, width: 0.5),
                ),
              ),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(
                    width: 130,
                    child: text(
                      '${_formatDate(exp.beginDate, fr)} - ${_sameDay(exp.endDate, now) ? copy('Présent', 'Present') : _formatDate(exp.endDate, fr)}',
                      size: 8.5,
                      color: muted,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        text(exp.organizationName, size: 10.5, bold: true),
                        pw.SizedBox(height: 3),
                        text(translated(exp.role), size: 9.5, color: muted),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
    final selected = [
      'Cutit',
      'Riise',
      'CVF',
      'Allô Docteur +',
      'CNDH-CI | Alerte Précoce',
    ];
    // Select from existing portfolio records, keeping their supplied contributions.
    final projects = [
      for (final title in selected)
        ...appsList.where(
          (app) => app.title.toLowerCase() == title.toLowerCase(),
        ),
    ];
    pdf.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        footer: footer,
        build: (_) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              text(user.name, size: 14, bold: true),
              text(
                copy('PROJETS & CONTRIBUTIONS', 'PROJECTS & CONTRIBUTIONS'),
                size: 8,
                color: teal,
                bold: true,
              ),
            ],
          ),
          section(
            '03',
            copy('Réalisations sélectionnées', 'Selected projects'),
          ),
          text(
            copy(
              'Une sélection de produits issus de mon portfolio. Les liens donnent accès aux applications et à leurs présentations.',
              'A selection of products from my portfolio. Follow the links to explore the applications and their listings.',
            ),
            size: 10,
            color: muted,
          ),
          pw.SizedBox(height: 16),
          for (final app in projects)
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 13),
              padding: const pw.EdgeInsets.only(bottom: 13),
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(color: line, width: 0.5),
                ),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      text(app.title, size: 13, bold: true),
                      text(translated(app.role), size: 8.5, color: teal),
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  text(translated(app.tasks), size: 10),
                  pw.SizedBox(height: 6),
                  text(app.stack.join(' / '), size: 8, color: muted),
                  if (app.links.isNotEmpty)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 6),
                      child: pw.Wrap(
                        spacing: 15,
                        children: [
                          for (final url in app.links)
                            link(
                              url.contains('apple.com')
                                  ? 'App Store'
                                  : url.contains('play.google')
                                  ? 'Google Play'
                                  : copy('Voir le site', 'Website'),
                              url,
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          section('04', 'Open source'),
          for (final package in packagesList)
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                text(package.title, size: 12, bold: true),
                pw.SizedBox(height: 5),
                text(translated(package.description), size: 10),
                pw.SizedBox(height: 6),
                pw.Wrap(
                  spacing: 16,
                  children: [
                    link('Pub.dev', package.pubLink),
                    link('GitHub', package.githubLink),
                  ],
                ),
              ],
            ),
          pw.SizedBox(height: 18),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(14),
            color: paper,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                text(
                  copy(
                    'Tous mes projets et leurs détails',
                    'Explore all projects and details',
                  ),
                  size: 10,
                  bold: true,
                ),
                link('ikonan.com', 'https://ikonan.com'),
              ],
            ),
          ),
        ],
      ),
    );
    return pdf.save();
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatDate(DateTime date, bool fr) {
    final months = fr
        ? [
            'janv.',
            'févr.',
            'mars',
            'avr.',
            'mai',
            'juin',
            'juil.',
            'août',
            'sept.',
            'oct.',
            'nov.',
            'déc.',
          ]
        : [
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec',
          ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
