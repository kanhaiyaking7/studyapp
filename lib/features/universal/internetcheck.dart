

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final checkinternet  = StateNotifierProvider<StateinternetNotifier,bool>((ref){
  return StateinternetNotifier();
});


class StateinternetNotifier extends StateNotifier<bool>{
  StateinternetNotifier():super(false);

  void checkinter(){

    final Listener = InternetConnection().onStatusChange.listen( (InternetStatus status) {
      if(status == InternetStatus.connected){
        print("conneted");
        state = true;

      }else{
        print("no");
        state = false;

      }
    }
    );

  }


}