

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/Aichat_provider/Aichat_provider.dart';
import 'package:hi/Providers/Aichat_provider/RolePlayinfo.dart';
import 'package:hi/Role_ai/Aivirtual.dart';
import 'package:hi/Role_ai/CompleteRoleUI.dart';
import 'package:hi/utils/Loadinggame.dart';

class blanket extends ConsumerStatefulWidget {
  final String Id;
  final String title;
  const blanket({super.key, required this.Id, required this.title});

  @override
  ConsumerState<blanket> createState() => _blanketState();
}

class _blanketState extends ConsumerState<blanket> {

 late final curentlevel = ref.read(RoleplayProvider.notifier).get_data(widget.Id);

  late final Levelinfo =LevelDatainfo(name:widget.Id, level: curentlevel) ;
  late final resultcominfo = ResultDataInfo(title:widget.title,
      id: widget.Id);



  @override
  Widget build(BuildContext context) {
    print(Levelinfo.name);


    final AiConversation = ref.watch(AiChat_provider(Levelinfo));

    return Scaffold(

      body: AiConversation.when(
        data:(chat) {
            final message = chat[0].output;


          return    AIVirtual(result: message, resultinfo:resultcominfo);


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

