import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:topnba/src/providers/ball_dont_lie_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatelessWidget {
  final int id;
  final String imageName;
  const TeamPage({Key key, this.id, this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha equipo'),
      ),
      body: FutureBuilder(
          future: cargarDatos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return _progressIndicator();
            } else {
              return Center(
                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          width: 360,
                          height: 430,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/team_logos/${imageName}.png',
                                  width: 180),
                              ListTile(
                                  title: Center(
                                      child: Text(snapshot.data['full_name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2))),
                              Divider(),
                              Text(
                                  'Conferencia: ${snapshot.data['conference']} Conference',
                                  style: Theme.of(context).textTheme.headline3),
                              Text('Division: ${snapshot.data['division']}',
                                  style: Theme.of(context).textTheme.headline3),
                              Linkify(
                                onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                  } else {
                                    throw 'Could not launch $link';
                                  }
                                },
                                text:
                                    "https://www.nba.com/teams/${snapshot.data['name'].toLowerCase()}",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                                linkStyle: TextStyle(color: Colors.red),
                              ),
                            ],
                          ))));
            }
          }),
    );
  }

  Future<LinkedHashMap<String, dynamic>> cargarDatos() async {
    var provider = new BallDontLieProvider();
    return await provider.getDataDetalle('teams', id);
  }

  Widget _progressIndicator() {
    return Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffed0933))));
  }
}
