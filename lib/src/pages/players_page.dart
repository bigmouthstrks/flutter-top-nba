import 'package:flutter/material.dart';
import 'package:topnba/src/pages/player_page.dart';
import 'package:topnba/src/providers/ball_dont_lie_provider.dart';

class PlayersPage extends StatefulWidget {
  final String tipoPagina = 'players';

  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  List<dynamic> _listaJugadores = [];
  ScrollController _scrollController = new ScrollController();
  bool _isSearching = false;
  int _pageNum = 1;
  bool noQuedanDatos;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _pageNum++;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !_isSearching
              ? Text('Jugadores')
              : Container(
                  width: 400,
                  height: 45,
                  child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16.0),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorDark),
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: "Buscar jugador",
                          hintStyle: TextStyle(
                            color: Color(0xff17408b),
                            fontWeight: FontWeight.w300,
                          ),
                          hoverColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.blue))),
          centerTitle: false,
          actions: <Widget>[
            !_isSearching
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this._isSearching = true;
                      });
                    })
                : IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this._isSearching = false;
                      });
                    },
                  )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                  future: cargarDatos(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: _listaJugadores.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _listaJugadores.length) {
                            if (noQuedanDatos)
                              return _progressIndicator();
                            else
                              return Center(child: Text('No hay mas datos'));
                          } else {
                            return Column(
                              children: <Widget>[
                                Container(
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(8),
                                  child: ListTile(
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                    title: Text(snapshot.data[index]
                                            ['first_name'] +
                                        ' ' +
                                        snapshot.data[index]['last_name']),
                                    leading: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 44,
                                        minHeight: 44,
                                        maxWidth: 64,
                                        maxHeight: 64,
                                      ),
                                      child: _setTeamImage(
                                          snapshot.data[index]['team']['id']),
                                    ),
                                    subtitle: Text(snapshot.data[index]['team']
                                        ['full_name']),
                                    onTap: () => _navegarDetalle(
                                      context,
                                      'https://www.balldontlie.io/api/v1/players/${snapshot.data[index]['id']}',
                                      snapshot.data[index]['id'],
                                      _listaIamgenes[snapshot.data[index]
                                          ['team']['id']],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      );
                    } else {
                      return _progressIndicator();
                    }
                  }),
            )
          ],
        ));
  }

  void _navegarDetalle(
      BuildContext context, String url, int idPlayer, String teamImage) {
    final route = MaterialPageRoute(
        builder: (context) => PlayerPage(id: idPlayer, imageName: teamImage));
    Navigator.push(context, route);
  }

  Future<List<dynamic>> cargarDatos() async {
    var provider = new BallDontLieProvider();
    var response = await provider.getData(widget.tipoPagina, _pageNum);
    if (response['data'] != null) {
      for (var item in response['data']) {
        _listaJugadores.add(item);
      }
    }
    noQuedanDatos = response['next_page'] == null;
    return _listaJugadores;
  }

  Widget _progressIndicator() {
    return Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffed0933))));
  }

  final _listaIamgenes = {
    1: 'atlanta_hawks',
    2: 'boston_celtics',
    3: 'brooklyn_nets',
    4: 'charlotte_hornets',
    5: 'chicago_bulls',
    6: 'cleveland_cavaliers',
    7: 'dallas_mavericks',
    8: 'denver_nuggets',
    9: 'detroit_pistons',
    10: 'golden_state_warriors',
    11: 'houston_rockets',
    12: 'indiana_pacers',
    13: 'la_clippers',
    14: 'los_angeles_lakers',
    15: 'memphis_grizzlies',
    16: 'miami_heat',
    17: 'milwaukee_bucks',
    18: 'minnesota_timberwolves',
    19: 'new_orleans_pelicans',
    20: 'new_york_knicks',
    21: 'oklahoma_city_thunder',
    22: 'orlando_magic',
    23: 'philadelphia_76ers',
    24: 'phoenix_suns',
    25: 'trail_blazers',
    26: 'sacramento_kings',
    27: 'san_antonio_spurs',
    28: 'toronto_raptors',
    29: 'utah_jazz',
    30: 'washington_wizards',
  };

  Widget _setTeamImage(int id) {
    return Image.asset(
      "assets/team_logos/${_listaIamgenes[id]}.png",
      fit: BoxFit.cover,
    );
  }
}
