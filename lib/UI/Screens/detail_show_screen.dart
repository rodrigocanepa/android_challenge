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

class DetailShowScreen extends StatefulWidget {
  final ShowModel showModel;
  const DetailShowScreen({Key? key, required this.showModel}) : super(key: key);

  @override
  _DetailShowScreenState createState() => _DetailShowScreenState();
}

class _DetailShowScreenState extends State<DetailShowScreen> {

  late EpisodesProvider episodesProvider;
  List<List<EpisodeModel>> episodesBySeason = [];
  List<int> seasons = [];

  loadProvider() async{
    Provider.of<EpisodesProvider>(context, listen: false).clearProvider();
    await Provider.of<EpisodesProvider>(context, listen: false).fetchEpisodes(widget.showModel.id.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loadProvider());
  }

  @override
  Widget build(BuildContext context) {

    episodesProvider = Provider.of<EpisodesProvider>(context, listen: true);
    seasons = [];
    for(int i = 0; i < episodesProvider.episodesList.length; i++){
      if(!seasons.contains(episodesProvider.episodesList[i].season)){
        seasons.add(episodesProvider.episodesList[i].season);
      }
    }
    for(int i = 0; i < seasons.length; i++){
      if(episodesBySeason.isEmpty || episodesBySeason.length == i){
        List<EpisodeModel> episodesAux = [];
        for(int j = 0; j < episodesProvider.episodesList.length; j++){
          if(episodesProvider.episodesList[j].season == seasons[i]){
            episodesAux.add(episodesProvider.episodesList[j]);
          }
        }
        episodesBySeason.add(episodesAux);
      }
    }

    String genres = "";
    for(int i = 0; i < widget.showModel.genres.length; i++){
      if(i == widget.showModel.genres.length - 1){
        genres += widget.showModel.genres[i].name;
      } else{
        genres += widget.showModel.genres[i].name + ", ";
      }
    }

    return Scaffold(
      body: LoadingOverlay(
        isLoading: episodesProvider.loading,
        child: CustomScrollView(
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
                            image: NetworkImage(widget.showModel.image.medium),
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
                          imageUrl: widget.showModel.image.medium,
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
                          widget.showModel.name,
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
                            DateFormat('yyyy').format(widget.showModel.premiered) + " - ",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13.0
                            ),
                          ),
                          Text(
                            genres + " - ",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 13.0
                            ),
                          ),
                          Text(
                            widget.showModel.ended == null ? "Alive now" : "${widget.showModel.ended!.difference(widget.showModel.premiered).inDays} days in air",
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
                      Html(data: widget.showModel.summary),
                      const SizedBox(height: 20.0),
                      _listSeasons()
                    ],
                  ),
                ),
              ),
            )
          ],

        ),
      ),
    );
  }

  Widget _listSeasons(){
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: episodesBySeason.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) => _listEpisodes(index),
      ),
    );
  }

  Widget _listEpisodes(int ind){
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Text(
              "Season ${ind + 1}",
              style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(
            height: 170.0,
            child: ListView.builder(
              itemCount: episodesBySeason[ind].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => ItemEpisode(
                episodeModel: episodesBySeason[ind][index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
