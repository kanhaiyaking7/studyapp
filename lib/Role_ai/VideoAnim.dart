

import 'package:flutter/material.dart';
import 'package:hi/Role_ai/VideoPlayerWidget.dart';
import 'package:video_player/video_player.dart';

class Videoanim extends StatefulWidget {
  final speak;
  const Videoanim({super.key, required this.speak});

  @override
  State<Videoanim> createState() => _VideoanimState();
}

class _VideoanimState extends State<Videoanim> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/speaking_girl.mp4'))
    ..setLooping(true)
      ..initialize().then((_) {
        // return _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          // _controller.play();
          _controller.setVolume(0.0);
        });

      });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // print(widget.speak);
    // print("PPPPPPPP");
    if(widget.speak == false){
      // print("ffffff");
      _controller.play();
    }
    if(widget.speak == true){
      _controller.pause();
    }
    return Container(
      height: 300,
      child: Column(
        children: [
          // Videoplayerwidget(controller:_controller),
      _controller != null && _controller.value.isInitialized
      ? Container(alignment: Alignment.topCenter,

        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child:      VideoPlayer(_controller),
          )


        )
        // AspectRatio(
        //
        //   aspectRatio: 3/5,
        //   child: VideoPlayer(_controller),
        // )

        ,) :
      Container(
      height: 200,
      child: Center(child: CircularProgressIndicator()),
    ),



          //  FloatingActionButton(
          //   onPressed: () {
          //     setState(() {
          //       print(_controller.value.isPlaying);
          //       print("ZZZZZZZZ");
          //       _controller.value.isPlaying
          //           ? _controller.pause()
          //           : _controller.play();
          //     });
          //   },
          //   child: Icon(
          //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          //   ),
          // ),
        ],
      ),
    );
      Videoplayerwidget(controller:_controller);
      // Scaffold(
      //   backgroundColor: Color(0xFF1E1E1E),
      //   body: Container(
      //     width: double.infinity,
      //     height: 185,
      //
      //     child: Column(
      //       children: [
      //         Container(
      //             decoration: BoxDecoration(
      //               color: Color(0xFF2D2D2D),
      //               borderRadius: BorderRadius.circular(10),
      //               border: Border.all(color: Color(0xFF3D3D3D)),
      //             ),
      //             child:
      //             Text("hi"),
      //
      //
      //         ),
      //
      //       ],
      //
      //     ),
      //   ),
      // );
  }
}
