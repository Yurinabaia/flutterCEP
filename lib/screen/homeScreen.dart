import 'dart:convert';
import 'package:cep/screen/cepUsuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cepController = TextEditingController();
  int contador = 0;
  Future<CepUsuario> cepUsuario;
  @override
  void initState() {
    super.initState();
    cepUsuario = _cep("30518020");
  }

  @override
  void dispose() {
    super.dispose();
    _cepController.clear();
  }
  FutureBuilder<CepUsuario> _atualizar() {
      setState(() {
              cepUsuario = _cep(_cepController.text);
            });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("  CEP "),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
        body: Center(
          child: FutureBuilder<CepUsuario>(
            future: cepUsuario,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                 return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.not_listed_location , size: 150.0, color: Colors.blue),
                          buildTextFiel("Cep", _cepController),
                          Divider(),
                          Text("Logradouro  " + snapshot.data.logradouro),
                          Divider(),
                          Text("Bairro " + snapshot.data.bairro),
                          Divider(),
                          Text("Localidade "+ snapshot.data.localidade),
                          Divider(),
                          Text("Uf " +snapshot.data.uf),
                          Divider(),
                          ElevatedButton(
                            onPressed: _atualizar, 
                            child: Text("Carregar")
                            )

                        ],
                      ),
                    );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget buildTextFiel(String Nome, TextEditingController controlar)
{
  return TextField(
      controller: controlar,
      decoration: InputDecoration(
          labelText: Nome,
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(),
      ),
      style: TextStyle(
          color: Colors.blue, fontSize: 25.0
      ),
      keyboardType: TextInputType.number,
  );
}



Future<CepUsuario> _cep(String cep) async {

  Uri url = Uri.https("viacep.com.br", "/ws/"+ cep + "/json/");

  final response = await http.get(url);
 
  if (response.statusCode == 200) {
    return CepUsuario.fromJson(jsonDecode(response.body));
  }else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

