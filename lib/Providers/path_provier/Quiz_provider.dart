

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/path_provier/Quiz_model.dart';

import '../../features/auth/provider/User_provider.dart';

final UserProgress_Provider = StateNotifierProvider<Progressnotifier, UserProgress>((ref){
  return Progressnotifier();
});

class Progressnotifier extends StateNotifier<UserProgress>{
 Progressnotifier():super(UserProgress(Level: 0, completed_level: [], score: 0));


  void store_lessondata(int Level, String accuracy,int point,int interval ){
    final data_struct = completed_Level(Level_no:Level , Accuracy: accuracy,
        score: point, time: interval);
   // state.completed_level.add(data_struct);
   // final pus = state.toString();

    state = state.copyWith(completed_level: [...state.completed_level,data_struct]);
  }

  void increase_score(int value){
    final lat_score = state.score + value;
    state = state.copyWith(score: lat_score);
  }

  void user_Level(){
    // final lat_Level = ;
    state = state.copyWith(Level: state.Level + 1);
  }

}