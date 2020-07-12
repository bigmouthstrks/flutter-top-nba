import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topnba/src/pages/players_page.dart';
import 'package:topnba/src/pages/matches_page.dart';
import 'package:topnba/src/pages/teams_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _navegar(_currentIndex)),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).primaryColorLight,
            selectedItemColor: Theme.of(context).disabledColor,
            items: [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.basketballBall),
                title: Text('Equipos', style: TextStyle(fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.running),
                title: Text('Jugadores', style: TextStyle(fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.calendarAlt),
                title: Text('Partidos', style: TextStyle(fontSize: 14)),
              ),
            ],
            onTap: (index) {
              setState(() => _currentIndex = index);
            }));
  }

  Widget _navegar(int index) {
    switch (index) {
      case 0:
        return TeamsPage();
      case 1:
        return PlayersPage();
      case 2:
        return MatchesPage();
    }
  }

  Widget _setTitle(int index) {
    switch (index) {
      case 0:
        return Text('Equipos', style: Theme.of(context).textTheme.headline1);
      case 1:
        return Text('Jugadores', style: Theme.of(context).textTheme.headline1);
      case 2:
        return Text('Partidos', style: Theme.of(context).textTheme.headline1);
    }
  }
}
