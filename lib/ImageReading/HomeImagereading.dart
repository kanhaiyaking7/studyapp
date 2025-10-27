
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/ImageReading/ImageReadingHome.dart';
import 'package:hi/ImageReading/Seeimage.dart';
import 'package:hi/Providers/ImageReading/imageread.dart';
import 'package:hi/utils/Loadinggame.dart';

class Homeimagereading extends ConsumerStatefulWidget {
  // final String Id;
  // final String title;
  const Homeimagereading({super.key});

  @override
  ConsumerState<Homeimagereading> createState() => _HomeimagereadingState();
}

class _HomeimagereadingState extends ConsumerState<Homeimagereading> {

  // late final Levelinfo =LevelDatainfo(name:widget.Id, level: curentlevel) ;
  late final Levelinfo =LevelDatainfo(name: "AnimalSpeak", level: 9) ;

  @override
  Widget build(BuildContext context) {
    final Imageabout = ref.watch(ImageReading(Levelinfo));

    return Scaffold(

      body: Imageabout.when(
          data:(chat) {
            var data = chat[0].question;
            return    SeeImage(data:data);

          },
          error: (e,stack)=>Container(
            child: Center(
              child:  Text('__$e'),
            ),
          ),
          loading: ()=>Loadinggame()
      ) ,
    );


  }
}


class LevelDatainfo {
  final String name;
  final int level;

  LevelDatainfo({required this.name, required this.level});
}

class ResultDataInfo {
  final String title;
  final String id;

  ResultDataInfo({required this.title, required this.id});
}

