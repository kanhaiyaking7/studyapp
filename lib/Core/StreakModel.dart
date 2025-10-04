
class Streak {
  final int currentStreak;
  final DateTime lastActiveDate;

  Streak({
    required this.currentStreak,
    required this.lastActiveDate,
  });

  Streak copyWith({
    int? currentStreak,
    DateTime? lastActiveDate,
  }) {
    return Streak(
      currentStreak: currentStreak ?? this.currentStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }
}
