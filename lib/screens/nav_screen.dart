import 'package:flutter/material.dart';
// ignore: deprecated_member_use
import 'package:flutter_riverpod/all.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/data.dart';
import 'package:youtube_clone/screens/home_screen.dart';

final selectedVideoProvider = StateProvider<Video?>((ref) => null);
final miniPlayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
        (ref) => MiniplayerController());

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  static const double _playerMinHeight = 60.0;
  int _selectedIndex = 0;
  final _screens = [
    const HomeScreen(),
    const Scaffold(
      body: Center(
        child: Text("Explore"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Add"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Subscription"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Library"),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final selectedVideo = watch(selectedVideoProvider).state;
          final miniPlayerController =
              watch(miniPlayerControllerProvider).state;
          return Stack(
            children: _screens
                .asMap()
                .map(
                  (index, screen) => MapEntry(
                    index,
                    Offstage(
                      offstage: _selectedIndex != index,
                      child: screen,
                    ),
                  ),
                )
                .values
                .toList()
              ..add(
                Offstage(
                  offstage: selectedVideo == null,
                  child: Miniplayer(
                    controller: miniPlayerController,
                    minHeight: _playerMinHeight,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      if (selectedVideo == null) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    selectedVideo.thumbnailUrl,
                                    width: 120,
                                    height: _playerMinHeight - 4,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            selectedVideo.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontSize: 14,
                                                ),
                                          ),
                                          Text(
                                            selectedVideo.author.username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.play_arrow),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read(selectedVideoProvider)
                                          .state = null;
                                    },
                                    icon: const Icon(Icons.close),
                                  )
                                ],
                              ),
                              const LinearProgressIndicator(
                                value: 0.4,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              )
                            ],
                          ));
                    },
                  ),
                ),
              ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white38,
            ),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
              color: Colors.white38,
            ),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.white38,
            ),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.subscriptions_outlined,
              color: Colors.white38,
            ),
            activeIcon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_library_outlined,
              color: Colors.white38,
            ),
            activeIcon: Icon(Icons.video_library),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
