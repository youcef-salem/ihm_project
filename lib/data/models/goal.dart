class Goal {
  final String id;
  final String name;
  final double target;
  final double saved;
  final DateTime deadline;

  const Goal({
    required this.id,
    required this.name,
    required this.target,
    required this.saved,
    required this.deadline,
  });

  double get progress => target <= 0 ? 0 : (saved / target).clamp(0.0, 1.0);

  Goal copyWith({double? saved}) => Goal(
        id: id,
        name: name,
        target: target,
        saved: saved ?? this.saved,
        deadline: deadline,
      );
}
