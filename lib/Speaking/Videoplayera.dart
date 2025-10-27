
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videoplayera extends StatefulWidget {
  const Videoplayera({super.key});

  @override
  State<Videoplayera> createState() => _VideoplayeraState();
}

class _VideoplayeraState extends State<Videoplayera> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
      'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/sign/video/WhatsApp%20Video%202025-10-12%20at%201.27.54%20PM%20(1).mp4?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9jODI2OWQ3My0xNjBmLTQ2MzUtYmFlZS00OWUxNjdmM2M3YmYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJ2aWRlby9XaGF0c0FwcCBWaWRlbyAyMDI1LTEwLTEyIGF0IDEuMjcuNTQgUE0gKDEpLm1wNCIsImlhdCI6MTc2MDI5MTYwOCwiZXhwIjoxNzkxODI3NjA4fQ.tgAyXWIdbJUt8X3csRAYGIxn34I95cgFLJf9iJBc2XY'))
      ..initialize().then((_) {
        // return _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.


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
    return Scaffold(
      body:
        Container(
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


    ),
    ): Container(
    height: 200,
    child: Center(child: CircularProgressIndicator()),),
        ]
    )
    )
    );
  }
}
