//libraries
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:Applaudio/themes/applaudio.dart' as Theme;
import 'package:flutter/widgets.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TutorialPageState();
  }
}

class _TutorialPageState extends State<TutorialPage> {
  int _currentIndexPage;
  int _pageLength;

  @override
  void initState() {
    _currentIndexPage = 0;
    _pageLength = 3;
    super.initState();
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: Text('Handleiding'),
      ),
      body: Stack(
        children: <Widget>[
          PageView(
            children: <Widget>[
              Container(
                //__Page1__//
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'res/images/app_home.png',
                        scale: 8,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Om snel te starten hoef je alleen \nje volume in te stellen (groene balk) \n"
                            "en de knop met de microfoon in te drukken.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                //__Page2__//
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'res/images/app_profiel.png',
                        scale: 8,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Maak een profiel aan om de instellingen te bewaren. "
                            "Activeren kan in het profiel zelf, \nals je het profiel favoriet maakt \n"
                            "kan je deze gebruiken op het home scherm.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                //__Page3__//
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'res/images/app_drawer.png',
                        scale: 8,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Wil je de handleiding nog eens terug willen lezen, deze is terug te vinden in het menu.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ],
            onPageChanged: (_value) {
              setState(() => _currentIndexPage = _value);
            },
          ),
          _buildDotsDecorator(context),
        ],
      ),
    );
  }

  Widget _buildDotsDecorator(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: DotsIndicator(
          dotsCount: _pageLength,
          position: _currentIndexPage,
          decorator: DotsDecorator(
            activeColor: Theme.ApplaudioColors.lichtGroen[500],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }
}
