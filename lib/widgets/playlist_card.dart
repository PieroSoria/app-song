import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListCard extends StatelessWidget {
  const PlayListCard({
    Key? key,
    required this.playList,
  }) : super(key: key);

  final List<PlaylistModel> playList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: playList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade800.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15.0)),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/playlist');
                },
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      'https://i1.sndcdn.com/artworks-hADAxnACXWoAx6Og-YihIxg-t500x500.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Text(playList[index].playlist),
                  subtitle: Text('${playList[index].numOfSongs} songs'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
