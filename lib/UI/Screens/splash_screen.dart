import 'package:android_challenge/UI/Screens/main_screen.dart';
import 'package:android_challenge/Utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // this will be used to change the page (simultation of getting info from user)
  initTimer()async{
    await Future.delayed(const Duration(seconds: 2));
    NavigationUtils().pushAndRemovePage(context, const MainScreen());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "Android Challenge",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            Text(
              "By Rodrigo Canepa",
            )
          ],
        ),
      ),
    );
  }
}
