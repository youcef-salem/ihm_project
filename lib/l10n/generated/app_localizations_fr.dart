// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Mizaniya';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get english => 'English';

  @override
  String get french => 'Français';

  @override
  String get arabic => 'العربية';

  @override
  String get appearance => 'Apparence';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get resetToDefaults => 'Réinitialiser';

  @override
  String get cancel => 'Annuler';

  @override
  String get add => 'Ajouter';

  @override
  String get edit => 'Modifier';

  @override
  String get save => 'Enregistrer';

  @override
  String get undo => 'ANNULER';

  @override
  String get seeAll => 'Tout voir';

  @override
  String get home => 'Accueil';

  @override
  String get transactions => 'Transactions';

  @override
  String get wallets => 'Portefeuilles';

  @override
  String get history => 'Historique';

  @override
  String get addButton => 'Ajouter';

  @override
  String get totalBalance => 'Solde total';

  @override
  String get incomeThisMonth => 'Revenus ce mois';

  @override
  String get spentThisMonth => 'Dépenses ce mois';

  @override
  String get spendingThisMonth => 'Dépenses du mois';

  @override
  String get recent => 'Récent';

  @override
  String get noTransactionsTitle => 'Aucune transaction';

  @override
  String get noTransactionsMessage =>
      'Appuyez sur « Ajouter » pour enregistrer votre première dépense ou un revenu.';

  @override
  String get noExpensesYetTitle => 'Aucune dépense ce mois';

  @override
  String get noExpensesYetMessage =>
      'Ajoutez une dépense pour voir où va votre argent.';

  @override
  String get spent => 'Dépensé';

  @override
  String get searchHint => 'Rechercher par titre ou catégorie';

  @override
  String get filterAll => 'Tout';

  @override
  String get filterExpenses => 'Dépenses';

  @override
  String get filterIncome => 'Revenus';

  @override
  String get swipeToDelete =>
      'Glissez une transaction vers la gauche pour la supprimer';

  @override
  String get nothingFoundTitle => 'Rien trouvé';

  @override
  String get nothingFoundMessage =>
      'Essayez une autre recherche ou un autre filtre.';

  @override
  String deletedTransaction(String title) {
    return 'Supprimé « $title »';
  }

  @override
  String get addTransaction => 'Ajouter une transaction';

  @override
  String get expense => 'Dépense';

  @override
  String get income => 'Revenu';

  @override
  String get amount => 'Montant';

  @override
  String get currency => 'DA';

  @override
  String get enterAmount => 'Saisissez un montant';

  @override
  String get numbersOnly => 'Utilisez uniquement des chiffres';

  @override
  String get amountPositive => 'Le montant doit être supérieur à 0';

  @override
  String get amountTooLarge => 'Ce montant semble trop élevé';

  @override
  String get category => 'Catégorie';

  @override
  String get paidFrom => 'Payé depuis';

  @override
  String get receivedIn => 'Reçu sur';

  @override
  String get descriptionOptional => 'Description (facultatif)';

  @override
  String get descriptionHelper =>
      'Laissé vide, le nom de la catégorie est utilisé';

  @override
  String get tapToChangeDate => 'Appuyez pour changer la date';

  @override
  String get saveExpense => 'Enregistrer la dépense';

  @override
  String get saveIncome => 'Enregistrer le revenu';

  @override
  String get notEnoughBalance => 'Solde insuffisant';

  @override
  String overdrawDialog(String shortfall, String balance) {
    return 'Cette dépense dépasse le solde du portefeuille de $shortfall ($balance). L\'enregistrer quand même ?';
  }

  @override
  String overdrawHint(String shortfall, String balance) {
    return 'Cette dépense dépasse le solde du portefeuille de $shortfall ($balance).';
  }

  @override
  String get saveAnyway => 'Enregistrer quand même';

  @override
  String savedTransaction(String title, String amount) {
    return 'Enregistré : $title · $amount';
  }

  @override
  String get totalAcrossWallets => 'Total des portefeuilles';

  @override
  String get addWallet => 'Ajouter un portefeuille';

  @override
  String get noWalletsTitle => 'Aucun portefeuille';

  @override
  String get noWalletsMessage =>
      'Ajoutez des espèces, un compte CCP ou une carte pour commencer.';

  @override
  String get name => 'Nom';

  @override
  String get currentBalance => 'Solde actuel';

  @override
  String get giveWalletName => 'Donnez un nom à votre portefeuille';

  @override
  String get newWallet => 'Nouveau portefeuille';

  @override
  String get walletCash => 'Espèces';

  @override
  String get walletBank => 'Banque / CCP';

  @override
  String get walletCard => 'Carte';

  @override
  String get walletSavings => 'Épargne';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get categoryFood => 'Nourriture';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryBills => 'Factures';

  @override
  String get categoryShopping => 'Achats';

  @override
  String get categoryHealth => 'Santé';

  @override
  String get categoryLeisure => 'Loisirs';

  @override
  String get categoryEducation => 'Éducation';

  @override
  String get categoryOther => 'Autre';

  @override
  String get categorySalary => 'Salaire';

  @override
  String get categoryFreelance => 'Freelance';

  @override
  String get categoryGift => 'Cadeau';

  @override
  String get categoryOtherIncome => 'Autre revenu';
}
