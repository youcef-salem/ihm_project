import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../l10n/generated/app_localizations.dart';

/// Formats a price with a bidi isolate so the number and sign keep their
/// logical order inside right-to-left text (e.g. Arabic).
///
/// 12500 -> "12 500 DA". With sign: true, positives get a "+".
String formatMoney(num v, {bool sign = false, String currency = 'DA'}) {
  final neg = v < 0;
  final s = v.abs().round().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('\u00A0');
    buf.write(s[i]);
  }
  final prefix = neg ? '-' : (sign && v > 0 ? '+' : '');
  return '\u2066$prefix$buf\u00A0$currency\u2069';
}

String formatDateLabel(AppLocalizations l10n, Locale locale, DateTime d) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(d.year, d.month, d.day);
  final diff = today.difference(day).inDays;
  if (diff == 0) return l10n.today;
  if (diff == 1) return l10n.yesterday;
  return DateFormat.yMMMd(locale.toLanguageTag()).format(d);
}

double? parseAmount(String s) =>
    double.tryParse(s.trim().replaceAll(' ', '').replaceAll(',', '.'));
