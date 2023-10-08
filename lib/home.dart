import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:vlc_for_mkv/full_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    this.title = 'Vlc P',
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  VlcPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VlcPlayerController.network(
        "https://www.shutterstock.com/shutterstock/videos/1104530479/preview/stock-footage-countdown-video-from-minute-to-minute-timer-countdown-second-countdown-part-of.webm",
        hwAcc: HwAcc.full,
        autoInitialize: true,
        options: VlcPlayerOptions(
            advanced:
                VlcAdvancedOptions([VlcAdvancedOptions.networkCaching(2000)])))
      ..addOnInitListener(() {
        _videoPlayerController!.startRendererScanning();
      })
      ..addListener(listener);
  }

  void listener() async {
    print(_videoPlayerController!.viewId);
    if (!mounted) return;
    if (_videoPlayerController!.value.isEnded) {
      _videoPlayerController!.stop();
      _videoPlayerController!.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    VlcPlayer(
                      aspectRatio: 16 / 9,
                      controller: _videoPlayerController!,
                    ),
                    IconButton(
                        onPressed: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => FullScreen(
                                    child: _videoPlayerController!,
                                  ))));
                        },
                        icon: const Icon(Icons.fullscreen_sharp))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }
}
