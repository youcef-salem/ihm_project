// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ميزانية';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'English';

  @override
  String get french => 'Français';

  @override
  String get arabic => 'العربية';

  @override
  String get appearance => 'المظهر';

  @override
  String get themeAuto => 'تلقائي';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get resetToDefaults => 'إعادة الإعدادات الافتراضية';

  @override
  String get cancel => 'إلغاء';

  @override
  String get add => 'إضافة';

  @override
  String get edit => 'تعديل';

  @override
  String get save => 'حفظ';

  @override
  String get undo => 'تراجع';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get home => 'الرئيسية';

  @override
  String get transactions => 'المعاملات';

  @override
  String get wallets => 'المحافظ';

  @override
  String get history => 'السجل';

  @override
  String get addButton => 'إضافة';

  @override
  String get totalBalance => 'الرصيد الإجمالي';

  @override
  String get incomeThisMonth => 'دخل هذا الشهر';

  @override
  String get spentThisMonth => 'مصروف هذا الشهر';

  @override
  String get spendingThisMonth => 'الإنفاق هذا الشهر';

  @override
  String get recent => 'الأخيرة';

  @override
  String get noTransactionsTitle => 'لا توجد معاملات بعد';

  @override
  String get noTransactionsMessage =>
      'اضغط على \"إضافة\" لتسجيل أول مصروف أو دخل.';

  @override
  String get noExpensesYetTitle => 'لا توجد مصروفات هذا الشهر';

  @override
  String get noExpensesYetMessage => 'أضف مصروفًا لمعرفة أين يذهب مالك.';

  @override
  String get spent => 'المنفق';

  @override
  String get searchHint => 'ابحث بالعنوان أو الفئة';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterExpenses => 'المصروفات';

  @override
  String get filterIncome => 'الدخل';

  @override
  String get swipeToDelete => 'اسحب المعاملة إلى اليمين لحذفها';

  @override
  String get nothingFoundTitle => 'لم يتم العثور على شيء';

  @override
  String get nothingFoundMessage => 'جرّب بحثًا أو تصفية أخرى.';

  @override
  String deletedTransaction(String title) {
    return 'تم حذف \"$title\"';
  }

  @override
  String get addTransaction => 'إضافة معاملة';

  @override
  String get expense => 'مصروف';

  @override
  String get income => 'دخل';

  @override
  String get amount => 'المبلغ';

  @override
  String get currency => 'دج';

  @override
  String get enterAmount => 'أدخل مبلغًا';

  @override
  String get numbersOnly => 'استخدم الأرقام فقط';

  @override
  String get amountPositive => 'يجب أن يكون المبلغ أكبر من 0';

  @override
  String get amountTooLarge => 'هذا المبلغ كبير جدًا';

  @override
  String get category => 'الفئة';

  @override
  String get paidFrom => 'الدفع من';

  @override
  String get receivedIn => 'الاستلام في';

  @override
  String get descriptionOptional => 'الوصف (اختياري)';

  @override
  String get descriptionHelper => 'إذا تُرك فارغًا، يُستخدم اسم الفئة';

  @override
  String get tapToChangeDate => 'اضغط لتغيير التاريخ';

  @override
  String get saveExpense => 'حفظ المصروف';

  @override
  String get saveIncome => 'حفظ الدخل';

  @override
  String get notEnoughBalance => 'الرصيد غير كافٍ';

  @override
  String overdrawDialog(String shortfall, String balance) {
    return 'هذا المصروف يتجاوز رصيد المحفظة بمقدار $shortfall ($balance). هل تريد حفظه على أي حال؟';
  }

  @override
  String overdrawHint(String shortfall, String balance) {
    return 'هذا المصروف يتجاوز رصيد المحفظة بمقدار $shortfall ($balance).';
  }

  @override
  String get saveAnyway => 'حفظ على أي حال';

  @override
  String savedTransaction(String title, String amount) {
    return 'تم الحفظ: $title · $amount';
  }

  @override
  String get totalAcrossWallets => 'الإجمالي في المحافظ';

  @override
  String get addWallet => 'إضافة محفظة';

  @override
  String get noWalletsTitle => 'لا توجد محافظ بعد';

  @override
  String get noWalletsMessage => 'أضف نقدًا أو حساب CCP أو بطاقة لبدء التتبع.';

  @override
  String get name => 'الاسم';

  @override
  String get currentBalance => 'الرصيد الحالي';

  @override
  String get giveWalletName => 'أعط محفظتك اسمًا';

  @override
  String get newWallet => 'محفظة جديدة';

  @override
  String get walletCash => 'نقد';

  @override
  String get walletBank => 'بنك / CCP';

  @override
  String get walletCard => 'بطاقة';

  @override
  String get walletSavings => 'مدخرات';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get categoryFood => 'طعام';

  @override
  String get categoryTransport => 'نقل';

  @override
  String get categoryBills => 'فواتير';

  @override
  String get categoryShopping => 'تسوق';

  @override
  String get categoryHealth => 'صحة';

  @override
  String get categoryLeisure => 'ترفيه';

  @override
  String get categoryEducation => 'تعليم';

  @override
  String get categoryOther => 'أخرى';

  @override
  String get categorySalary => 'راتب';

  @override
  String get categoryFreelance => 'عمل حر';

  @override
  String get categoryGift => 'هدية';

  @override
  String get categoryOtherIncome => 'دخل آخر';
}
