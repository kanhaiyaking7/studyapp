



import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Games/ErrorHunt.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final Translationprovider = FutureProvider<List>((ref) async{
  try{
    final output =await Supabase.instance.client.from('translmatch').
    select('question').
    eq('index', 1);



    // return(output as List).map((e)=>GrammarCorrection.fromJson(e)).toList();
    return (output as List)
        .map((item) => Transmatch.fromJson(item))
        .toList();


  }on SocketException{
    throw 'No internet';
  }catch(e){
    rethrow;
  }


});
class Transmatch {
  final String hindi;
  final String english;
  final String grammarHint;


 Transmatch({
 required this.hindi,
  required this.english,
  required this.grammarHint
  });

  factory Transmatch.fromJson(Map<String, dynamic> json) {
    return Transmatch(
      hindi:json['hindi'] ?? '',
      english:json['english'] ?? '',
      grammarHint: json['grammarHint'] ?? '',

    );
  }
}
