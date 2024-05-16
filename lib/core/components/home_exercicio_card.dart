import 'dart:io';

import 'package:flutter/material.dart';

class HomeExercicioCard extends StatefulWidget {
  final String titulo;
  final String descricao;
  final String peso;
  final String serie;
  final String repeticao;
  final String? imagem;
  const HomeExercicioCard(
      {super.key,
      required this.titulo,
      required this.descricao,
      required this.peso,
      required this.serie,
      required this.repeticao,
      required this.imagem});

  @override
  State<HomeExercicioCard> createState() => _HomeExercicioCardState();
}

class _HomeExercicioCardState extends State<HomeExercicioCard> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpand,
          child: Card(
            child: Row(
              children: [
                widget.imagem == null || widget.imagem == ""
                    ? Container(
                        color: Colors.orange,
                        width: 80,
                        height: 100,
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4)),
                        child: Image.file(
                          File(widget.imagem ?? ""),
                          fit: BoxFit.cover,
                          width: 80,
                          height: 100,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.titulo,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 220,
                        child: Text(
                          widget.descricao,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _iconeTexto(icone: Icons.fitness_center, texto: widget.peso),
                  const SizedBox(
                    width: 10,
                  ),
                  _iconeTexto(
                      icone: Icons.restart_alt,
                      texto: "${widget.serie} / ${widget.repeticao}"),
                ],
              ),
            ),
          ),
      ],
    );
  }

  _iconeTexto({icone, texto}) {
    return Row(children: [
      Icon(icone),
      Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    ]);
  }
}
