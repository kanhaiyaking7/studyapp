

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final champions = FutureProvider<List>((ref) async {

  try{
    final output =await Supabase.instance.client.from('champions').select();



     final result =  (output as List).map((e)=>Person.fromJson(e)).toList();


    return result;


  }on SocketException{
    throw 'No internet';
  }catch(e){
    rethrow;
  }


});

class Person {
  final int id;
  final String name;
  final int streak;
  final int xp;
  final int position;
  final String avatar;

  Person({
    required this.id,
    required this.name,
    required this.streak,
    required this.xp,
    required this.position,
    required this.avatar,

  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as int,
      name: json['name'] as String,
      streak: json['streak'] as int,
      xp: json['xp'] as int ,
      position: json['postion'] as int,
      avatar: json['avatar'] ?? '',

    );
  }
}