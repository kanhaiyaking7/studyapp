

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Animat extends StatefulWidget {
  const Animat({super.key});

  @override
  State<Animat> createState() => _AnimatState();
}

class _AnimatState extends State<Animat> with
    SingleTickerProviderStateMixin{

  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    _controller = AnimationController(vsync: this,
        duration: Duration(seconds: 3)
        );
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
    return
      Scaffold(
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
                  // "assets/animation/animation.json",
                  "https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/animation%20(1).json",

                  // repeat: true,
                  // reverse: true,
                  // "https://lottie.host/2f11f20c-67d9-4204-9f2b-8572a386d382/pBy67bkmnH.lottie",
                  // "https://fonts.gstatic.com/s/e/notoemoji/latest/1fa99/lottie.json",
                  width: 450,
                    height: 150,
                  controller: _controller,


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
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    print("@");
                    _controller.stop();
                  },
                  child:
                  Text("forward",style: TextStyle(color: Colors.white),),),
                GestureDetector(
                  onTap: (){
                    print("VBBU");
                    _controller.forward();
                  },
                  child:
                  Text("stop",style: TextStyle(color: Colors.white),),
                )

              ],
            )


          ],

        ),
      ),
    );
  }
}

