import 'package:audiojet/widgets/playlist_card.dart';
import 'package:audiojet/widgets/section_header.dart';
import 'package:audiojet/widgets/big_song_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audiojet/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   requestPermission();
  //   getSongs();
  // }

  // requestPermission() async {
  //   // Web platform don't support permissions methods.
  //   if (!kIsWeb) {
  //     bool permissionStatus = await _audioQuery.permissionsStatus();
  //     if (!permissionStatus) {
  //       await _audioQuery.permissionsRequest();
  //     }
  //     setState(() {});
  //   }
  // }

  // getSongs() async {
  //   allSongs =
  //       await _audioQuery.querySongs().whenComplete(() => setState(() {}));
  //   getPlayList();
  // }

  // getPlayList() async {
  //   // _audioQuery.queryAudiosFrom(AudiosFromType.PLAYLIST,Null);
  //   playList =
  //       await _audioQuery.queryPlaylists().whenComplete(() => setState(() {}));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const _CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _DiscoverMusic(),
              _TrendingMusic(songsList: allSongs),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SectionHeader(title: "Playlist", action: 'View More'),
                    PlayListCard(playList: playList)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendingMusic extends StatelessWidget {
  const _TrendingMusic({
    Key? key,
    required this.songsList,
  }) : super(key: key);

  final List<SongModel> songsList;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 2),
      child: Column(children: [
        SectionHeader(title: "Trending Music", action: "View More"),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: size.height * 0.25,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songsList.length < 8 ? songsList.length : 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // log(songsList[index].data);
                return BigSoundCard(song: songsList[index]);
              }),
        )
      ]),
    );
  }
}

//theAppBar
class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRvBRMW5ejDvxtrTRXNcO-7hQd0bN69mZpve42KBTF&s"),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

//musicSearchBar
class _DiscoverMusic extends StatelessWidget {
  const _DiscoverMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Enjoy your favorite music',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey.shade400)),
            )
          ],
        ));
  }
}
