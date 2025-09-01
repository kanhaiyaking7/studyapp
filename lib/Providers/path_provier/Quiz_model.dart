

class completed_Level{
 int Level_no;
  String Accuracy;
  int score;
  int time;

  completed_Level({required this.Level_no, required this.Accuracy,
    required this.score,required this.time});

}

class UserProgress{
  int Level;
  List<completed_Level> completed_level;
  int score;


UserProgress({required this.Level, required this.completed_level, required this.score});

UserProgress copyWith({int? Level, List<completed_Level>? completed_level, int? score}){
  return UserProgress(Level: Level ?? this.Level,
      completed_level: completed_level ?? this.completed_level,
      score: score ?? this.score);
}

}