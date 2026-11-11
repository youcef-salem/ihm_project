# data/

TODO (later): repositories + data sources (local DB / API).

- `models/`       plain entities used by `state/` and `ui/`
- `repositories/` will expose the operations the Notifiers in `state/` currently do in memory
- `sources/`      sqflite / Hive / REST clients

Until then `state/mock_seed.dart` provides seed data. To plug the real data layer in,
replace the seeds in each Notifier's `build()` and its mutating methods with repository calls.
