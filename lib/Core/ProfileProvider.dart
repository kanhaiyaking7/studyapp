


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Core/Profilemodel.dart';

final ProfileProvider = StateNotifierProvider<ProfileNotifier,ProfileModel>((ref){
  return ProfileNotifier();
});

 class ProfileNotifier extends StateNotifier<ProfileModel>{
  ProfileNotifier():super(ProfileModel(coin: 250, Speaking_time: 8, Streak: 5));


  void increase_coin(int value){
    final lat_coin = state.coin + value;
    state = state.copyWith(coin: lat_coin);
  }

  void increase_Streak(int value){
    final lat_Streak = state.Streak + value;
    state = state.copyWith(Sreak: lat_Streak);
  }

  void increase_Speaking_time(int value){
    final lat_time = state.Speaking_time + value;
    state = state.copyWith(Speaking_time: lat_time);
  }



 }