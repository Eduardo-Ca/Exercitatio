import 'package:exercitatio/core/data/database.dart';
import 'package:exercitatio/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exercitatio/module/treinos/data/model/treino_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Exercitatio());

  DatabaseHelper databaseHelper = DatabaseHelper();

  test('Inserir e listar treino', () async {
    final treinoInserido = TreinoModel(
      titulo: 'Treino 1',
      descricao: 'Descrição do Treino 1',
      repeticoes: "10",
      series: "3",
      peso: "20.0",
      diaSemana: 'Segunda-feira',
      imagem: 'imagem.png',
    );

    try {
      await databaseHelper.limparBancoDeDados();

      await databaseHelper.inserirTreino(treinoInserido);

      final treinos = await databaseHelper.listarTreinos();

      expect(treinos.isNotEmpty, true);

      final treinoListado = treinos.first;
      expect(treinoListado.titulo, treinoInserido.titulo);
      expect(treinoListado.descricao, treinoInserido.descricao);
      expect(treinoListado.repeticoes, treinoInserido.repeticoes);
      expect(treinoListado.series, treinoInserido.series);
      expect(treinoListado.peso, treinoInserido.peso);
      expect(treinoListado.diaSemana, treinoInserido.diaSemana);
      expect(treinoListado.imagem, treinoInserido.imagem);
    } catch (error) {
      expect(false, true);
      fail('Erro ao interagir com o banco de dados: $error');
    }
  });

  test('apagar  treino', () async {
    try {
      List<TreinoModel> treinos = await databaseHelper.listarTreinos();

      await databaseHelper.deletarTreino(treinos[0].id!);
      treinos = await databaseHelper.listarTreinos();
      expect(treinos.isEmpty, true);
    } catch (error) {
      expect(false, true);
      fail('Erro ao interagir com o banco de dados: $error');
    }
  });
}
