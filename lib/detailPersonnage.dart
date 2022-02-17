import 'package:apimorty/model/personnage.dart';
import 'package:apimorty/model/resultat.dart';
import 'package:flutter/material.dart';

class detailPersonnage extends StatefulWidget{
  Resultat personnage;
  detailPersonnage({required Resultat this.personnage});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailPersonnageState();
  }

}

class detailPersonnageState extends State<detailPersonnage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.personnage.name}"),
      ),
    );
  }

}