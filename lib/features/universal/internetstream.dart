
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum networkstatus{
  offline, online
}

final internetstrem = StreamProvider<networkstatus>((ref){
// StreamSubscription subscription;
//
// subscription = Connectivity().onConnectivityChanged.listen((result){
//   if(result.contains(ConnectivityResult.none) == ConnectivityResult.none){


return Connectivity().onConnectivityChanged.map((result){
  // print(result.runtimeType);
  // print(result.first);
  // print("AAA");
  // print(ConnectivityResult.none.runtimeType);
  // print(result.first == ConnectivityResult.none);

  if(result.first == ConnectivityResult.none){
    return networkstatus.offline;
  }
  else {
    return networkstatus.online;
  }
});

// return Connectivity().onConnectivityChanged.listen((wr){
//   return true;
// });


});