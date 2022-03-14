import 'package:android_challenge/Models/show_model.dart';
import 'package:android_challenge/UI/Screens/detail_show_screen.dart';
import 'package:android_challenge/Utils/navigation_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ItemShow extends StatefulWidget {
  final ShowModel showModel;
  const ItemShow({Key? key, required this.showModel}) : super(key: key);

  @override
  _ItemShowState createState() => _ItemShowState();
}

class _ItemShowState extends State<ItemShow> {

  String genres = "";
  @override
  Widget build(BuildContext context) {

    genres = "";
    for(int i = 0; i < widget.showModel.genres.length; i++){
      if(i == widget.showModel.genres.length - 1){
        genres += widget.showModel.genres[i].name;
      } else{
        genres += widget.showModel.genres[i].name + ", ";
      }
    }

    return Column(
      children: [
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: (){
            NavigationUtils().pushPage(context, DetailShowScreen(showModel: widget.showModel));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            color: Colors.transparent,
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 70.0,
                      height: 110.0,
                      imageUrl: widget.showModel.image.original,
                    )
                ),
                const SizedBox(width: 15.0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: widget.showModel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '  (${DateFormat('yyyy').format(widget.showModel.premiered)})',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0
                              ),
                            )
                          ]
                        ),
                      ),
                      widget.showModel.rating.average == null ? Container() : RatingBar.builder(
                        initialRating: widget.showModel.rating.average! / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 16.0,

                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                       genres
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Divider(
          height: 0.5,
          color: Colors.grey[600],
        ),
      ],
    );
  }
}
