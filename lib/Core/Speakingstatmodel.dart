
class SpeakingStats {
  final int conversationMinutes;
  final int pronunciationMinutes;
  final int grammarMinutes;

  SpeakingStats({
    this.conversationMinutes = 0,
    this.pronunciationMinutes = 0,
    this.grammarMinutes = 0,
  });

  int get totalMinutes =>
      conversationMinutes + pronunciationMinutes + grammarMinutes;

  double getConversationPercent() =>
      totalMinutes == 0 ? 0 : (conversationMinutes / totalMinutes) * 100;

  double getPronunciationPercent() =>
      totalMinutes == 0 ? 0 : (pronunciationMinutes / totalMinutes) * 100;

  double getGrammarPercent() =>
      totalMinutes == 0 ? 0 : (grammarMinutes / totalMinutes) * 100;

  SpeakingStats copyWith({
    int? conversationMinutes,
    int? pronunciationMinutes,
    int? grammarMinutes,
  }) {
    return SpeakingStats(
      conversationMinutes: conversationMinutes ?? this.conversationMinutes,
      pronunciationMinutes: pronunciationMinutes ?? this.pronunciationMinutes,
      grammarMinutes: grammarMinutes ?? this.grammarMinutes,
    );
  }
}
