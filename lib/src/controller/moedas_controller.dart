import 'package:flutter/material.dart';
import 'package:moedas/src/exceptions/exceptions.dart';
import 'package:moedas/src/models/moedas_models.dart';
import 'package:moedas/src/repositories/api_repository.dart';

class MoedasController {
  final ApiRepository apiRepository;

  MoedasController({required this.apiRepository});

  // Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state
  final ValueNotifier<List<MoedasModels>> state =
      ValueNotifier<List<MoedasModels>>([]);

  // Variável reativa para o erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  Future getMoedas() async {
    isLoading.value = true;

    try {
      final result = await apiRepository.getMoedas();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
