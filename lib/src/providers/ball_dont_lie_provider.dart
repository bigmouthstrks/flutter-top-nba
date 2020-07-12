import 'dart:convert';
import 'dart:collection';
import 'package:http/http.dart' as http;

class BallDontLieProvider {
  final urlApi = 'https://www.balldontlie.io/api/v1/';

  Future<LinkedHashMap<String, dynamic>> getData(String tipo, int page) async {
    var urlRequest = '$urlApi/$tipo/?page=$page';
    return await _getDataApi(urlRequest);
  }

  Future<LinkedHashMap<String, dynamic>> getDataDetalle(
      String tipo, int id) async {
    var urlRequest = '$urlApi/$tipo/$id';
    return await _getDataApi(urlRequest);
  }

  Future<LinkedHashMap<String, dynamic>> _getDataApi(String url) async {
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap<String, dynamic>();
    }
  }
}
