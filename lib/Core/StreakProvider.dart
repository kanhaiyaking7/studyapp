
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Core/StreakModel.dart';

class StreakNotifier extends StateNotifier<Streak> {
  StreakNotifier() : super(Streak(currentStreak: 0, lastActiveDate: DateTime.now()));

  void markTodayActive() {
    print("steak@@@@@@@@@");
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(state.lastActiveDate.year, state.lastActiveDate.month, state.lastActiveDate.day);

    if (today.difference(lastDate).inDays == 1) {
      // Consecutive day → increase streak
      state = state.copyWith(
        currentStreak: state.currentStreak + 1,
        lastActiveDate: today,
      );
    } else if (today.difference(lastDate).inDays > 1) {
      // Missed a day → reset
      state = Streak(currentStreak: 1, lastActiveDate: today);
    } else if (today.isAtSameMomentAs(lastDate)) {
      // Same day → do nothing
    }
  }
}

final streakProvider = StateNotifierProvider<StreakNotifier, Streak>((ref) {
  return StreakNotifier();
});
