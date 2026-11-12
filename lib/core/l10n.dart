import 'package:flutter/widgets.dart';

import '../data/models/wallet.dart';
import '../l10n/generated/app_localizations.dart';
import 'format.dart';
import 'wallet_kinds.dart';

export '../l10n/generated/app_localizations.dart';

AppLocalizations l10nFor(Locale locale) => lookupAppLocalizations(locale);

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  Locale get appLocale => Localizations.localeOf(this);

  String money(num v, {bool sign = false}) =>
      formatMoney(v, sign: sign, currency: l10n.currency);

  String dateLabel(DateTime d) => formatDateLabel(l10n, appLocale, d);

  String walletName(Wallet w) => walletDisplayName(l10n, w);
}
