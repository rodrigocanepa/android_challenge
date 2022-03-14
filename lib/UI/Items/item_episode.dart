import 'package:android_challenge/Models/episode_model.dart';
import 'package:android_challenge/UI/Screens/detail_episode_screen.dart';
import 'package:android_challenge/UI/Screens/detail_show_screen.dart';
import 'package:android_challenge/Utils/navigation_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemEpisode extends StatefulWidget {
  final EpisodeModel episodeModel;
  const ItemEpisode({Key? key, required this.episodeModel}) : super(key: key);

  @override
  _ItemEpisodeState createState() => _ItemEpisodeState();
}

class _ItemEpisodeState extends State<ItemEpisode> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigationUtils().pushPage(context, DetailEpisodeScreen(episodeModel: widget.episodeModel));
      },
      child: Container(
        width: 90.0,
        height: 170.0,
        color: Colors.transparent,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 75.0,
                  height: 90.0,
                  imageUrl: widget.episodeModel.image.medium,
                )
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.episodeModel.number.toString() + ". " + widget.episodeModel.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



}
