enum InterruptionFilter {
  unknown(0),
  all(1),
  priority(2),
  none(3),
  alarms(4);

  final int value;
  const InterruptionFilter(this.value);

  static InterruptionFilter fromValue(int value) {
    return InterruptionFilter.values.firstWhere(
      (filter) => filter.value == value,
      orElse: () => InterruptionFilter.unknown,
    );
  }
}
