// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mizaniya';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get french => 'Français';

  @override
  String get arabic => 'العربية';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get resetToDefaults => 'Reset to defaults';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get undo => 'UNDO';

  @override
  String get seeAll => 'See all';

  @override
  String get home => 'Home';

  @override
  String get transactions => 'Transactions';

  @override
  String get wallets => 'Wallets';

  @override
  String get history => 'History';

  @override
  String get addButton => 'Add';

  @override
  String get totalBalance => 'Total balance';

  @override
  String get incomeThisMonth => 'Income this month';

  @override
  String get spentThisMonth => 'Spent this month';

  @override
  String get spendingThisMonth => 'Spending this month';

  @override
  String get recent => 'Recent';

  @override
  String get noTransactionsTitle => 'No transactions yet';

  @override
  String get noTransactionsMessage =>
      'Tap \"Add\" to record your first expense or income.';

  @override
  String get noExpensesYetTitle => 'No expenses yet this month';

  @override
  String get noExpensesYetMessage =>
      'Add an expense to see where your money goes.';

  @override
  String get spent => 'Spent';

  @override
  String get searchHint => 'Search by title or category';

  @override
  String get filterAll => 'All';

  @override
  String get filterExpenses => 'Expenses';

  @override
  String get filterIncome => 'Income';

  @override
  String get swipeToDelete => 'Swipe a transaction left to delete it';

  @override
  String get nothingFoundTitle => 'Nothing found';

  @override
  String get nothingFoundMessage => 'Try another search or filter.';

  @override
  String deletedTransaction(String title) {
    return 'Deleted \"$title\"';
  }

  @override
  String get addTransaction => 'Add transaction';

  @override
  String get expense => 'Expense';

  @override
  String get income => 'Income';

  @override
  String get amount => 'Amount';

  @override
  String get currency => 'DA';

  @override
  String get enterAmount => 'Enter an amount';

  @override
  String get numbersOnly => 'Use numbers only';

  @override
  String get amountPositive => 'Amount must be greater than 0';

  @override
  String get amountTooLarge => 'This amount looks too large';

  @override
  String get category => 'Category';

  @override
  String get paidFrom => 'Paid from';

  @override
  String get receivedIn => 'Received in';

  @override
  String get descriptionOptional => 'Description (optional)';

  @override
  String get descriptionHelper => 'Left empty, the category name is used';

  @override
  String get tapToChangeDate => 'Tap to change the date';

  @override
  String get saveExpense => 'Save expense';

  @override
  String get saveIncome => 'Save income';

  @override
  String get notEnoughBalance => 'Not enough balance';

  @override
  String overdrawDialog(String shortfall, String balance) {
    return 'This expense is $shortfall more than the wallet balance ($balance). Save it anyway?';
  }

  @override
  String overdrawHint(String shortfall, String balance) {
    return 'This expense is $shortfall more than the wallet balance ($balance).';
  }

  @override
  String get saveAnyway => 'Save anyway';

  @override
  String savedTransaction(String title, String amount) {
    return 'Saved: $title · $amount';
  }

  @override
  String get totalAcrossWallets => 'Total across wallets';

  @override
  String get addWallet => 'Add wallet';

  @override
  String get noWalletsTitle => 'No wallets yet';

  @override
  String get noWalletsMessage =>
      'Add cash, a CCP account or a card to start tracking.';

  @override
  String get name => 'Name';

  @override
  String get currentBalance => 'Current balance';

  @override
  String get giveWalletName => 'Give your wallet a name';

  @override
  String get newWallet => 'New wallet';

  @override
  String get walletCash => 'Cash';

  @override
  String get walletBank => 'Bank / CCP';

  @override
  String get walletCard => 'Card';

  @override
  String get walletSavings => 'Savings';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryBills => 'Bills';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryLeisure => 'Leisure';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryOther => 'Other';

  @override
  String get categorySalary => 'Salary';

  @override
  String get categoryFreelance => 'Freelance';

  @override
  String get categoryGift => 'Gift';

  @override
  String get categoryOtherIncome => 'Other income';
}
