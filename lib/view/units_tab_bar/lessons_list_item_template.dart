import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart';

import '../../models/core/lesson.dart';
import '../../models/services/api_links.dart';
import '../../provider/file_provider.dart';
import '../../provider/lesson_provider.dart';
import '../../provider/video_provider.dart';
import '../../translation_utilities/languages_manager.dart';
import '../custom_used_widgets/bottom_navigation_bar.dart.dart';
import '../custom_used_widgets/file_item.dart';
import '../rating.dart';

class ListItemTemplate extends StatefulWidget {
  final Lesson lesson;

  const ListItemTemplate({required this.lesson, Key? key}) : super(key: key);

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<ListItemTemplate> {
  final asset = 'assets/video.mp4';
  int currentIndex = 0;

  // late VideoPlayerController controller;

  @override
  void initState() {
    Provider.of<VideoProvider>(context, listen: false).initializeVideos(
        Provider.of<LessonProvider>(context, listen: false).currentIdLesson!);
    Provider.of<FileProvider>(context, listen: false)
        .initializeFilesForLesson(widget.lesson.idLesson);
    super.initState();
    // controller = VideoPlayerController.asset(asset)
    //   ..addListener(() => setState(() {}))
    //   ..setLooping(true)
    //   ..initialize().then((_) => controller.play());
  }

  // @override
  // void dispose() {
  // controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final isMuted = controller.value.volume == 0;
    return Scaffold(
      body: ListView(
        children: [
          // VideoPlayerWidget(controller: controller),
          // const SizedBox(
          //   height: 10,
          // ),
          // if (controller.value.isInitialized)
          //   CircleAvatar(
          //     radius: 30,
          //     backgroundColor: Theme.of(context).colorScheme.primary,
          //     child: IconButton(
          //         onPressed: () => controller.setVolume(isMuted ? 1 : 0),
          //         icon: Icon(
          //           isMuted ? Icons.volume_mute : Icons.volume_up,
          //           color: Colors.white,
          //         )),
          //   ),
          getVideosForLesson(),
          const SizedBox(
            height: 20,
          ),
          lessonInformation(),
          SizedBox(
            height: 30,
          ),
          getLessonFiles(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: buildButtonContainer()),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBarApp(
        currentIndex: currentIndex,
      ),
    );
  }

  Padding lessonInformation() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: getCustomAlignment(),
            child: Text(
              widget.lesson.titleLesson,
              style: GoogleFonts.fahkwang(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Row(
            children: [
              Text(
                '22 دقيقة',
                style: GoogleFonts.farro(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                width: 25,
              ),
              for (var i = 0; i < 5; i++)
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 24,
                ),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Text(
            widget.lesson.descLesson,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget buildButtonContainer() {
    return Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width / 1.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Rating()));
          },
          child: Text(
            AppLocalizations.of(context)!.addReview,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ));
  }

  AlignmentGeometry getCustomAlignment() {
    if (Provider.of<LocaleProvider>(context, listen: false).locale ==
        Languages.codes[0]) {
      return Alignment.topRight;
    } else {
      return Alignment.topLeft;
    }
  }

  Widget getLessonFiles() {
    return Consumer<FileProvider>(builder: (context, provider, child) {
      if (provider.loading) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width / 5),
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      } else if (provider.files.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width / 5),
          child: Center(
              child: Text(AppLocalizations.of(context)!.noFiles,
                  style: TextStyle(fontSize: 18))),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
              children: provider.files
                  .map((e) => FileItem(
                        file: e,
                        type: Type.lesson,
                      ))
                  .toList()),
        );
      }
    });
  }

  getVideosForLesson() {
    return Consumer<VideoProvider>(builder: ((context, provider, child) {
      if (provider.loading) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width / 4),
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      } else if (provider.videos.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width / 4),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.noVideos,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        );
      } else {
        return Column(
            children: provider.videos
                .map((e) => VideoWidget(
                      video: e,
                      lesson: widget.lesson,
                    ))
                .toList());
      }
    }));
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget({Key? key, required this.video, required this.lesson})
      : super(key: key);
  final Lesson lesson;
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 250,
        child: VideoPlayerScreen(
          namevideo: video.name,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Text(
          video.name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
    ]);
  }
}
/*----------------------------------------------------------------*/

class VideoPlayerScreen extends StatefulWidget {
  final String namevideo;

  const VideoPlayerScreen({Key? key, required this.namevideo})
      : super(key: key);
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
        AssetsUrl.lessonsVideo + widget.namevideo);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<String?> GetVideosLesson(int idLesson) async {
  var headers = {'Authorization': ApiLinks.token};
  var request =
      http.Request('GET', Uri.parse('https://learn-sa.net/myApi/api/Videos/4'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return request.body;
  } else {
    print(response.reasonPhrase);
  }
}
