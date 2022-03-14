import 'package:android_challenge/Models/episode_model.dart';
import 'package:android_challenge/Models/show_model.dart';
import 'package:android_challenge/Services/http_services.dart';
import 'package:android_challenge/Utils/constants.dart';
import 'package:flutter/material.dart';

class EpisodesProvider extends ChangeNotifier{

  List<EpisodeModel> episodesList = [];
  bool loading = true;
  String error = "";

  fetchEpisodes(String id) async{
    error = "";
    loading = true;
    notifyListeners();
    Map<String, dynamic> response = await HttpServices().getData(BASE_URL + ENDPOINT_ALL_SHOWS + "/${id}/episodes");
    loading = false;
    if(response['status'] == 200){
      try{
        episodesList = (response['body'] as List).map((i) => EpisodeModel.fromJson(i.cast<String, dynamic>())).toList();
        notifyListeners();
      } catch(e){
        error = e.toString();
        notifyListeners();
      }
    } else{
      error = 'An error ocurrend, please try again';
      notifyListeners();
    }
  }

  clearProvider(){
    episodesList = [];
    error = "";
    loading = false;
    notifyListeners();
  }
}