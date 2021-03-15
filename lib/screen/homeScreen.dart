import 'package:cep/block/cep_block.dart';
import 'package:cep/model/cepUsuario.dart';
import 'package:flutter/material.dart';
import 'package:cep/services/cep_service.dart';

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
    cepUsuario = CepServices.getCep("30518020");
  }

  @override
  void dispose() {
    super.dispose();
    _cepController.clear();
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
        child: Row(
          children: <Widget> [
            StreamBuilder<CepUsuario>(
              stream: CepBlock().stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.not_listed_location,
                            size: 150.0, color: Colors.blue),
                        buildTextFiel("Cep", _cepController),
                        Divider(),
                        Text("Logradouro  " + snapshot.data.logradouro),
                        Divider(),
                        Text("Bairro " + snapshot.data.bairro),
                        Divider(),
                        Text("Localidade " + snapshot.data.localidade),
                        Divider(),
                        Text("Uf " + snapshot.data.uf),
                        Divider(),
                        ElevatedButton(
                            onPressed: CepBlock().getCep(_cepController.text), child: Text("Carregar"))
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
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget buildTextFiel(String Nome, TextEditingController controlar) {
  return TextField(
    controller: controlar,
    decoration: InputDecoration(
      labelText: Nome,
      labelStyle: TextStyle(color: Colors.blue),
      border: OutlineInputBorder(),
    ),
    style: TextStyle(color: Colors.blue, fontSize: 25.0),
    keyboardType: TextInputType.number,
  );
}
