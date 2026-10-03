import 'dart:convert';

import 'package:flutter_cep/models/cep_model.dart';
import 'package:http/http.dart' as http;

class CepRepository {
  static const String _baseUrl = 'https://viacep.com.br/ws/';
  final http.Client _client;

  CepRepository({required this._client});

  Future<CepModel> consultarCep(String cep) async {
    final cleanCep = cep.replaceAll(r'[^0-9]', '');

    if (cleanCep.length != 8) {
      throw Exception('CEP inválido. Deve conter 8 dígitos numéricos.');
    }

    final url = Uri.parse('$_baseUrl$cleanCep/json/');
    try {
      final response = await _client.get(url);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if(jsonData.contaisnKey('erro')){
          throw Exception('CEP não encontrado.');
        }
        return CepModel.fromJson(jsonData);
      }else {
        throw Exception('Falha ao consultar o CEP. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao consultar o CEP.');
    }
  }
}
