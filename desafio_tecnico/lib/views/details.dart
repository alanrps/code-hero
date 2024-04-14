import 'package:code_hero/models/Character.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int _counter = 0;
  late Character character;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    character = ModalRoute.of(context)!.settings.arguments as Character;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(character.thumbnailUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(character.name, style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(character.description != '' ? character.description : 'Descrição indisponível', textAlign: TextAlign.justify),
            ),
            Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              ContainerCard(
                title: 'Comics',
                value: character.comicsAmount.toString(),
              ),
              ContainerCard(
                title: 'Stories',
                value: character.seriesAmount.toString(),
              ),
              ContainerCard(
                title: 'Series',
                value: character.seriesAmount.toString(),
              ),
              // ContainerCard(
              //   title: 'Título 4',
              //   value: 'Valor 4',
              // ),
            ],
          ),
        ),
          ],
        ),
      ),
    );
  }
}

class ContainerCard extends StatelessWidget {
  final String title;
  final String value;

  ContainerCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: HexColor('#D42026'),
      // elevation: 4.0,
      // margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white),),
        subtitle: Text(value, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}