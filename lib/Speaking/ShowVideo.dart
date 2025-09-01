import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoFormat extends StatefulWidget {
  final person_stop;
  final  person_play;
  const VideoFormat({super.key, required this.person_play, required this.person_stop});

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
            hideControls: true,
            startAt: 05,
            // endAt: 025,
            hideThumbnail: true,
            enableCaption: false,
            controlsVisibleAtStart: false,
            disableDragSeek: false,
            useHybridComposition: true,
        ));
    // TODO: implement initState
    super.initState();

  }

@override
void dispose() {
  _controller.dispose();
  _timer.cancel();
  super.dispose();
}


  void stop(){

    print("stopppppppppppppp");
    _controller.pause();
    // _controller.value = 50 as YoutubePlayerValue;
  }

  void play(){
    print("play++++++");
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    widget.person_stop(stop);
    widget.person_play(play);
    return Scaffold(
      backgroundColor: Colors.white,
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
                    showVideoProgressIndicator: false,
                    onReady: ()=>debugPrint("also print"),
                    bottomActions: [
                      CurrentPosition(),
                    ],
                  )
                ],
              ),



              Positioned(
                bottom: 1,
                right: 16,
                top: 160,
                child: Row(
                  children: [
                    IconButton(onPressed: (){play();},
                        icon: Icon(Icons.place,size: 30,)
                    ),

                    Icon(Icons.play_arrow, color: Colors.white, size: 20),
                    const SizedBox(width: 4),
                    const Text(
                      'YouTube',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(width: 14),
                    IconButton(onPressed: (){stop();},
                        icon: Icon(Icons.stop,size: 30,)
                    )
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
