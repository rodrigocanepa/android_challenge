import 'dart:ui';

import 'package:android_challenge/Models/episode_model.dart';
import 'package:android_challenge/Models/show_model.dart';
import 'package:android_challenge/Provider/episodes_provider.dart';
import 'package:android_challenge/UI/Items/item_episode.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class DetailEpisodeScreen extends StatefulWidget {
  final EpisodeModel episodeModel;
  const DetailEpisodeScreen({Key? key, required this.episodeModel}) : super(key: key);

  @override
  _DetailEpisodeScreenState createState() => _DetailEpisodeScreenState();
}

class _DetailEpisodeScreenState extends State<DetailEpisodeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            /*title: Text(
              widget.showModel.name
            ),*/
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.episodeModel.image.medium),
                          fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black38,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 160.0,
                        imageUrl: widget.episodeModel.image.medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        widget.episodeModel.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Season ${widget.episodeModel.season.toString()} - ",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13.0
                          ),
                        ),
                        Text(
                          "episode ${widget.episodeModel.number.toString()}",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13.0
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 7.0),
                      child: Text(
                        "Summary",
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Html(data: widget.episodeModel.summary),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
