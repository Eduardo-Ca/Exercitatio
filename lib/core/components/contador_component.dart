import 'package:flutter/material.dart';

class ContadorComponent extends StatefulWidget {
  final String titulo;
  final TextEditingController controller;
  final bool ehPeso;

  const ContadorComponent({
    super.key,
    required this.controller,
    required this.titulo,
    this.ehPeso = false,
  });

  @override
  State<ContadorComponent> createState() => _ContadorComponentState();
}

class _ContadorComponentState extends State<ContadorComponent> {
  void _incrementar() {
    setState(() {
      int currentValue = int.tryParse(widget.controller.text) ?? 1;
      widget.controller.text = (currentValue + 1).toString();
    });
  }

  void _decrementar() {
    setState(() {
      int currentValue = int.tryParse(widget.controller.text) ?? 1;
      if (currentValue > 1) {
        widget.controller.text = (currentValue - 1).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_left,
                size: 30,
              ),
              onPressed: _decrementar,
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange, width: 3),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  widget.ehPeso
                      ? "${widget.controller.text == "" ? "1" : widget.controller.text} KG"
                      : widget.controller.text == ""
                          ? "1"
                          : widget.controller.text,
                  style: const TextStyle(fontSize: 18, color: Colors.orange),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_right,
                size: 30,
              ),
              onPressed: _incrementar,
            ),
          ],
        ),
      ],
    );
  }
}
