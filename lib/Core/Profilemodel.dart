
class ProfileModel{
  int coin;
  int Speaking_time;
  int Streak;

  ProfileModel({required this.coin, required this.Speaking_time, required this.Streak});

  ProfileModel copyWith({int? coin, int? Speaking_time, int? Sreak}){
    return ProfileModel(
        coin: coin ?? this.coin,
        Speaking_time: Speaking_time ?? this.Speaking_time,
        Streak: Sreak ?? this.Streak
    );
  }
}