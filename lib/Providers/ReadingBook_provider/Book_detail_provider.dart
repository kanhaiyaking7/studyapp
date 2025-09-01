

import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final BooksProvider = FutureProvider<List>((ref) async{
  try{
    final output =await Supabase.instance.client.from('books').select();


    return(output as List).map((e)=>Book.fromJson(e)).toList();


  }on SocketException{
    throw 'No internet';
  }catch(e){
    rethrow;
  }


});

class Book {
  final String id;
  final String title;
  final String description;
  final double rating;
  final String category;
  final String coverUrl;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.category,
    required this.coverUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] ?? '',
      rating: (json['rating'] as num).toDouble(),
      category: json['category'] ?? '',
      coverUrl: json['cover_url'] ?? '',
    );
  }
}


//
// class Book {
//   String? id;
//   String? title;
//   String? coverUrl;
//   String? description;
//   String? category;
//   double? rating;
//
//   Book(
//       {this.id,
//         this.title,
//         this.coverUrl,
//         this.description,
//         this.category,
//         this.rating});
//
//   Book.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     coverUrl = json['cover_url'];
//     description = json['description'];
//     category = json['category'];
//     rating = json['rating'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['cover_url'] = this.coverUrl;
//     data['description'] = this.description;
//     data['category'] = this.category;
//     data['rating'] = this.rating;
//     return data;
//   }
// }


