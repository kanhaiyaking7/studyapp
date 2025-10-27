
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/Aichat_provider/RolePlayLevel.dart';

final RoleplayProvider = StateNotifierProvider<Roleplaynotifier,Roleplayinfo>((ref){
  return Roleplaynotifier();
})  ;

class Roleplaynotifier extends StateNotifier<Roleplayinfo>{
  Roleplaynotifier():super(Roleplayinfo(Roleplaydata: [
    RoleplayData(Scenariou: "Job_interview", chapter_completed: 0),
    RoleplayData(Scenariou: "Making_Friends", chapter_completed: 0),
    RoleplayData(Scenariou: "shoppingClothes", chapter_completed: 4),
    RoleplayData(Scenariou: "Renting_car", chapter_completed: 5),
    RoleplayData(Scenariou: "Talking_with_a_classmate", chapter_completed: 0)],
  ));



  void update_data(String Scenariou, int chapter_completed){
    var filterdata= state.Roleplaydata.where((element)=>element.Scenariou == Scenariou).toList();
    filterdata[0].chapter_completed ++;
    state = state.copyWith(Roleplaydata: state.Roleplaydata);
  }

  check_chapterlength(){
    return state.Roleplaydata.length;
  }

  get_data(String Scenariou){
    final bookfilter = state.Roleplaydata.where((element)=>element.Scenariou == Scenariou).toList();
    final selectbook = bookfilter[0].chapter_completed;
    return selectbook;
  }

  update_level(String Scenariou){
    final bookfilter = state.Roleplaydata.where((element)=>element.Scenariou == Scenariou).toList();
    bookfilter[0].chapter_completed =  bookfilter[0].chapter_completed + 1;
    state =  state.copyWith(Roleplaydata: state.Roleplaydata);

  }


}