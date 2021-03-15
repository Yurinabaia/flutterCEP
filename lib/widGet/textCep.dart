import 'package:flutter/material.dart';
import 'package:cep/block/cep_block.dart';
class TextCep extends StatelessWidget {
  CepBlock cepBlock;
  String _nome;
  TextEditingController _controlar;
  TextCep(this._nome, this._controlar, this.cepBlock);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controlar,
      onChanged: (val) async{
        await cepBlock.getCep(val);
      },
      decoration: InputDecoration(
        labelText: _nome,
        labelStyle: TextStyle(color: Colors.blue),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
      keyboardType: TextInputType.number,
    );
  }
}
