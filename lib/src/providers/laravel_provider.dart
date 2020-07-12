import 'dart:convert';
import 'package:http/http.dart' as http;

class LaravelProvider {
  final apiUrl = 'http://localhost:8000/api/';

  Future<List<dynamic>> getPartidos() {
    var urlRequest = apiUrl + 'partidos';
    return _getData(urlRequest);
  }

  Future<List<dynamic>> _getData(String url) async {
    final response = await http.get(url);
    if (response.statusCode == 200)
      return json.decode(response.body);
    else
      return new List<dynamic>();
  }

  Future<http.Response> borrarPartido(int id) async {
    var urlRequest = apiUrl + 'partidos/' + id.toString();
    return await http.delete(urlRequest);
  }

  Future<http.Response> agregarPartido(
      String equipoLocal, String equipoVisitante) async {
    var urlRequest = apiUrl + 'partidos';
    var respuesta = await http.post(
      urlRequest,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'equipo_local': equipoLocal,
        'equipo_visitante': equipoVisitante
      }),
    );
    return respuesta;
  }

  Future<http.Response> editarPartido(
      int idPartido, String equipoLocal, String equipoVisitante) async {
    var urlRequest = apiUrl + 'partidos/$idPartido';
    var respuesta = await http.put(
      urlRequest,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'equipo_local': equipoLocal,
        'equipo_visitante': equipoVisitante
      }),
    );
    return respuesta;
  }
}
