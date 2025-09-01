

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final AiChat_provider = FutureProvider<List>((ref) async {

  final output =await Supabase.instance.client.from('Job_interview').select();
  print(output);

  var answer = (output as List).map((item) => LevelModel.fromJson(item)).toList();



  print("+++++++++++");
  return answer;
});


/// Model for each conversation entry


class ChapterContent {
  final String? text;
  final bool? isUser;
  final int? chat_no;
  final String?  hindi_text;




  ChapterContent({
   required this.text,
     required this.isUser,
    required this.chat_no,
    required this.hindi_text,

  });

  factory ChapterContent.fromJson(Map<String, dynamic> json) {
    return ChapterContent(
      text  : json['text'] ?? '',
      isUser: json['isUser'] ?? '',
      chat_no  : json['chat_no'] ?? '',
      hindi_text  : json['hindi_text'] ?? '',

    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'isUser':isUser,
    'chat_no':chat_no,
    'hindi_text': hindi_text,

  };
}


/// Model for Level
class LevelModel {
  final int id;
  final int levelNo;
  final List<ChapterContent> output;

  LevelModel({
    required this.id,
    required this.levelNo,
    required this.output,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'],
      levelNo: json['level_no'],
      output: (json['output'] as List)
          .map((e) => ChapterContent.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level_no': levelNo,
      'output': output.map((e) => e.toJson()).toList(),
    };
  }
}




