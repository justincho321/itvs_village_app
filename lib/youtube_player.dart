import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//void main() => runApp(const YoutubePlayerPage());

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({Key? key}) : super(key: key);

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    const url = 'https://www.youtube.com/watch?v=lGrXraps03U';

    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        loop: false,
        autoPlay: true,
      ),
    );
  }

  @override
  void deactivate() {
    controller.pause();

    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(title: const Text('Youtube Player')),
            body: ListView(
              children: [
                player,
              ],
            ),
          );
        });
  }
}
