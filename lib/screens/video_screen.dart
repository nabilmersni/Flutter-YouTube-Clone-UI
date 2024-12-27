import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/data.dart';
import 'package:youtube_clone/screens/nav_screen.dart';
import 'package:youtube_clone/widgets/video_card.dart';
import 'package:youtube_clone/widgets/video_info.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read(miniPlayerControllerProvider).state.animateToHeight(
                state: PanelState.MAX,
              ),
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomScrollView(
            controller: _scrollController,
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                          VideoInfo(video: selectedVideo),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: suggestedVideos.length,
                  (context, index) {
                    final video = suggestedVideos[index];
                    return VideoCard(
                      video: video,
                      hasPadding: true,
                      onTap: () => _scrollController!.animateTo(
                        0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
