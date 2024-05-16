import 'package:flutter/material.dart';

class BotaoComponent extends StatefulWidget {
  final double width;
  final double? fontsize;
  final String texto;
  final void Function()? funcao;
  final Color? cor;
  const BotaoComponent(
      {Key? key,
      required this.width,
      required this.texto,
      this.funcao,
      this.fontsize,
      this.cor})
      : super(key: key);

  @override
  State<BotaoComponent> createState() => _BotaoComponentState();
}

class _BotaoComponentState extends State<BotaoComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              Size(
                MediaQuery.of(context).size.width * 0.4,
                MediaQuery.of(context).size.width * 0.075,
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all(widget.cor ?? Colors.deepOrange),
          ),
          onPressed: widget.funcao,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(widget.texto,
                style: TextStyle(
                    fontSize: widget.fontsize ?? 14, color: Colors.white)),
          )),
    );
  }
}
