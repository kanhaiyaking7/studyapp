

class RoleplayData{
  String Scenariou;
  int chapter_completed;

  RoleplayData({required this.Scenariou, required this.chapter_completed});

  RoleplayData copyWith({ String? Scenariou,  int? chapter_completed}){
    return RoleplayData(Scenariou: Scenariou ?? this.Scenariou , chapter_completed: chapter_completed ?? this.chapter_completed);
  }
}

class Roleplayinfo{
  List <RoleplayData> Roleplaydata;

  Roleplayinfo({required this.Roleplaydata});

  Roleplayinfo copyWith({List<RoleplayData>? Roleplaydata}){
    return Roleplayinfo(Roleplaydata: Roleplaydata ?? this.Roleplaydata);
  }


}