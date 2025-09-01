

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final BookData = FutureProvider<List>((ref) async {
  
  final output =await Supabase.instance.client.from('animal_advanture').select();

var answer = (output as List).map((item) => Chapter.fromJson(item)).toList();

print("+++++++++++");
  return answer;
      // .map((e)=>Chapter.fromJson(e)).toList();

  
});



class Chapter {
  final String id;
  final String bookId;
  final String title;
  final int orderNo;
  final List<ChapterContent> content;

  Chapter({
    required this.id,
    required this.bookId,
    required this.title,
    required this.orderNo,
    required this.content,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    final contentList = (json['content'] as List<dynamic>?)
        ?.map((e) => ChapterContent.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [];

    return Chapter(
      id: json['id'] as String,
      bookId: json['book_id'] as String,
      title: json['title'] as String,
      orderNo: json['order_no'] as int,
      content: contentList,
    );
  }
}
//
// class Chapter {
//   final String id;
//   final String bookId;
//   final String title;
//   final List<ChapterContent> content;
//   final int orderNo;
//
//   Chapter({
//     required this.id,
//     required this.bookId,
//     required this.title,
//     required this.content,
//     required this.orderNo,
//   });
//
//   factory Chapter.fromJson(Map<String, dynamic> json) {
//     var contentList = <ChapterContent>[];
//     if (json['content'] is List) {
//       contentList = (json['content'] as List)
//           .map((e) => ChapterContent.fromJson(e))
//           .toList();
//     }
//
//     return Chapter(
//       id: json['id'],
//       bookId: json['book_id'],
//       title: json['title'],
//       content: contentList,
//       orderNo: json['order_no'],
//     );
//   }
// }
//

class ChapterContent {
  final String englishText;
  final String hindiText;

  ChapterContent({
    required this.englishText,
    required this.hindiText,
  });

  factory ChapterContent.fromJson(Map<String, dynamic> json) {
    return ChapterContent(
      englishText: json['english_text'] ?? '',
      hindiText: json['hindi_text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'english_text': englishText,
    'hindi_text': hindiText,
  };
}




