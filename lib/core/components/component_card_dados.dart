import 'package:flutter/material.dart';

class ComponentCardDados extends StatefulWidget {
  final String titulo;
  final Widget child;

  const ComponentCardDados({
    Key? key,
    required this.titulo,
    required this.child,
  }) : super(key: key);

  @override
  State<ComponentCardDados> createState() => _ComponentCardDadosState();
}

class _ComponentCardDadosState extends State<ComponentCardDados> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 0.75))
                ],
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            width: MediaQuery.of(context).size.width * 0.95,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.titulo,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: widget.child,
          )
        ],
      ),
    );
  }
}
