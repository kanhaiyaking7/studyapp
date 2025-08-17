
class UserState {
  String username;
  int age;
  int min_studytime;
  String English_Level;
  String email;
  int phone_Number;
  String bio;

  UserState({
    required this.username,
    required this.age,
    required this.min_studytime,
    required this.English_Level,
    required this.email,
    required this.phone_Number,
    required this.bio,
  });

  UserState copyWith({
    String? username,
    int? age,
    int? min_studytime,
    String? English_Level,
    String? email,
    int? phone_Number,
    String? bio
  }) {
    return UserState(
      username: username ?? this.username,
      age: age ?? this.age,
      min_studytime: min_studytime ?? this.min_studytime,
      English_Level: English_Level ?? this.English_Level,
      email: email ?? this.email,
      phone_Number: phone_Number ?? this.phone_Number,
      bio: bio ?? this.bio
    );
  }
}
