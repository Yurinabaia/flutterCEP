import 'package:cep/block/cep_block.dart';
import 'package:cep/model/cepUsuario.dart';
import 'package:cep/widGet/textCep.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cepController = TextEditingController();
  int contador = 0;
  Future<CepUsuario> cepUsuario;
  CepBlock cepBlock = CepBlock();
  bool carregando = false;
  @override
  void initState() {
    super.initState();
    //cepUsuario = CepServices.getCep("30518020");
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
        child: Column(
          children: <Widget>[
            Container(
                child: Icon(Icons.not_listed_location,
                    size: 150.0, color: Colors.blue)),
            Container(
              width: 300,
              child: TextCep("Cep", _cepController, cepBlock ),
            ),
            /*
            Container(
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      carregando = true;
                    });
                    await cepBlock.getCep(_cepController.text);
                    setState(() {
                      carregando = false;
                    });
                  },
                  child: !carregando
                      ? Text("Carregar")
                      : CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                        ),
            ),*/
            StreamBuilder<CepUsuario>(
              stream: cepBlock.streams,
              builder: (context, snapshot) {
                print(snapshot.hasError);
                if (snapshot.hasError) {
                  return Text("Erro ao carregar os dados");
                }
                if (!snapshot.hasData) {
                  return Text("Informe um cep");
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    width: 200, //pegar largura inteira
                    child: Column(
                      children: <Widget>[
                        Text(
                            "Logradouro  " + snapshot.data.logradouro.toString()),
                        Divider(),
                        Text("Bairro " + snapshot.data.bairro.toString()),
                        Divider(),
                        Text("Localidade " + snapshot.data.localidade.toString()),
                        Divider(),
                        Text("Uf " + snapshot.data.uf.toString()),
                        Divider(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
