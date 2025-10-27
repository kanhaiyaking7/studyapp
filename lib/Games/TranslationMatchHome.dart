import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Games/Dragpoint.dart';
import 'package:hi/Providers/Games/TranslationMatch/TransMatch.dart';

class Translationmatchhome extends  ConsumerStatefulWidget{
  const Translationmatchhome({super.key});

  @override
  ConsumerState<Translationmatchhome> createState() => _TranslationmatchhomeState();
}

class _TranslationmatchhomeState extends ConsumerState<Translationmatchhome> {
  @override
  Widget build(BuildContext context) {

    final translationData = ref.watch(Translationprovider);
    return Scaffold(
      body: translationData.when(
          data:  (query){
            final output = query[0].question;
            return TranslationMatchScreen( output : output);
          },
          error: (e,stack)=>Text('error$e'),
          loading: ()=>CircularProgressIndicator()
      ),
    );
  }
}
