# Bastien & Scapin criteria -> where they live in the code (EcoBudget)

| Criterion | Concrete elements |
|---|---|
| Guidance | Helper texts ("Swipe left to delete", "Tap a category to change its limit"), empty states with next step, quick-amount chips, tooltips, SnackBar feedback after save/delete, live "more than balance" hint |
| Workload | Preselected category + wallet + today's date, +500/+1000/+2000/+5000 chips, optional description, one global "Add" button on every tab, dashboard summary |
| Explicit control | Swipe-delete with UNDO, dismissible insights, confirm dialog before overdraft expense, Cancel on every dialog, user-set budget limits |
| Adaptability | Light/Dark/Auto theme, text size slider (85-140%), multiple wallets, editable budgets, custom goals |
| Error management | Inline validation (empty / non-numeric / <=0 / too large), no future dates, overdraft warning + confirm, budget alerts at 80% and 100% |
| Consistency | Single theme, same card/tile/chip components, same income (+green) / expense (-red) treatment, same dialog pattern, fixed bottom navigation |
| Meaningful codes | Category icons + names, +/- signs and arrows besides colors, status labels (On track / Almost at limit / Over budget) with icons, plain-language insight messages |
| Compatibility | DA currency with thousands grouping, CCP / Cash / Card wallet types (Algerian context), tasks ordered like real use (amount -> category -> wallet), 5 tabs matching user goals |

## Innovation (state/insights_provider.dart)
- Unusual-expense detection (amount > 2.5x category average)
- Budget alerts at 80% / 100%
- Low-savings tip (< 10% of income)
