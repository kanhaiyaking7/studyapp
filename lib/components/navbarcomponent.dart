

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class navbar extends StatefulWidget {
  final int progress;
  const navbar({super.key, required this.progress});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  @override
  Widget build(BuildContext context) {

    double progressvalue = widget.progress / 100;
    return Scaffold(
      backgroundColor: Colors.black,

      body: Container(
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            // decoration: BoxDecoration(
            //   color: Colors.white.withOpacity(0.2),
            //   borderRadius: BorderRadius.circular(20),
            // ),
            child:  IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
              Icons.close_sharp,
              color: Colors.white,
              size: 27,
            ),
          ),
          ),
          Container(
            child:
            new LinearPercentIndicator(
              width: 250.0,
              lineHeight: 8.0,
              percent: progressvalue,
              backgroundColor: Colors.white,
              progressColor: Colors.blue,
              barRadius: Radius.circular(10.0),
              // animation: true,
              // animationDuration: 1000,
              curve: Curves.easeInOut,
              // animateFromLastPercent: true,


            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.grid_view,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),),
    );
  }
}
