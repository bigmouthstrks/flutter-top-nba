import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topnba/src/pages/add_match_page.dart';
import 'package:topnba/src/pages/match_page.dart';
import 'package:topnba/src/providers/laravel_provider.dart';

class MatchesPage extends StatefulWidget {
  MatchesPage({Key key}) : super(key: key);

  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partidos'),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.calendarPlus),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () => _addMatch(context),
      ),
      body: FutureBuilder(
          future: _cargarDatos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Dismissible(
                                key: ObjectKey(snapshot.data[index]),
                                onDismissed: (direction) {
                                  _deleteConfirm(context, snapshot.data, index);
                                },
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  color: Theme.of(context).accentColor,
                                  child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FaIcon(FontAwesomeIcons.trash,
                                              color: Colors.white),
                                          Text('Eliminar',
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      )),
                                ),
                                child: ListTile(
                                  onTap: () => _navegarDetalle(
                                      context, snapshot.data[index]['id']),
                                  leading:
                                      FaIcon(FontAwesomeIcons.basketballBall),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  title: Text(
                                      '${snapshot.data[index]['equipo_visitante']} VS ${snapshot.data[index]['equipo_local']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                ));
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: snapshot.data.length))
                ],
              );
            }
          }),
    );
  }

  Future<List<dynamic>> _cargarDatos() async {
    var provider = new LaravelProvider();
    return await provider.getPartidos();
  }

  void _addMatch(BuildContext context) {
    var route = new MaterialPageRoute(
      builder: (context) => AddMatch(),
    );
    Navigator.push(context, route).then((value) {
      setState(() {});
    });
  }

  _deleteConfirm(BuildContext context, dynamic data, int indice) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmar eliminación'),
            content: Text(
                'Por favor confirme si desea continuar con la eliminación del elemento indicado.'),
            actions: <Widget>[
              MaterialButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Eliminar'),
                  onPressed: () {
                    setState(() {
                      _borrar(indice);
                      data.removeAt(data[indice]['id']);
                    });
                  }),
            ],
          );
        });
  }

  Future<void> _borrar(int id) async {
    var provider = new LaravelProvider();
    await provider.borrarPartido(id);
  }

  void _navegarDetalle(BuildContext context, int matchId) {
    final route =
        MaterialPageRoute(builder: (context) => MatchPage(id: matchId));
    Navigator.push(context, route);
  }
}
