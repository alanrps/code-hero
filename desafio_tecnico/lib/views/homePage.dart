import 'dart:convert';
import 'dart:io';

import 'package:code_hero/models/Character.dart';
import 'package:code_hero/services/marvel.dart';
import 'package:flutter/material.dart';
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
  List<int> indexPages = [1, 2, 3];
  int currentPage = 1;
  int totalPages = 3;
  int itemsPerPage = 4;
  Services services = Services();
  // List<Widget> _characters = [];
  List<Character> characters = [];

  Future<Map<String, dynamic>> carregarArquivoJson() async {
    // Carrega o arquivo JSON do diretório de ativos
    String jsonString = await rootBundle.loadString('data.json');

    // Converte a string JSON em um mapa ou lista, dependendo do formato do JSON
    var data = jsonDecode(jsonString) as Map<String, dynamic>;

    // Use os dados carregados conforme necessário
    return data;
  }

  processCharacters({String name = ''}) async {
    final offset = (currentPage - 1) * 4;
    final charactersResponse = await services.getCharacters(name: name, offset: offset);

    setState(() {
      characters = (charactersResponse['data']['results'] as List)
          .map((character) => Character.fromJson(character))
          .toList();
    });

    // ARQUIVO

    // Map<String, dynamic> jsonData = await carregarArquivoJson();

    // setState(() {
    //   characters = (jsonData['data']['results'] as List)
    //     .map((character) => Character.fromJson(character))
    //     .toList();
    // });

    // return characters;
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

  handleTextChanged(String character) async {
    await processCharacters(name: character);
  }

  setPage(int page){
    setState(() {
      currentPage = page;
    });

    print(currentPage);
  }

  @override
  void initState() {
    super.initState();
    processCharacters();
  // .then((characters) => getListData(characters));
  }

  @override
  Widget build(BuildContext context) {

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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#D42026'))),
                  ),
                ),
                TextSpan(
                  text: ' MARVEL ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#D42026')),
                ),
                TextSpan(
                  text: 'TESTE FRONT-END',
                  style: TextStyle(fontSize: 16, color: HexColor('#D42026')),
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
                onChanged: handleTextChanged,
                // controller: _textController,
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
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                onPressed: currentPage > 1
                    ? () async {
                        if(currentPage - 1 < indexPages[0]){
                          int index = 0;

                          for(int i = indexPages[0] - 3; i <= totalPages - 3; i++){
                            indexPages[index] = i;
                            index++;
                          }

                          totalPages = totalPages - 3;
                        }

                        setState(() {
                          currentPage--;
                        });

                        await processCharacters();
                      }
                    : null,
                icon: Icon(Icons.arrow_left,
                    size: 80, color: currentPage > 1 ? HexColor('#D42026') : Colors.grey),
              ),
              // Text('$currentPage de $totalPages'),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: GestureDetector(
                      onTap: () async {
                        setPage(indexPages[0]);
                        await processCharacters();
                      },
                      child: Container(
                        width: 35, // Largura do círculo
                        height: 50, // Altura do círculo
                        decoration: BoxDecoration(
                          color: indexPages[0] == currentPage ? HexColor('#D42026') : Colors.white, 
                          shape: BoxShape.circle, // Define a forma como círculo
                          border: Border.all(
                            color: HexColor('#D42026'),
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            indexPages[0].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: indexPages[0] == currentPage ? Colors.white : HexColor('#D42026')),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: GestureDetector(
                     onTap: () async {
                      setPage(indexPages[1]);
                      await processCharacters();
                    },
                      child: Container(
                        width: 35, // Largura do círculo
                        height: 50, // Altura do círculo
                        decoration: BoxDecoration(
                          color: indexPages[1] == currentPage ? HexColor('#D42026') : Colors.white, 
                          shape: BoxShape.circle, // Define a forma como círculo
                          border: Border.all(
                            color: HexColor('#D42026'),
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            indexPages[1].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: indexPages[1] == currentPage ? Colors.white : HexColor('#D42026')),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setPage(indexPages[2]);
                      await processCharacters();
                    } ,
                    child: Container(
                      width: 35, // Largura do círculo
                      height: 50, // Altura do círculo
                      decoration: BoxDecoration(
                        color: indexPages[2] == currentPage ? HexColor('#D42026') : Colors.white, 
                        shape: BoxShape.circle, // Define a forma como círculo
                        border: Border.all(
                          color: HexColor('#D42026'),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          indexPages[2].toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: indexPages[2] == currentPage ? Colors.white : HexColor('#D42026')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: currentPage <= totalPages
                    ? () async {
                        if(currentPage + 1 > totalPages){
                          int index = 0;

                          for(int i = totalPages + 1; i <= totalPages + 3; i++){
                            indexPages[index] = i;
                            index++;
                          }

                          totalPages = totalPages + 3;
                        }

                        setState(() {
                          currentPage++;
                        });

                        print(currentPage);
                        await processCharacters();
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
