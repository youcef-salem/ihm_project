# data/

Calculations and entities for EcoBudget. There is **no backend**: all data lives
in app state (`lib/state/`), and this layer only computes values from it.

- `models/`        plain entities used by `state/` and `ui/`
- `calculations/`  pure functions/classes with the app logic
  - `summary.dart`      month income/expense totals + expenses per category
  - `wallets.dart`      balance per wallet + total across wallets
  - `transactions.dart` search and type filtering

The Notifiers in `lib/state/` only hold mutable app state and delegate every
calculation to the functions above.
