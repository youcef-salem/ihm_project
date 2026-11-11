import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  const Category(this.id, this.name, this.icon, this.color);
}

const expenseCategories = <Category>[
  Category('food', 'Food', Icons.restaurant, Color(0xFFEF6C00)),
  Category('transport', 'Transport', Icons.directions_bus, Color(0xFF1E88E5)),
  Category('bills', 'Bills', Icons.receipt_long, Color(0xFF6D4C41)),
  Category('shopping', 'Shopping', Icons.shopping_bag, Color(0xFFD81B60)),
  Category('health', 'Health', Icons.favorite, Color(0xFFE53935)),
  Category('leisure', 'Leisure', Icons.sports_esports, Color(0xFF8E24AA)),
  Category('education', 'Education', Icons.school, Color(0xFF3949AB)),
  Category('other', 'Other', Icons.more_horiz, Color(0xFF607D8B)),
];

const incomeCategories = <Category>[
  Category('salary', 'Salary', Icons.payments, Color(0xFF2E9E5B)),
  Category('freelance', 'Freelance', Icons.laptop_mac, Color(0xFF00897B)),
  Category('gift', 'Gift', Icons.card_giftcard, Color(0xFF7CB342)),
  Category('other_in', 'Other income', Icons.add_circle_outline, Color(0xFF546E7A)),
];

final allCategories = <Category>[...expenseCategories, ...incomeCategories];

Category categoryById(String id) => allCategories.firstWhere(
      (c) => c.id == id,
      orElse: () => expenseCategories.last,
    );
