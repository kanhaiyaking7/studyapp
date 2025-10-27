

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Games/Errorplay.dart';
import 'package:hi/Providers/Games/ErrorHunt/ErrorHuntProvider.dart';
import 'package:hi/features/universal/internetcheck.dart';
import 'package:hi/utils/Loadinggame.dart';

class Homeerrorhunt extends ConsumerStatefulWidget{
  const Homeerrorhunt({super.key});

  @override
  ConsumerState<Homeerrorhunt> createState() => _HomeerrorhuntState();
}

class _HomeerrorhuntState extends ConsumerState<Homeerrorhunt> {



  @override
  Widget build(BuildContext context) {
    final GrammerHun = ref.watch(ErrorHuntProvider);

    late var checkinternete =  ref.read(checkinternet.notifier);
    checkinternete.checkinter();


    return Scaffold(
      body: GrammerHun.when(
          data: (output){
            final result = output[0].question;
            return Errorplay(result : result);
          },
          error: (e,stack)=>Container(
            child: Center(
              child:  Text('__$e'),
            ),
          ),
          loading: ()=>Loadinggame()
      ),
    );
  }
}

