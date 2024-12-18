/// The InterruptionFilter enum represents the different types of interruption filters possible.
enum InterruptionFilter {
  /// Unknown interruption filter.
  unknown(0),

  /// All interruptions are disallowed.
  all(1),

  /// Priority interruptions are allowed.
  priority(2),

  /// No interruptions are allowed.
  none(3),

  /// Alarms only are allowed.
  alarms(4);

  /// The value of the InterruptionFilter.
  final int value;
  const InterruptionFilter(this.value);

  /// Returns the InterruptionFilter from the given value.
  static InterruptionFilter fromValue(int value) {
    return InterruptionFilter.values.firstWhere(
      (filter) => filter.value == value,
      orElse: () => InterruptionFilter.unknown,
    );
  }
}
