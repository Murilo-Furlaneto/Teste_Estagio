import 'package:moedas/src/models/moedas_models.dart';

abstract class ApiRepository {
  Future<List<MoedasModels>> getMoedas();
}
