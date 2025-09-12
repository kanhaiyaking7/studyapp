

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loadinggame extends StatefulWidget {
  const Loadinggame({super.key});

  @override
  State<Loadinggame> createState() => _LoadinggameState();
}

class _LoadinggameState extends State<Loadinggame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body:   Center(


        // height: 56,
        // alignment: Alignment.center,
        child: Container(
          width: double.infinity, // Example: Container takes full width
          height: 120,

          child:   Lottie.network('https://fonts.gstatic.com/s/e/notoemoji/latest/1f3d1/lottie.json',height: 50,width: 70),
        ),

        // decoration: const BoxDecoration(
        //   color: Color(0xFF7CB342),
        //   shape: BoxShape.circle,
        // ),
      ),
      // const SizedBox(width: 6),

    );
  }
}
