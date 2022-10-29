import 'package:audiojet/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongCard extends StatelessWidget {
  SongCard({
    Key? key,
  }) : super(key: key);
  final List<SongModel> song = allSongs;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: song.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                color: Colors.deepPurple.shade800.withOpacity(0.6),
                borderRadius: BorderRadius.circular(15.0)),
            child: InkWell(
              onTap: () {
                Get.toNamed('/song', arguments: index);
              },
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    'https://i1.sndcdn.com/artworks-hADAxnACXWoAx6Og-YihIxg-t500x500.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(song[index].displayName),
                subtitle: Text('${song[index].artist}'),
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
        });
  }
}
