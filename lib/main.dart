import 'package:android_challenge/Provider/episodes_provider.dart';
import 'package:android_challenge/Provider/shows_provider.dart';
import 'package:android_challenge/UI/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _showsProvider = ShowsProvider();
  final _episodesProvider = EpisodesProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShowsProvider>(create: (_) => _showsProvider),
        ChangeNotifierProvider<EpisodesProvider>(create: (_) => _episodesProvider),
      ],
      child: MaterialApp(
        title: 'Android Challenge',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(), // standard dark theme
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
