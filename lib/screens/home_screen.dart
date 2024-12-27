import 'package:flutter/material.dart';
import 'package:youtube_clone/data.dart';
import 'package:youtube_clone/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 60),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: videos.length,
                (context, index) {
                  final video = videos[index];
                  return VideoCard(video: video);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
