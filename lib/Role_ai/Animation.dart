

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Animat extends StatefulWidget {
  const Animat({super.key});

  @override
  State<Animat> createState() => _AnimatState();
}

class _AnimatState extends State<Animat> with SingleTickerProviderStateMixin{

  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration:Duration(seconds: 2));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void stop_animae(){
    print("whhy");
    _controller.stop();
  }

  void start_anime(){
    print("ok");
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Container(
        width: double.infinity,
        height: 185,

        child: Column(
          children: [
            Container(
        decoration: BoxDecoration(
            color: Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFF3D3D3D)),
          ),
              child:
                Lottie.network(
                  "https://lottie.host/2f11f20c-67d9-4204-9f2b-8572a386d382/pBy67bkmnH.lottie",
                  width: 450,
                    height: 180,
                )
              // Lottie.asset(
              //   "assets/animation/animation.json",
              //   // repeat: true,
              //   // reverse: true,
              //     width: 450,
              //   height: 180,
              //   // width: 300,
              //   // height: 100,
              //   // width: MediaQuery.sizeOf(context).width - 30,
              //   // height: MediaQuery.sizeOf(context).height,
              //   // controller: _controller,
              //   // onLoaded: (composition){
              //   //   _controller.forward();
              //   // }
              //
              // ),

            ),
            // GestureDetector(
            //   onTap: (){
            //     start_anime;
            //   },
            //   child: FloatingActionButton(onPressed: (){
            //
            //   },child:
            //     Text("forward"),),
            // ),
            // GestureDetector(
            //   onTap: (){
            //     start_anime;
            //   },
            //   child: FloatingActionButton(onPressed: (){
            //
            //   },child:
            //   Text("stop"),),
            // )


          ],

        ),
      ),
    );
  }
}

