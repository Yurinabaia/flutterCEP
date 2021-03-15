import 'dart:convert';
import 'package:cep/model/cepUsuario.dart';
import 'package:http/http.dart' as http;

class CepServices {
  static Future<CepUsuario> getCep(String cep) async {
    Uri url = Uri.https("viacep.com.br", "/ws/$cep/json/");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return CepUsuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falhar ao carregar API');
    }
  }
}
