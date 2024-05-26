import 'package:exercitatio/core/components/botao_component.dart';
import 'package:exercitatio/core/components/component_card_dados.dart';
import 'package:exercitatio/core/components/contador_component.dart';
import 'package:exercitatio/core/constants/mensagens_constantes.dart';
import 'package:exercitatio/module/treinos/data/model/treino_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/text_field_component.dart';
import '../../../core/data/database.dart';

class AdicionarTreinoTela extends StatefulWidget {
  final String diaSemana;
  final bool edicao;
  final TreinoModel? treino;
  const AdicionarTreinoTela({
    super.key,
    required this.diaSemana,
    this.edicao = false,
    this.treino,
  });

  @override
  State<AdicionarTreinoTela> createState() => _AdicionarTreinoTelaState();
}

class _AdicionarTreinoTelaState extends State<AdicionarTreinoTela> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController repeticoesController = TextEditingController();
  TextEditingController seriesController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  final picker = ImagePicker();
  String controllerImage = "";

  pegarImagemGaleria() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path;
    } else {}
  }

  @override
  void didChangeDependencies() {
    if (widget.treino != null) {
      tituloController.text = widget.treino?.titulo ?? "";
      descricaoController.text = widget.treino?.descricao ?? "";
      repeticoesController.text = widget.treino?.repeticoes ?? "";
      seriesController.text = widget.treino?.series ?? "";
      pesoController.text = widget.treino?.peso ?? "";
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MensagensConstantes.ADICIONAR_TREINO),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ComponentCardDados(
                  titulo: widget.diaSemana,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            controllerImage = await pegarImagemGaleria();

                            setState(() {});
                          },
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(
                                  20), // Borda arredondada
                            ),
                            child: controllerImage == ""
                                ? const Center(
                                    child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 35,
                                  ))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(controllerImage),
                                      fit: BoxFit.cover,
                                      width: 160,
                                      height: 160,
                                    ),
                                  ),
                          ),
                        ),
                        TextFieldComponent(
                          controller: tituloController,
                          titulo: 'Título',
                        ),
                        TextFieldComponent(
                          controller: descricaoController,
                          maximoLinha: 3,
                          titulo: 'Descrição',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ContadorComponent(
                                controller: seriesController,
                                titulo: "Séries:",
                              ),
                              ContadorComponent(
                                titulo: "Repetições:",
                                controller: repeticoesController,
                              ),
                            ],
                          ),
                        ),
                        ContadorComponent(
                          ehPeso: true,
                          controller: pesoController,
                          titulo: "Peso:",
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BotaoComponent(
                  width: MediaQuery.of(context).size.width,
                  texto: "Salvar treino",
                  funcao: () {
                    TreinoModel treino = TreinoModel(
                        id: widget.treino?.id,
                        titulo: tituloController.text,
                        descricao: descricaoController.text,
                        repeticoes: repeticoesController.text == ""
                            ? "1"
                            : repeticoesController.text,
                        series: seriesController.text == ""
                            ? "1"
                            : seriesController.text,
                        peso: pesoController.text == ""
                            ? "1"
                            : pesoController.text,
                        diaSemana: widget.diaSemana,
                        imagem: controllerImage);
                    try {
                      widget.edicao
                          ? _dbHelper.atualizarTreino(treino)
                          : _dbHelper.inserirTreino(treino);
                      Navigator.pop(context);
                    } catch (e) {
                      const snackBar = SnackBar(
                        content: Text("Algo deu errado!"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
