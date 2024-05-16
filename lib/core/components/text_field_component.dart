import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  final String titulo;
  final int maximoLinha;
  final TextEditingController controller;
  const TextFieldComponent(
      {super.key,
      required this.titulo,
      this.maximoLinha = 1,
      required this.controller});

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextField(
        controller: widget.controller,
        maxLines: widget.maximoLinha,
        decoration: InputDecoration(
          labelText: widget.titulo,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            // Borda do TextField
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey), // Cor da borda
          ),
        ),
      ),
    );
  }
}
