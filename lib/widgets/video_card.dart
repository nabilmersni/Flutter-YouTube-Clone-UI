import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/data.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/screens/nav_screen.dart';

class VideoCard extends StatelessWidget {
  final Video video;
  const VideoCard({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read(selectedVideoProvider).state = video;
        context.read(miniPlayerControllerProvider).state.animateToHeight(
              state: PanelState.MAX,
            );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                video.thumbnailUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                  ),
                  child: Text(
                    video.duration,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(video.author.profileImageUrl),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 15,
                            ),
                      ),
                      Text(
                        "${video.author.username} . ${video.viewCount} views . ${timeago.format(video.timestamp)}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.more_vert),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
