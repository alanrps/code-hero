import 'dart:convert';
import 'dart:io';

import 'package:code_hero/models/Character.dart';
import 'package:code_hero/services/marvel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class HomePage extends StatefulWidget {
  // const HomePage({super.key });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Services services = Services();
  // List<Widget> _characters = [];
  List<Character> characters = [];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<Map<String, dynamic>> carregarArquivoJson() async {
    // Carrega o arquivo JSON do diretório de ativos
    String jsonString = await rootBundle.loadString('data.json');

    // Converte a string JSON em um mapa ou lista, dependendo do formato do JSON
    var data = jsonDecode(jsonString) as Map<String, dynamic>;

    // Use os dados carregados conforme necessário
    return data;
  }

  processCharacters() async {
    // {String name = ''} name: name
    // final charactersResponse = await services.getCharacters();

    // final jsonData = jsonDecode(charactersResponse.body);
    // print('JSON DECODE: $jsonData');

    // setState(() {
    //   characters = (jsonData['data']['results'] as List)
    //       .map((character) => Character.fromJson(character))
    //       .toList();
    // });

    Map<String, dynamic> jsonData = await carregarArquivoJson();

    setState(() {
      characters = (jsonData['data']['results'] as List)
        .map((character) => Character.fromJson(character))
        .toList();
    });

    return characters;
  }

  getListData(List<Character> characters) {
    List<Widget> widgets = [];

    for (final character in characters) {
      widgets.add(ListView.builder(itemBuilder: (context, index) {
        return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(character.thumbnailUrl),
              // child: Text(character.name),
            ),
            title: Text(character.name));
      }));
    }

    print(widgets);
    // setState(() {
    //   _characters = widgets;
    // });
  }

  @override
  void initState() {
    super.initState();
    processCharacters();
  // .then((characters) => getListData(characters));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    List<String> _items =
        List.generate(20, (index) => 'Super Herói ${index + 1}');
    int _currentPage = 1;
    int _totalPages = 5;
    int _itemsPerPage = 4;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 0.8, color: HexColor('#D42026'))),
                    ),
                    child: Text('BUSCA',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#D42026'))),
                  ),
                ),
                TextSpan(
                  text: ' MARVEL ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#D42026')),
                ),
                TextSpan(
                  text: 'TESTE FRONT-END',
                  style: TextStyle(fontSize: 12, color: HexColor('#D42026')),
                ),
              ],
            ),
          )),
      body: Column(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 12, 8, 0),
              child: Text(
                'Nome do Personagem',
                textAlign: TextAlign.start,
                style:
                    TextStyle(color: HexColor('#D42026'), fontFamily: 'Roboto'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 12),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ]),
           Container(
            width: double.infinity,
            height: 35,
            color: HexColor('#D42026'),
            alignment: Alignment.center, 
            padding: EdgeInsets.only(right: 180), 
             child: Text(
              'Nome',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                color: Colors.white
              ),
                       ),
           ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
              color: HexColor('#D42026'), // cor da divisão
              thickness: 1, // espessura da divisão
              height: 1, // altura da divisão
            ),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              Character character = characters[index];

                return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(character.thumbnailUrl),
                ),
                title: Text(character.name),
              );
            },
          ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _currentPage > 1
                    ? () {
                        setState(() {
                          _currentPage--;
                        });
                      }
                    : null,
                icon: Icon(Icons.arrow_left,
                    size: 80, color: HexColor('#D42026')),
              ),
              // Text('$_currentPage de $_totalPages'),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: GestureDetector(
                      // onTap: onPressed,
                      child: Container(
                        width: 35, // Largura do círculo
                        height: 50, // Altura do círculo
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Define a forma como círculo
                          border: Border.all(
                            color: HexColor('#D42026'),
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#D42026')),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: GestureDetector(
                      // onTap: onPressed,
                      child: Container(
                        width: 35, // Largura do círculo
                        height: 50, // Altura do círculo
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Define a forma como círculo
                          border: Border.all(
                            color: HexColor('#D42026'),
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#D42026')),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    // onTap: onPressed,
                    child: Container(
                      width: 35, // Largura do círculo
                      height: 50, // Altura do círculo
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Define a forma como círculo
                        border: Border.all(
                          color: HexColor('#D42026'),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#D42026')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: _currentPage < _totalPages
                    ? () {
                        setState(() {
                          _currentPage++;
                        });
                      }
                    : null,
                icon: Icon(Icons.arrow_right,
                    size: 80, color: HexColor('#D42026')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
