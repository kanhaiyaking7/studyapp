import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Service/Path_data.dart';
import 'package:hi/components/Done.dart';
import 'package:hi/utils/Loadinggame.dart';

class homecomponent extends ConsumerStatefulWidget {
  final int level;
  const homecomponent({super.key, required this.level});

  @override
  ConsumerState<homecomponent> createState() => _homecomponentState();
}

class _homecomponentState extends ConsumerState<homecomponent> {
  @override
  Widget build(BuildContext context) {
final path_data = ref.watch(All_path_data(widget.level));
    return Scaffold(
      body: path_data.when(
          data: (output){

            return Pro(data:output);
          },
    error: (e,stack)=>Text('error$e'),
    loading: ()=>Loadinggame()

      )
    );
  }
}
