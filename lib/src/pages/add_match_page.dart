import 'package:flutter/material.dart';
import 'package:topnba/src/providers/laravel_provider.dart';

class AddMatch extends StatefulWidget {
  AddMatch({Key key}) : super(key: key);

  @override
  _AddMatchState createState() => _AddMatchState();
}

class _AddMatchState extends State<AddMatch> {
  TextEditingController equipoVisitanteCtrl = new TextEditingController();
  TextEditingController equipoLocalCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nuevo Partido')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: equipoLocalCtrl,
                      decoration: InputDecoration(
                          labelText: 'Equipo Local: ',
                          hintText: 'Nombre del equipo que juega como local'),
                    )),
                Divider(color: Colors.white),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: equipoVisitanteCtrl,
                    decoration: InputDecoration(
                        labelText: 'Equipo Visita: ',
                        hintText: 'Nombre del equipo que juega como visitante'),
                  ),
                ),
                Divider(color: Colors.white)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () => _agregar(context),
                        child: Text('Registrar partido'))),
                Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        onPressed: () => _cancelar(context),
                        child: Text('Cancelar'))),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _agregar(BuildContext context) {
    var provider = new LaravelProvider();
    provider.agregarPartido(equipoLocalCtrl.text, equipoVisitanteCtrl.text);
    Navigator.pop(context);
  }

  void _cancelar(BuildContext context) {
    Navigator.pop(context);
  }
}
