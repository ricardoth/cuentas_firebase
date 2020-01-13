
import 'package:firebase_ejemplo/graph_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';


class MesWidget extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> porDia;
  final Map<String, double> categorias;

  MesWidget({Key key, this.documents}) : 
    total = documents.map((doc) => doc['valor']).fold(0.0, (a,b) => a + b),
    porDia = List.generate(30, (int index) {
          return documents.where((doc) => doc['dia'] == (index + 1))
              .map((doc) => doc['valor'])
              .fold(0.0, (a, b) => a + b);
        }),

    categorias = documents.fold({}, (Map<String, double> map, document) {
      if (!map.containsKey(document['categoria'])) {
        map[document['categoria']] = 0.0;
      }

      map[document['categoria']] += document['valor']; 
      return map;
    }),
    super(key: key);

  @override
  _MesWidgetState createState() => _MesWidgetState();
}

class _MesWidgetState extends State<MesWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          _expenses(),
          _graph(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 24.0,
          ),
          _list()
        ],
      ),
    );
  }


  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text("\$${widget.total.toStringAsFixed(2)}"),
        Text("Total Gastos")
      ],
    );
  }

  Widget _graph() {
    return Container(
      height: 250.0,
      child: GraphWidget(
        data: widget.porDia
      ),
    );
  }

  Widget _item(IconData icon, String nombre, int porcentaje, double valor) {
    return ListTile(
      leading: Icon(icon, size: 32.0),
      title: Text(nombre),
      subtitle: Text("$porcentaje% de gastos", 
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Text("\$$valor", 
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w500,
            fontSize: 18.0
          ),
        )
      )
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.categorias.keys.length,
        itemBuilder: (BuildContext context, int index) {
          var key = widget.categorias.keys.elementAt(index);
          var data = widget.categorias[key];
          return _item(FontAwesomeIcons.shoppingCart, key, 100 * data ~/ widget.total, data);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          );
        },
     ),
    );
  }
}