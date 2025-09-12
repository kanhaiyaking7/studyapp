

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:hi/Providers/path_provier/data_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final All_path_data = FutureProvider.family<dynamic,int>((ref,value) async{

    try{
      final output =await Supabase.instance.client.
      from('path_data').
      select().eq('Level', value+1);

      final result = output[0]['data'];
      final moreresult = jsonDecode(result);


      return moreresult;

    }
    catch(e){
      print("erroe+++++++++");
      print(e);

    }




});

// class All_path_data{
//   final supabse = Supabase.instance.client;
//
//     get_data(value) async {
//
//      try{
//
//        final output =await supabse.from('path_data').select().eq('Level', value+1);
//        final result = output[0]['data'];
//        final moreresult = jsonDecode(result);
//
//
//        return moreresult;
//
//      }
//      catch(e){
//        print("erroe+++++++++");
//        print(e);
//
//      }
//
//    }
//
//
// }