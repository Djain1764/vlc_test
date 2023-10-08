import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final VlcPlayerController child;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenState();
  }
}

class _FullScreenState extends State<FullScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: VlcPlayer(
              aspectRatio: 16 / 9,
              controller: widget.child,
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              onPressed: () async {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ]);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.fullscreen_exit),
              color: Colors.cyan,
            ),
          )
        ]),
      ),
    );
  }
}
