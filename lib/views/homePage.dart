import 'dart:convert';
import 'package:code_hero/models/Character.dart';
import 'package:code_hero/services/marvel.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String characterName = '';
  List<int> indexPages = [1, 2, 3];
  int currentPage = 1;
  int totalPages = 3;
  int itemsPerPage = 4;
  int totalCharacters = 0;
  int totalItensPages = 0;

  Services services = Services();
  List<Character> characters = [];

  Future<Map<String, dynamic>> carregarArquivoJson() async {
    String jsonString = await rootBundle.loadString('data.json');

    var data = jsonDecode(jsonString) as Map<String, dynamic>;

    return data;
  }

  processCharacters() async {
    final offset = (currentPage - 1) * 4;
    final charactersResponse =
        await services.getCharacters(name: characterName, offset: offset);

    totalCharacters = charactersResponse['data']['total'];
    print(totalCharacters);
    totalItensPages = (totalCharacters / 4).ceil();
    print(totalItensPages);

    List<Character> charactersResult =
        (charactersResponse['data']['results'] as List)
            .map((character) => Character.fromJson(character))
            .toList();

    setState(() {
      characters = charactersResult;
    });
  }

  getListData(List<Character> characters) {
    List<Widget> widgets = [];

    for (final character in characters) {
      widgets.add(ListView.builder(itemBuilder: (context, index) {
        return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(character.thumbnailUrl),
            ),
            title: Text(character.name));
      }));
    }

    // setState(() {
    //   _characters = widgets;
    // });
  }

  handleTextChanged(String character) async {
    setPage(1);
    int index = 0;
    totalPages = 3;

    for (int i = 1; i <= totalPages; i++) {
      indexPages[index] = i;
      index++;
    }

    setCharacterName(character);
    await processCharacters();
  }

  setPage(int page) {
    setState(() {
      currentPage = page;
    });

    print(currentPage);
  }

  setCharacterName(String name) {
    setState(() {
      characterName = name;
    });
  }

  @override
  void initState() {
    super.initState();
    processCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 12, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Text(
                        'BUSCA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: HexColor('#D42026'),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: HexColor('#D42026'))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    ' MARVEL ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: HexColor('#D42026'),
                    ),
                  ),
                  Text(
                    'TESTE FRONT-END',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: HexColor('#D42026'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 25, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(
                        'Nome do Personagem',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: HexColor('#D42026'), fontFamily: 'Roboto'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 12),
                      child: SizedBox(
                        height: 30.0,
                        child: TextField(
                          onChanged: handleTextChanged,
                          // controller: _textController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
              width: double.infinity,
              height: 35,
              color: HexColor('#D42026'),
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 150),
              child: Text(
                'Nome',
                style: TextStyle(
                    fontSize: 14, fontFamily: 'Roboto', color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView.separated(
                // physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                  color: HexColor('#D42026'),
                  thickness: 1,
                  height: 0,
                ),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  Character character = characters[index];

                  if (index == characters.length - 1) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () => {
                            Navigator.pushNamed(context, '/details',
                                arguments: character)
                          },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(character.thumbnailUrl),
                          ),
                          title: Text(character.name),
                        ),
                        Divider(
                          color: HexColor('#D42026'),
                          thickness: 1,
                          height: 0,
                        ),
                      ],
                    );
                  }

                  return ListTile(
                    onTap: () => {
                      Navigator.pushNamed(context, '/details',
                          arguments: character)
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(character.thumbnailUrl),
                    ),
                    title: Text(character.name),
                  );
                },
              ),
            ),
            Container(
              // padding: EdgeInsets.fromLTRB(0, 18, 0, 24),
              height: 80, 
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: HexColor(
                        '#D42026'), 
                    width: 6,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: currentPage > 1
                        ? () async {
                            if (currentPage - 1 < indexPages[0]) {
                              int index = 0;

                              for (int i = indexPages[0] - 3;
                                  i <= totalPages - 3;
                                  i++) {
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
                        size: 60, 
                        color: currentPage > 1
                            ? HexColor('#D42026')
                            : Colors.grey),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setPage(indexPages[0]);
                          await processCharacters();
                        },
                        child: Container(
                          width: 30,
                          height: 40,
                          decoration: BoxDecoration(
                            color: indexPages[0] == currentPage
                                ? HexColor('#D42026')
                                : Colors.white,
                            shape: BoxShape.circle,
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: indexPages[0] == currentPage
                                    ? Colors.white
                                    : HexColor('#D42026'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if(indexPages[1] <= totalItensPages)
                      SizedBox(
                          width:
                              15), 
                      if (indexPages[1] <= totalItensPages)
                        GestureDetector(
                          onTap: () async {
                            setPage(indexPages[1]);
                            await processCharacters();
                          },
                          child: Container(
                            width: 30,
                            height: 40,
                            decoration: BoxDecoration(
                              color: indexPages[1] == currentPage
                                  ? HexColor('#D42026')
                                  : Colors.white,
                              shape: BoxShape.circle,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: indexPages[1] == currentPage
                                      ? Colors.white
                                      : HexColor('#D42026'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if(indexPages[2] <= totalItensPages)
                      SizedBox(
                          width:
                              15),
                      if (indexPages[2] <= totalItensPages)
                        GestureDetector(
                          onTap: () async {
                            setPage(indexPages[2]);
                            await processCharacters();
                          },
                          child: Container(
                            width: 30,
                            height: 40,
                            decoration: BoxDecoration(
                              color: indexPages[2] == currentPage
                                  ? HexColor('#D42026')
                                  : Colors.white,
                              shape: BoxShape.circle,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: indexPages[2] == currentPage
                                      ? Colors.white
                                      : HexColor('#D42026'),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  IconButton(
                    onPressed: currentPage <= totalPages &&
                            currentPage < totalItensPages
                        ? () async {
                            if (currentPage + 1 > totalPages) {
                              int index = 0;

                              for (int i = totalPages + 1;
                                  i <= totalPages + 3;
                                  i++) {
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
                        size: 60,
                        color: currentPage >= totalItensPages
                            ? Colors.grey
                            : HexColor('#D42026')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
