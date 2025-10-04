
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Core/Speakingstatmodel.dart';

class StatsNotifier extends StateNotifier<SpeakingStats> {
  StatsNotifier() : super(SpeakingStats());

  void addActivity(String category, int minutes) {
    if (category == 'Conversation') {
      state = state.copyWith(conversationMinutes: state.conversationMinutes + minutes);
    } else if (category == 'Pronunciation') {
      state = state.copyWith(pronunciationMinutes: state.pronunciationMinutes + minutes);
    } else if (category == 'Grammar') {
      state = state.copyWith(grammarMinutes: state.grammarMinutes + minutes);
    }
  }

  void resetWeek() {
    state = SpeakingStats();
  }
}

final statsProvider = StateNotifierProvider<StatsNotifier, SpeakingStats>((ref) {
  return StatsNotifier();
});
