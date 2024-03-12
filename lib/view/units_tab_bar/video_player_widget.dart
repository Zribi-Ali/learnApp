import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'lessons_list_item_template.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Container(
          height: 380, alignment: Alignment.topCenter, child: Container())
      :
      //VideoPlayerScreen(lesson: ,))
      Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(
            child: BasicOverlayWidget(
              controller: controller,
            ),
          ),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );
}

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  const BasicOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            controller.value.isPlaying ? controller.pause() : controller.play(),
        child: Stack(
          children: <Widget>[
            buildPlay(),
            Positioned(bottom: 0, left: 0, right: 0, child: buildIndicator()),
          ],
        ),
      );

  Widget buildIndicator() =>
      VideoProgressIndicator(controller, allowScrubbing: true);

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 88,
          ),
        );
}
