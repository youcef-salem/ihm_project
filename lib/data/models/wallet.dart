enum WalletKind { cash, bank, card, savings }

class Wallet {
  final String id;
  final String name;
  final WalletKind kind;
  final double initialBalance;

  const Wallet({
    required this.id,
    required this.name,
    required this.kind,
    required this.initialBalance,
  });
}
