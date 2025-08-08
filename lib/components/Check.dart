

import 'package:flutter/material.dart';

class Cok extends StatefulWidget {
  const Cok({super.key});

  @override
  State<Cok> createState() => _CokState();
}

class _CokState extends State<Cok> {

  var count = 0;

  @override
  void initState() {
    // TODO: implement initState
    count=99;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void ok(){
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xFF6E6EE9),
    body: Center(
      child: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("hi:____$count",style: TextStyle(fontSize: 30),),
          ElevatedButton(onPressed: (){ok();}, child: Text("done",style: TextStyle(fontSize: 40),))
        ],
      )
      ),
    ),

    );
  }
}
