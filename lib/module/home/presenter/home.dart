import 'package:exercitatio/core/components/home_exercicio_card.dart';
import 'package:exercitatio/module/treinos/data/model/treino_model.dart';
import 'package:exercitatio/module/treinos/presenter/adicionar_treino_tela.dart';
import 'package:flutter/material.dart';

import '../../../core/data/database.dart';

class HomeTela extends StatefulWidget {
  const HomeTela({super.key});

  @override
  State<HomeTela> createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {
  final List<String> dias = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  int diaSelecionado = 0;
  String diaSemana = "";
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<TreinoModel> treinos = [];

  void selectItem(int index) async {
    diaSelecionado = index;
    diaSemana = trazerDiaSemana(diaSelecionado);
    treinos = await _dbHelper.listarTreinosPorDia(diaSemana);
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    diaSemana = trazerDiaSemana(diaSelecionado);
    try {
      treinos = await _dbHelper.listarTreinosPorDia(diaSemana);
    } catch (e) {
      const snackBar = SnackBar(
        content: Text("Algo deu errado!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdicionarTreinoTela(
                        diaSemana: diaSemana,
                      )));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: _listaDiaSemana(),
            ),
            _listaExercicios()
          ],
        ),
      ),
    );
  }

  _listaDiaSemana() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dias.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              selectItem(index);
            },
            child: SizedBox(
              width: 60,
              child: Card(
                color:
                    diaSelecionado == index ? Colors.deepOrange : Colors.white,
                child: Center(
                  child: Text(
                    dias[index],
                    style: TextStyle(
                        color: diaSelecionado != index
                            ? Colors.deepOrange
                            : Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listaExercicios() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 1.4,
      child: ListView.builder(
        itemCount: treinos.length,
        itemBuilder: (BuildContext context, int index) {
          final treino = treinos[index];
          return Dismissible(
            key: Key(treino.id.toString()),
            onDismissed: (direction) {
              _dbHelper.deletarTreino(treino.id!);
            },
            background: Container(
              color: Colors.red,
              child: const Center(
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            child: HomeExercicioCard(
              peso: treino.peso,
              repeticao: treino.repeticoes,
              serie: treino.series,
              titulo: treino.titulo,
              descricao: treino.descricao,
              imagem: treino.imagem,
            ),
          );
        },
      ),
    );
  }

  String trazerDiaSemana(int diaSemanaIndex) {
    String diaSemana = '';

    switch (diaSemanaIndex) {
      case 0:
        diaSemana = 'Segunda-feira';
        break;
      case 1:
        diaSemana = 'Terça-feira';
        break;
      case 2:
        diaSemana = 'Quarta-feira';
        break;
      case 3:
        diaSemana = 'Quinta-feira';
        break;
      case 4:
        diaSemana = 'Sexta-feira';
        break;
      case 5:
        diaSemana = 'Sábado';
        break;
      case 6:
        diaSemana = 'Domingo';
        break;
      default:
        diaSemana = '';
    }

    return diaSemana;
  }
}
