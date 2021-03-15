
import 'package:flutter/cupertino.dart';

class CepUsuario {
  final String cep;
  final String logradouro;
  final String bairro;
  final String localidade;
  final String uf;

  CepUsuario({ this.cep,  this.logradouro, this.bairro, this.localidade,  this.uf});

  factory CepUsuario.fromJson(Map<String, dynamic> json) {
    return CepUsuario(
      cep: json['cep'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
    );
  }

}