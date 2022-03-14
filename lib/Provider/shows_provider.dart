import 'package:android_challenge/Models/show_model.dart';
import 'package:android_challenge/Services/http_services.dart';
import 'package:android_challenge/Utils/constants.dart';
import 'package:flutter/material.dart';

class ShowsProvider extends ChangeNotifier{

  List<ShowModel> showsList = [];
  bool loading = true;
  bool firstLoad = false;
  String error = "";

  fetchShows() async{
    error = "";
    loading = true;
    //notifyListeners();
    Map<String, dynamic> response = await HttpServices().getData(BASE_URL + ENDPOINT_ALL_SHOWS);
    loading = false;
    firstLoad = true;
    if(response['status'] == 200){
      try{
        showsList = (response['body'] as List).map((i) => ShowModel.fromJson(i.cast<String, dynamic>())).toList();
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
}