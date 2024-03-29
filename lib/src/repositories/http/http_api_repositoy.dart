import 'dart:convert';
import 'package:moedas/src/models/moedas_models.dart';
import 'package:moedas/src/repositories/api_repository.dart';
import 'package:http/http.dart' as http;

class HttpApiRepository implements ApiRepository {
  @override
  Future<List<MoedasModels>> getMoedas() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.frankfurter.app/latest'));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        final Map<String, dynamic> data = json.decode(response.body);
        final List<MoedasModels> moedas = [];

        // Iterating over the rates map and creating MoedasModels objects
        data['rates'].forEach((currency, rate) {
          final moedaModel = MoedasModels(
            currency: currency,
            rate: rate.toDouble(),
          );
          moedas.add(moedaModel);
        });

        return moedas;
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      print(e);
      throw Exception('Unexpected error occurred');
    }
  }
}
