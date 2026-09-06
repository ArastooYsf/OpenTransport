// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'اوپن‌ترانسپورت';

  @override
  String get stationListTitle => 'ایستگاه‌ها';

  @override
  String interchangeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count خط',
      one: '۱ خط',
    );
    return '$_temp0';
  }

  @override
  String get loadError => 'بارگذاری اطلاعات حمل‌ونقل ممکن نشد.';
}
