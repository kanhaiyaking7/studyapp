import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoFormat extends StatefulWidget {
  const VideoFormat({super.key});
  @override
  State<VideoFormat> createState() => _VideoFormatState();
}
class _VideoFormatState extends State<VideoFormat> {
  final videourl = 'https://www.youtube.com/watch?v=0k0Uc9uAJwk&t=111s';
  late YoutubePlayerController _controller;
  late Timer _timer;

  final List<int> pauseTimes = [10, 15, 22];
  final Set<int> alreadyPaused = {};

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videourl);
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: YoutubePlayerFlags(
            autoPlay:true,
            hideControls: false,
            startAt: 05,
            endAt: 025,
            hideThumbnail: true,
            enableCaption: false,
            controlsVisibleAtStart: true,
            disableDragSeek: false,
            useHybridComposition: false
        ));
    // TODO: implement initState
    super.initState();

  }

//  var  _atimer = Timer.periodic(Duration(seconds: 1), (timer) async {
//   final position = await _controller.value.position;
//   final seconds = position.inSeconds;
//
//   if (pauseTimes.contains(seconds) && !alreadyPaused.contains(seconds)) {
//   alreadyPaused.add(seconds);
//
//   _controller.pause();
//   print("Paused at $seconds seconds");
//
//   // Resume after 2 seconds
//   Future.delayed(Duration(seconds: 2), () {
//   _controller.play();
//   print("Resumed at ${_controller.value.position.inSeconds} seconds");
//   });
//   }
//   });
// }
//
// @override
// void dispose() {
//   _controller.dispose();
//   _timer.cancel();
//   super.dispose();
// }

  void stop(){
    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:   Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          color: Colors.black,
          child: Stack(
            children: [
              // Video placeholder with character
              Column(
                children: [
                  YoutubePlayer(controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: ()=>debugPrint("also print"),
                    bottomActions: [
                      CurrentPosition(),
                    ],
                  )
                ],
              ),

              Positioned(
                bottom: 16,
                right: 16,
                child: Row(
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 20),
                    const SizedBox(width: 4),
                    const Text(
                      'YouTube',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),),
    );
  }
}
