import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:topnba/src/providers/ball_dont_lie_provider.dart';

class PlayerPage extends StatelessWidget {
  final int id;
  final String imageName;
  const PlayerPage({Key key, this.id, this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha jugador'),
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
                          height: 450,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/team_logos/${imageName}.png',
                                  width: 180),
                              ListTile(
                                  title: Center(
                                      child: Text(
                                          snapshot.data['first_name'] +
                                              ' ' +
                                              snapshot.data['last_name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2))),
                              Divider(),
                              Text(
                                  'Equipo actual: ' +
                                      snapshot.data['team']['full_name'] +
                                      ' (${snapshot.data['team']['abbreviation']})',
                                  style: Theme.of(context).textTheme.headline3),
                              Text(
                                  'Conferencia: ' +
                                      snapshot.data['team']['conference'],
                                  style: Theme.of(context).textTheme.headline3),
                              Text(
                                  'Division: ' +
                                      snapshot.data['team']['division'],
                                  style: Theme.of(context).textTheme.headline3),
                              _buildData(context,
                                  snapshot.data['weight_pounds'], 'libras'),
                              _buildData(
                                  context, snapshot.data['height_feet'], 'pies')
                            ],
                          ))));
            }
          }),
    );
  }

  Future<LinkedHashMap<String, dynamic>> cargarDatos() async {
    var provider = new BallDontLieProvider();
    return await provider.getDataDetalle('players', id);
  }

  Widget _buildData(BuildContext context, int dato, String tipo) {
    if (dato == null) {
      return Text('Peso: Sin datos',
          style: Theme.of(context).textTheme.headline3);
    } else {
      return Text('Peso: ' + dato.toString() + ' ' + tipo,
          style: Theme.of(context).textTheme.headline3);
    }
  }

  Widget _progressIndicator() {
    return Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffed0933))));
  }
}
