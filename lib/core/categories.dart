import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

class Category {
  final String id;
  final IconData icon;
  final Color color;
  const Category(this.id, this.icon, this.color);
}

const expenseCategories = <Category>[
  Category('food', Icons.restaurant, Color(0xFFEF6C00)),
  Category('transport', Icons.directions_bus, Color(0xFF1E88E5)),
  Category('bills', Icons.receipt_long, Color(0xFF6D4C41)),
  Category('shopping', Icons.shopping_bag, Color(0xFFD81B60)),
  Category('health', Icons.favorite, Color(0xFFE53935)),
  Category('leisure', Icons.sports_esports, Color(0xFF8E24AA)),
  Category('education', Icons.school, Color(0xFF3949AB)),
  Category('other', Icons.more_horiz, Color(0xFF607D8B)),
];

const incomeCategories = <Category>[
  Category('salary', Icons.payments, Color(0xFF2E9E5B)),
  Category('freelance', Icons.laptop_mac, Color(0xFF00897B)),
  Category('gift', Icons.card_giftcard, Color(0xFF7CB342)),
  Category('other_in', Icons.add_circle_outline, Color(0xFF546E7A)),
];

final allCategories = <Category>[...expenseCategories, ...incomeCategories];

Category categoryById(String id) => allCategories.firstWhere(
  (c) => c.id == id,
  orElse: () => expenseCategories.last,
);

String categoryName(AppLocalizations l10n, String id) => switch (id) {
  'food' => l10n.categoryFood,
  'transport' => l10n.categoryTransport,
  'bills' => l10n.categoryBills,
  'shopping' => l10n.categoryShopping,
  'health' => l10n.categoryHealth,
  'leisure' => l10n.categoryLeisure,
  'education' => l10n.categoryEducation,
  'other' => l10n.categoryOther,
  'salary' => l10n.categorySalary,
  'freelance' => l10n.categoryFreelance,
  'gift' => l10n.categoryGift,
  'other_in' => l10n.categoryOtherIncome,
  _ => l10n.categoryOther,
};
