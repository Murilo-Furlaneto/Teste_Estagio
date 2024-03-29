import 'package:flutter/material.dart';

class MoedasPage extends StatelessWidget {
  final Map<String, double> moedas;

  const MoedasPage({Key? key, required this.moedas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Moedas'),
        ),
        body: Container());
  }
}
