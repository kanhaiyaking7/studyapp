

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videoplayerwidget extends StatefulWidget {
  final VideoPlayerController controller;
  const Videoplayerwidget({super.key,required this.controller});

  @override
  State<Videoplayerwidget> createState() => _VideoplayerwidgetState();
}

class _VideoplayerwidgetState extends State<Videoplayerwidget> {
  @override
  Widget build(BuildContext context) {
    return widget.controller != null &&
        widget.controller.value.isInitialized
        ? Container(alignment: Alignment.topCenter,

      child: AspectRatio(

        aspectRatio: 3/5,
        child: VideoPlayer(widget.controller),
      )

      ,) :
      Container(
      height: 200,
      child: Center(child: CircularProgressIndicator()),
    );


  }
}
