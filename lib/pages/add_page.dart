import 'package:firebase_ejemplo/categoria_selector_widget.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String categoria;
  double value = 4500.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Categorías",
          style: TextStyle(
            color: Colors.grey
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        _categoriaSelector(),
        _valorActual(),
        _numPad(),
        _submit()
      ],
    );
  }
  
  Widget _categoriaSelector() {
    return Container(
      height: 80.0,
      child: CategoriaSelectorWidget(
        categorias: {
          "Compras": Icons.shopping_cart,
          "Transporte": Icons.local_car_wash,
          "Ocio": Icons.sentiment_very_satisfied,
        },
        onValueChanged: (nuevaCategoria) => categoria = nuevaCategoria,
      ),
    );
  }

  Widget _valorActual() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Text("\$${value.toStringAsFixed(2)}",
        style: TextStyle(
          fontSize: 50.0,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }

  Widget _numPad() {
    return Expanded(
      child: Table(
        border: TableBorder.all(
          color: Colors.grey,
          width: 1.0
        ),
        children: [
          TableRow(
            children: [
              Text("1"),
              Text("2"),
              Text("3"),
            ],
          ),
          TableRow(
            children: [
              Text("4"),
              Text("5"),
              Text("6"),
            ],
          ),
          TableRow(
            children: [
              Text("7"),
              Text("8"),
              Text("9"),
            ],
          ),
          TableRow(
            children: [
              Text(","),
              Text("0"),
              Icon(Icons.backspace),
            ],
          ),
        ],
      ),
    );
  }

  Widget _submit() => Placeholder(fallbackHeight: 50);
}