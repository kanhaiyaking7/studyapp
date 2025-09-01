



import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Games/ErrorHunt.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final ErrorHuntProvider = FutureProvider<List>((ref) async{
  try{
    final output =await Supabase.instance.client.from('Grammer_hunt').
    select('question').
    eq('index', 1);

   print(output);





    // return(output as List).map((e)=>GrammarCorrection.fromJson(e)).toList();
    return (output as List)
        .map((item) => GrammarHunt.fromJson(item))
        .toList();


  }on SocketException{
    throw 'No internet';
  }catch(e){
    rethrow;
  }


});
class GrammarQuestion {
  final List<String> words;
  final String sentence;
  final String correction;
  final int errorIndex;
  final String hindiMean;
  final String explanation;

  GrammarQuestion({
    required this.words,
    required this.sentence,
    required this.correction,
    required this.errorIndex,
    required this.hindiMean,
    required this.explanation,
  });

  factory GrammarQuestion.fromJson(Map<String, dynamic> json) {
    return GrammarQuestion(
      words: List<String>.from(json['words'] ?? []),
      sentence: json['sentence'] ?? '',
      correction: json['correction'] ?? '',
      errorIndex: json['errorIndex'] ?? 0,
      hindiMean: json['hindi_mean'] ?? '',
      explanation: json['explanation'] ?? '',
    );
  }
}

class GrammarHunt {
  final List<GrammarQuestion> question;

  GrammarHunt({required this.question});

  factory GrammarHunt.fromJson(Map<String, dynamic> json) {
    final List qList = json['question'] ?? [];
    return GrammarHunt(
      question: qList.map((e) => GrammarQuestion.fromJson(e)).toList(),
    );
  }
}
