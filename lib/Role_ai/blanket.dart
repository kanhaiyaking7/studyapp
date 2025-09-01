

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/Aichat_provider/Aichat_provider.dart';
import 'package:hi/Role_ai/Aivirtual.dart';

class blanket extends ConsumerStatefulWidget {
  const blanket({super.key});

  @override
  ConsumerState<blanket> createState() => _blanketState();
}

class _blanketState extends ConsumerState<blanket> {
  @override
  Widget build(BuildContext context) {
    final AiConversation = ref.watch(AiChat_provider);
    return Scaffold(

      body: AiConversation.when(
        data:(chat) {
            final message = chat[0].output;
          return AIVirtual(result: message);
        },
      error: (e,stack)=>Container(
        child: Center(
          child:  Text('__$e'),
        ),
      ),
    loading: ()=>CircularProgressIndicator()
    ) ,
    );


  }
}
