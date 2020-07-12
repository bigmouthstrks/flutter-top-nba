import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topnba/src/providers/laravel_provider.dart';

class MatchPage extends StatelessWidget {
  final int id;

  const MatchPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle Partido')),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.edit),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {},
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      width: 200,
                      height: 150,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                              title: Center(
                                  child: Text(
                                      'Visita: ${snapshot.data[id]['equipo_visitante']}'))),
                          ListTile(
                              title: Center(
                                  child: Text(
                                      'Local: ${snapshot.data[id]['equipo_local']}')))
                        ],
                      ),
                    )),
              );
            }
          }),
    );
  }

  Future<List<dynamic>> cargarDatos() async {
    var provider = new LaravelProvider();
    return await provider.getPartidos();
  }

  Widget _progressIndicator() {
    return Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffed0933))));
  }
}
