import 'package:flutter/material.dart';
import '../data/models/wallet.dart';

IconData walletKindIcon(WalletKind k) => switch (k) {
      WalletKind.cash => Icons.payments_outlined,
      WalletKind.bank => Icons.account_balance_outlined,
      WalletKind.card => Icons.credit_card,
      WalletKind.savings => Icons.savings_outlined,
    };

String walletKindLabel(WalletKind k) => switch (k) {
      WalletKind.cash => 'Cash',
      WalletKind.bank => 'Bank / CCP',
      WalletKind.card => 'Card',
      WalletKind.savings => 'Savings',
    };
