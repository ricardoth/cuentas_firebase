import 'package:flutter/material.dart';

class CategoriaSelectorWidget extends StatefulWidget {
  final Map<String, IconData> categorias;
  final Function(String) onValueChanged;

  const CategoriaSelectorWidget({Key key, this.categorias, this.onValueChanged}) : super(key: key);

  @override
  _CategoriaSelectorWidgetState createState() => _CategoriaSelectorWidgetState();
}

class CategoryWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool selected;  

  const CategoryWidget({Key key, this.name, this.icon, this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                color: selected ? Colors.blueAccent : Colors.grey,
                width: selected ? 3.0 : 1.0
              ),
            ),
            child: Icon(icon),
          ),
          Text(name)
        ],
      ),
    );
   
  }
}

class _CategoriaSelectorWidgetState extends State<CategoriaSelectorWidget> {
  String currentItem = "";

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
      widget.categorias.forEach((name, icon) {
        widgets.add(GestureDetector(
          onTap: () {
            setState(() {
              currentItem = name;
            });
            widget.onValueChanged(name);
          },
          child: CategoryWidget(
            name: name,
            icon: icon,
            selected: name == currentItem,
          ),
        ),
      );
    });

    return ListView(
      scrollDirection: Axis.horizontal,
      children: widgets
    );
  }
}