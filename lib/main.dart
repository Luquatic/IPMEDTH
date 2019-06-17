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
  // debugPaintSizeEnabled = true;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // statusBarColor: Colors.white, //top bar color
    // statusBarIconBrightness: Brightness.dark, //top bar icons
    systemNavigationBarColor: Colors.black, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
  ));

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        color: Theme.ApplaudioColors.lichtGroen[500],
        theme: Theme.ApplaudioThemeData,
        // home: HomePage(),
        routes: {
          '/': (BuildContext context) => IntroPage(),
          '/intro': (BuildContext context) => IntroPage(),
          '/tutorial': (BuildContext context) => TutorialPage(),
          '/home': (BuildContext context) => HomePage(),
          '/profiles': (BuildContext context) => ProfilesPage(),
          'edit': (BuildContext context) => ProfileEditPage(),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => HomePage());
        },
      ),
    );
  }
}
