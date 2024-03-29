import 'package:flutter/material.dart';
import 'package:moedas/src/controller/moedas_controller.dart';
import 'package:moedas/src/models/moedas_models.dart';
import 'package:moedas/src/repositories/http/http_api_repositoy.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MoedasController moedasController =
      MoedasController(apiRepository: HttpApiRepository());
  String? moedaBase;
  String? moedaSelecionada;
  TextEditingController valorController = TextEditingController();
  double resultado = 0.0;

  @override
  void initState() {
    super.initState();
    moedasController.getMoedas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Conversão de Moedas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<MoedasModels>>(
        valueListenable: moedasController.state,
        builder: (context, moedas, _) {
          if (moedas.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: moedaBase,
                    hint: const Text('Selecione a moeda base'),
                    items: moedas.map((MoedasModels moeda) {
                      return DropdownMenuItem<String>(
                        value: moeda.currency,
                        child: Text(moeda.currency),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        moedaBase = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: moedaSelecionada,
                    hint: const Text('Selecione a moeda de conversão'),
                    items: moedas.map((MoedasModels moeda) {
                      return DropdownMenuItem<String>(
                        value: moeda.currency,
                        child: Text(moeda.currency),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        moedaSelecionada = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: valorController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Valor a ser convertido',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      double valor =
                          double.tryParse(valorController.text) ?? 0.0;
                      if (moedaBase != null &&
                          moedaSelecionada != null &&
                          valor != 0.0) {
                        double taxaBase = moedas
                            .firstWhere((moeda) => moeda.currency == moedaBase)
                            .rate;
                        double taxaSelecionada = moedas
                            .firstWhere(
                                (moeda) => moeda.currency == moedaSelecionada)
                            .rate;
                        setState(() {
                          resultado = (valor / taxaBase) * taxaSelecionada;
                        });
                      }
                    },
                    child: const Text('Converter'),
                  ),
                  const SizedBox(height: 16.0),
                  if (resultado != 0.0)
                    Text(
                      'Resultado da Conversão: ${resultado.toStringAsFixed(2)} $moedaSelecionada',
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
