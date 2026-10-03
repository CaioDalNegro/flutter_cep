import 'dart:convert';

import 'package:flutter_cep/models/cep_model.dart';
import 'package:http/http.dart' as http;

class CepException implements Exception {
  final String message;

  const CepException(this.message);

  @override
  String toString() => message;
}

class CepRepository {
  static const String _baseUrl = 'https://viacep.com.br/ws/';
  final http.Client _client;

  CepRepository({required this._client});

  Future<CepModel> consultarCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanCep.length != 8) {
      throw const CepException('CEP inválido. Deve conter 8 dígitos numéricos.');
    }

    final url = Uri.parse('$_baseUrl$cleanCep/json/');

    // Só a chamada de rede fica no try, para não engolir os erros abaixo.
    final http.Response response;
    try {
      response = await _client.get(url);
    } on Exception {
      throw const CepException('Erro de conexão. Verifique sua internet.');
    }

    if (response.statusCode != 200) {
      throw CepException('Falha ao consultar o CEP. Código de status: ${response.statusCode}');
    }

    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (jsonData.containsKey('erro')) {
      throw const CepException('CEP não encontrado.');
    }
    return CepModel.fromJson(jsonData);
  }
}
