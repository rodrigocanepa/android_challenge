import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

class NavigationUtils{

  pushPage(BuildContext context, Widget page){
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 500),
            child: page
        )
    );
  }

  pushReplacementPage(BuildContext context, Widget page){
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 500),
            child: page
        )
    );
  }

  pushAndRemovePage(BuildContext context, Widget page){
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 500),
            child: page
        ),
        (route) => false
    );
  }
}