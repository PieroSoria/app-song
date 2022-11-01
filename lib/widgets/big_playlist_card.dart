import 'package:audiojet/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BigPlayListCard extends StatelessWidget {
  const BigPlayListCard({
    Key? key,
    required this.name,
    required this.noOfSongs,
    required this.id,
  }) : super(key: key);

  final String name;
  final String noOfSongs;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Get.toNamed('/playlist', arguments: id);
          },
          child: SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: QueryArtworkWidget(
                id: id,
                type: ArtworkType.PLAYLIST,
                nullArtworkWidget: Image.asset(
                  getRandomImage(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
      Text(
        name,
        overflow: TextOverflow.fade,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      Text(
        noOfSongs,
        overflow: TextOverflow.fade,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
            ),
      ),
    ]);
  }
}
