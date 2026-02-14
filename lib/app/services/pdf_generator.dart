import 'package:flutter/services.dart';

import 'package:my_portfolio/app/data/models/user_model.dart';
import 'package:my_portfolio/app/data/utils/constants.dart';
import 'package:my_portfolio/app/services/localizations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGenerator {
  Future<void> generateAndPrintCV(UserModel user) async {
    final pdf = pw.Document();
    final profileImage = pw.MemoryImage(
      (await rootBundle.load(user.profilePicture)).buffer.asUint8List(),
    );

    final fontRegular = await rootBundle.load(
      "assets/fonts/FiraSans-Regular.ttf",
    );
    final fontBold = await rootBundle.load("assets/fonts/FiraSans-Bold.ttf");
    final fontItalic = await rootBundle.load(
      "assets/fonts/FiraSans-Italic.ttf",
    );
    final fontBoldItalic = await rootBundle.load(
      "assets/fonts/FiraSans-BoldItalic.ttf",
    );

    final strings = Localization().keys['en']!;
    final grey = PdfColors.grey500;
    final blue = PdfColor.fromHex('#2980b9');
    final primaryColor = PdfColor.fromInt(0xFF5F27CD);
    final gap = pw.EdgeInsets.symmetric(horizontal: 50);

    pw.Widget titleWidget({required String text}) {
      return pw.Text(
        text,
        style: pw.TextStyle(
          color: grey,
          fontSize: 10,
          fontWeight: pw.FontWeight.normal,
          letterSpacing: 1.5,
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(fontRegular),
            bold: pw.Font.ttf(fontBold),
            italic: pw.Font.ttf(fontItalic),
            boldItalic: pw.Font.ttf(fontBoldItalic),
          ),

          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(vertical: 30),
        ),

        build: (pw.Context context) {
          return [
            pw.Container(
              margin: pw.EdgeInsets.symmetric(vertical: 20),
              padding: gap,
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        user.name.toUpperCase(),
                        style: pw.TextStyle(
                          fontSize: 25,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        user.function,
                        style: const pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ],
                  ),
                  pw.Container(
                    height: 80,
                    width: 80,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      image: pw.DecorationImage(
                        image: profileImage,
                        fit: pw.BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Container(
              margin: gap,
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        titleWidget(text: "Intro".toUpperCase()),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          strings['headline'] ?? '',
                          style: const pw.TextStyle(fontSize: 12),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          'To see all of my works with their links, check out my web portfolio:',
                          style: const pw.TextStyle(fontSize: 12),
                        ),
                        pw.UrlLink(
                          destination: 'https://ikonan.com',
                          child: pw.Text(
                            'https://ikonan.com',
                            style: pw.TextStyle(
                              color: blue,
                              decoration: pw.TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 40),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        titleWidget(text: "Contact".toUpperCase()),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          user.email,
                          style: const pw.TextStyle(
                            color: PdfColors.grey700,
                            fontSize: 12,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        ...user.socialLinks.map((link) {
                          final url = link.url.replaceFirst('https://', '');

                          return pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 4),
                            child: pw.UrlLink(
                              destination: link.url,
                              child: pw.Text(
                                url.replaceFirst('www.', ''),
                                style: pw.TextStyle(
                                  color: blue,
                                  decoration: pw.TextDecoration.underline,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // app section
            pw.SizedBox(height: 30),
            pw.Container(
              margin: gap,
              child: titleWidget(text: "Apps".toUpperCase()),
            ),
            pw.SizedBox(height: 10),
            pw.Container(
              margin: gap,
              child: pw.Column(
                children: [
                  ...appsList.map(
                    (app) => pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 6),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('- '),
                          pw.Expanded(
                            child: pw.RichText(
                              text: pw.TextSpan(
                                style: const pw.TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                                children: [
                                  pw.TextSpan(
                                    text: '${app.title}: ',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text:
                                        strings[app.description] ??
                                        app.description,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Experience Section
            pw.SizedBox(height: 30),
            pw.Container(
              margin: gap,
              child: titleWidget(text: "Experience".toUpperCase()),
            ),
            pw.SizedBox(height: 10),
            pw.Container(
              margin: gap,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  ...user.experiences.map((exp) {
                    final isPresent =
                        exp.endDate.difference(DateTime.now()).inDays.abs() < 1;
                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 15),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            strings[exp.role] ?? exp.role,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          pw.Text(
                            exp.organizationName,
                            style: pw.TextStyle(
                              fontStyle: pw.FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                          pw.Text(
                            '${_formatDate(exp.beginDate)} - ${isPresent ? "Present" : _formatDate(exp.endDate)} (${_getDuration(exp.beginDate, exp.endDate)})',
                            style: pw.TextStyle(color: grey, fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ];
        },
      ),
    );

    // This will trigger a download on the web and open the share sheet on mobile
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'CV_Innocent_KONAN.pdf',
    );
  }

  String _formatDate(DateTime date) {
    const months = [
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

  String _getDuration(DateTime start, DateTime end) {
    final isPresent = end.difference(DateTime.now()).inDays.abs() < 1;
    final effectiveEnd = isPresent ? DateTime.now() : end;

    int totalMonths =
        (effectiveEnd.year - start.year) * 12 +
        effectiveEnd.month -
        start.month;

    if (totalMonths < 1) totalMonths = 1;

    final years = totalMonths ~/ 12;
    final months = totalMonths % 12;

    if (years > 0) {
      if (months > 0) {
        return '$years years $months months';
      }
      return '$years years';
    }
    return '$months months';
  }
}
