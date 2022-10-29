import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BigSoundCard extends StatelessWidget {
  const BigSoundCard({
    Key? key,
    required this.song,
  }) : super(key: key);

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Get.toNamed('/song', arguments: song);
            },
            child: SizedBox(
              width: size.width * 0.50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: QueryArtworkWidget(
                  id: song.id,
                  type: ArtworkType.ALBUM,
                  nullArtworkWidget: Image.network(
                    'https://i1.sndcdn.com/artworks-hADAxnACXWoAx6Og-YihIxg-t500x500.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15)),
            width: size.width * 0.37,
            margin: const EdgeInsets.only(bottom: 10),
            height: 90,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    song.displayName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   song.duration.toString(),
                  //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  //       color: Colors.black, fontWeight: FontWeight.bold),
                  // )
                ],
              ),
            )),
      ]),
    );
  }
}
