/*
  this is the main file of the app. Do not delete or rename this file. In this file the routes and maintheme are defined
*/

//libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//themes
import 'package:Applaudio/themes/applaudio.dart'
    as Theme; //package for the custom styles

//models
import 'package:scoped_model/scoped_model.dart';
import './scoped_models/main.dart';

//pages
import './pages/intro.dart';
import './pages/tutorial.dart';
import './pages/home.dart';
import './pages/profiles.dart';
import './pages/profile_edit.dart';

void main() {
  // set colors for the bottom bar/ icons
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
  ));
  // run the app
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // prevent rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScopedModel<MainModel>(
      // load the model
      model: MainModel(),
      child: MaterialApp(
        // load the theme colors
        color: Theme.ApplaudioColors.lichtGroen[500],
        theme: Theme.ApplaudioThemeData,
        // define the routes
        routes: {
          '/': (BuildContext context) => IntroPage(),
          '/intro': (BuildContext context) => IntroPage(),
          '/tutorial': (BuildContext context) => TutorialPage(),
          '/home': (BuildContext context) => HomePage(),
          '/profiles': (BuildContext context) => ProfilesPage(),
          'edit': (BuildContext context) => ProfileEditPage(),
        },
        // return to the homepage by unknown routes
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => HomePage());
        },
      ),
    );
  }
}
