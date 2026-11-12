import 'package:flutter/material.dart';

import '../../core/l10n.dart';

/// Renders a price consistently in every locale, including RTL Arabic.
class MoneyText extends StatelessWidget {
  final num value;
  final bool sign;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool softWrap;

  const MoneyText(
    this.value, {
    super.key,
    this.sign = false,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      context.money(value, sign: sign),
      style: style,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
