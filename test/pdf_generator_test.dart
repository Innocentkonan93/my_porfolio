import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/data/utils/constants.dart';
import 'package:my_portfolio/app/services/pdf_generator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final theme in CvTheme.values) {
    for (final language in ['fr', 'en']) {
      test(
        'CV ${theme.name} generates in $language with embedded assets',
        () async {
          final bytes = await PdfGenerator().generateCV(
            user,
            languageCode: language,
            theme: theme,
          );
          expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
          expect(bytes.length, greaterThan(10000));
          if (Platform.environment['EXPORT_CV_PREVIEW'] == '1') {
            final file = File(
              'output/pdf/CV_Innocent_Konan_${theme.name}_${language.toUpperCase()}.pdf',
            );
            await file.parent.create(recursive: true);
            await file.writeAsBytes(bytes);
          }
        },
      );
    }
  }
}
