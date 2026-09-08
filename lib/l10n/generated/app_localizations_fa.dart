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

  @override
  String get homeMetroTitle => 'مترو';

  @override
  String get homeMetroSubtitle => 'خطوط و ایستگاه‌ها';

  @override
  String get homeBrtTitle => 'BRT';

  @override
  String get homeBrtComingSoon => 'به‌زودی';

  @override
  String get homeSmartTitle => 'همگانی';

  @override
  String get homeSmartSubtitle => 'ساده‌ترین راه به هر مقصد یا ایستگاه';

  @override
  String get placeholderComingSoonMessage => 'این بخش به‌زودی اضافه می‌شود.';

  @override
  String get commonConfirm => 'تأیید';

  @override
  String get commonCancel => 'انصراف';

  @override
  String get commonSkipAll => 'رد کردن همه';

  @override
  String onboardingStepIndicator(int step, int total) {
    return 'مرحله $step از $total';
  }

  @override
  String onboardingStepCircleLabel(int step, String state) {
    return 'مرحله $step: $state';
  }

  @override
  String get onboardingStepStateUpcoming => 'پیش‌رو';

  @override
  String get onboardingStepStateCurrent => 'فعلی';

  @override
  String get onboardingStepStateCompleted => 'تکمیل‌شده';

  @override
  String get onboardingStepStateSkipped => 'ناقص';

  @override
  String get onboardingBackButtonTooltip => 'بازگشت';

  @override
  String get onboardingUsernameCheckingStatus => 'در حال بررسی موجود بودن';

  @override
  String get onboardingUsernameAvailableStatus => 'این نام کاربری موجود است';

  @override
  String get onboardingSkipConfirmMessage =>
      'اگه رد کنی، مشکلی برات پیش نمیاد و می‌تونی از نقشه‌ها استفاده کنی. ولی بدون حساب کاربری نمی‌تونی: مسیرهای موردعلاقه‌تو ذخیره کنی، تنظیماتت بین گوشی‌هات هماهنگ بشه، یا داده‌ی جدید به جامعه اضافه کنی.';

  @override
  String get onboardingWithoutAccountTitle => 'بدون حساب کاربری';

  @override
  String get onboardingWithoutAccountIntro => 'بدون حساب کاربری نمی‌تونی:';

  @override
  String get onboardingWithoutAccountBulletSaveRoutes =>
      'مسیرهای موردعلاقه‌تو ذخیره کنی';

  @override
  String get onboardingWithoutAccountBulletSyncSettings =>
      'تنظیماتت بین گوشی‌هات هماهنگ بشه';

  @override
  String get onboardingWithoutAccountBulletContribute =>
      'داده‌ی جدید به جامعه اضافه کنی';

  @override
  String get onboardingWithoutAccountDismiss => 'متوجه شدم';

  @override
  String get onboardingContinueButton => 'ادامه';

  @override
  String get onboardingAutocompleteNoMatches => 'نتیجه‌ای یافت نشد';

  @override
  String get onboardingCountryLanguageStepTitle => 'کشور و زبان';

  @override
  String get onboardingCountryFieldLabel => 'کشور';

  @override
  String get onboardingLanguageFieldLabel => 'زبان';

  @override
  String get onboardingProfileStepTitle => 'کمی درباره خودت بگو';

  @override
  String get onboardingProfileStepSubtitle => 'نام و نام خانوادگی اختیاری‌اند';

  @override
  String get onboardingUsernameLabel => 'نام کاربری';

  @override
  String get onboardingUsernameFormatHint =>
      'فقط حروف انگلیسی، عدد و _، بین ۳ تا ۲۰ کاراکتر';

  @override
  String get onboardingUsernameTaken => 'این نام کاربری قبلاً گرفته شده';

  @override
  String get onboardingFirstNameLabel => 'نام';

  @override
  String get onboardingLastNameLabel => 'نام خانوادگی';

  @override
  String get onboardingNamePlausibilityHint => 'بهتره حداقل یک حرف داشته باشه';

  @override
  String get onboardingPasswordStepTitle => 'ایمیل و رمز عبور';

  @override
  String get onboardingEmailLabel => 'ایمیل';

  @override
  String get onboardingEmailInvalid => 'یک ایمیل معتبر وارد کن';

  @override
  String get onboardingClearFieldTooltip => 'پاک کردن';

  @override
  String get onboardingShowPasswordTooltip => 'نمایش رمز عبور';

  @override
  String get onboardingHidePasswordTooltip => 'پنهان کردن رمز عبور';

  @override
  String get onboardingPasswordLabel => 'رمز عبور';

  @override
  String get onboardingPasswordMinLengthNote => 'بهتره حداقل ۸ کاراکتر باشه';

  @override
  String get onboardingPasswordStrengthWeak => 'ضعیف';

  @override
  String get onboardingPasswordStrengthGood => 'خوب';

  @override
  String get onboardingPasswordStrengthStrong => 'قوی';

  @override
  String get onboardingPasswordSuggestUppercase =>
      'بهتره یک حرف بزرگ هم داشته باشه';

  @override
  String get onboardingPasswordSuggestNumber => 'بهتره یک عدد هم داشته باشه';

  @override
  String get onboardingPasswordSuggestSpecialChar =>
      'بهتره یک نماد ویژه هم داشته باشه (مثل !@#\$)';

  @override
  String get onboardingCompletionGreeting => 'خوش اومدی';

  @override
  String get onboardingTutorialPromptQuestion =>
      'می‌خوای یه آموزش سریع از برنامه ببینی؟';

  @override
  String get onboardingTutorialPromptNote =>
      'همیشه می‌تونی این آموزش رو از تنظیمات دوباره اجرا کنی.';

  @override
  String get onboardingTutorialShowButton => 'دیدن آموزش';

  @override
  String get onboardingTutorialSkipButton => 'فعلا نه';

  @override
  String get shellTabHome => 'خانه';

  @override
  String get shellTabMap => 'نقشه';

  @override
  String get shellTabSaved => 'ذخیره‌شده';

  @override
  String get shellTabAccount => 'حساب کاربری';

  @override
  String get shellTabSettings => 'تنظیمات';
}
