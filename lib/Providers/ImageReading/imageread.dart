

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final ImageReading = FutureProvider.family<List,dynamic>((ref,value) async {



  final output =await Supabase.instance.client.
  from(value.name).select('content').
  eq("level_no", value.level + 1);

  var answer = (output as List).map((item) => Imageread.fromJson(item)).toList();



  return answer;
  // return true;
});



class ImageReadmodel {
  final String Imageread;
  final List<String> content;


  ImageReadmodel({
    required this.Imageread,
    required this.content,

  });

  factory ImageReadmodel.fromJson(Map<String, dynamic> json) {
    return ImageReadmodel(
      Imageread: json['image'] ?? '',
      content: List<String>.from(json['output'] ?? []),


    );
  }
}


class Imageread {
  final List<ImageReadmodel> question;

  Imageread({required this.question});

  factory Imageread.fromJson(Map<String, dynamic> json) {
    final List qList = json['content'] ?? [];
    return Imageread(
      question: qList.map((e) => ImageReadmodel.fromJson(e)).toList(),
    );
  }
}
