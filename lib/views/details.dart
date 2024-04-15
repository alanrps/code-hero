import 'package:code_hero/components/containerCard.dart';
import 'package:code_hero/models/Character.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Character character;
  Map<String, IconData> icons = {
    'Comics': Icons.library_books,
    'Stories': Icons.book,
    'Series': Icons.tv,
    'Events': Icons.calendar_today,
  };

  @override
  Widget build(BuildContext context) {
    character = ModalRoute.of(context)!.settings.arguments as Character;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(character.thumbnailUrl),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  character.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                    character.description != ''
                        ? character.description
                        : 'Descrição indisponível',
                    textAlign: TextAlign.justify),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ContainerCard(
                        title: 'Comics',
                        value: character.comicsAmount.toString(),
                        icon: icons['Comics'] ?? Icons.error),
                    ContainerCard(
                        title: 'Stories',
                        value: character.storiesAmount.toString(),
                        icon: icons['Stories'] ?? Icons.error),
                    ContainerCard(
                        title: 'Series',
                        value: character.seriesAmount.toString(),
                        icon: icons['Series'] ?? Icons.error),
                    ContainerCard(
                        title: 'Events',
                        value: character.eventsAmount.toString(),
                        icon: icons['Events'] ?? Icons.error),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
