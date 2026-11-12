# Bastien & Scapin criteria -> where they live in the code (EcoBudget)

| Criterion | Concrete elements |
|---|---|
| Guidance | Helper texts ("Swipe left to delete"), empty states with next step, quick-amount chips, tooltips, SnackBar feedback after save/delete, live "more than balance" hint |
| Workload | Preselected category + wallet + today's date, +500/+1000/+2000/+5000 chips, optional description, one global "Add" button on every tab, dashboard summary |
| Explicit control | Swipe-delete with UNDO, confirm dialog before overdraft expense, Cancel on every dialog |
| Adaptability | Light/Dark/Auto theme, text size slider (85-140%), multiple wallets |
| Error management | Inline validation (empty / non-numeric / <=0 / too large), no future dates, overdraft warning + confirm |
| Consistency | Single theme, same card/tile/chip components, same income (+green) / expense (-red) treatment, same dialog pattern, fixed bottom navigation |
| Meaningful codes | Category icons + names, +/- signs and arrows besides colors |
| Compatibility | DA currency with thousands grouping, CCP / Cash / Card wallet types (Algerian context), tasks ordered like real use (amount -> category -> wallet), 3 tabs matching user goals |
