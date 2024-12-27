import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/screens/nav_screen.dart';
import 'package:youtube_clone/widgets/video_info.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Consumer(
                builder: (context, watch, child) {
                  final selectedVideo = watch(selectedVideoProvider).state;
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              selectedVideo!.thumbnailUrl,
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              child: IconButton(
                                iconSize: 30,
                                color: Colors.white,
                                onPressed: () {
                                  context
                                      .read(miniPlayerControllerProvider)
                                      .state
                                      .animateToHeight(state: PanelState.MIN);
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                              ),
                            )
                          ],
                        ),
                        const LinearProgressIndicator(
                          value: 0.4,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                        VideoInfo(video: selectedVideo),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
