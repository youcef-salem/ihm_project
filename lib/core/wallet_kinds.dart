import 'package:flutter/material.dart';

import '../data/models/wallet.dart';
import '../l10n/generated/app_localizations.dart';

IconData walletKindIcon(WalletKind k) => switch (k) {
  WalletKind.cash => Icons.payments_outlined,
  WalletKind.bank => Icons.account_balance_outlined,
  WalletKind.card => Icons.credit_card,
  WalletKind.savings => Icons.savings_outlined,
};

String walletKindLabel(AppLocalizations l10n, WalletKind k) => switch (k) {
  WalletKind.cash => l10n.walletCash,
  WalletKind.bank => l10n.walletBank,
  WalletKind.card => l10n.walletCard,
  WalletKind.savings => l10n.walletSavings,
};

String walletDisplayName(AppLocalizations l10n, Wallet w) => switch (w.id) {
  'w_cash' => l10n.walletCash,
  'w_ccp' => l10n.walletBank,
  'w_card' => l10n.walletCard,
  _ => w.name,
};
