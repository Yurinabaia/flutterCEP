import 'package:cep/block/generic_block.dart';
import 'package:cep/model/cepUsuario.dart';
import 'package:cep/services/cep_service.dart';

class CepBlock extends GenericBlock<CepUsuario> {
  getCep(cep) async {
    try {
      CepUsuario cepResponse = await CepServices.getCep(cep);
      add(cepResponse);
    } catch (erro) {
      throw Exception("Erro no block");
    }
  }

  get streams => stream;
}
