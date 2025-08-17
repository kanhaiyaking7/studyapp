

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/features/auth/provider/User_State.dart';

final UserDetails = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier()
      : super(
    UserState(username: "", age: 0, min_studytime: 0, English_Level: "",
        email: "",phone_Number: 0,bio: ""),
  );

  void user_info(String name, int age) {
    state = state.copyWith(username: name, age: age);
  }

  void user_studytime(int query) {
    state = state.copyWith(min_studytime: query);
  }

  void user_englishL(String query) {
    state = state.copyWith(English_Level: query);
  }

  void complete_user_detils(String name, int age, String email,int phone_no, String Bio){
    state = state.copyWith(username: name,age: age,email: email,
        phone_Number: phone_no,bio: Bio);
  }
}
