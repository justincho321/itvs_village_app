import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class ParsingWidget2 extends StatefulWidget {
  const ParsingWidget2({Key? key}) : super(key: key);

  @override
  State<ParsingWidget2> createState() => _ParsingWidgetState();
}

class _ParsingWidgetState extends State<ParsingWidget2> {
  List<String> list = [];
  List elements = [];
  List elements2 = [];
  final _currentUrl = 'https://comic.naver.com/webtoon/weekdayList?week=';

  void _getData() async {
    final response = await http.get(Uri.parse(_currentUrl));
    final host = Uri.parse(_currentUrl).host;
    dom.Document document = parser.parse(response.body);
    elements = document.getElementsByTagName("img").toList();

    for (var element in elements) {
      var imageSource = element.attributes['src'] ?? '';
      print(imageSource);
      bool validURL = Uri.parse(imageSource).host == '' ||
              Uri.parse(host + imageSource).host == ''
          ? false
          : true;
      setState(() {
        list.add(imageSource);
      });

      /*
    list = elements
        .map((element) =>
            element.getElementsByTagName("img")[0].attributes['src'])
        .toList() as List<String>;
        */

      print(elements.length);
      print(list.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Image Fetcher -->'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                if (list != null) {
                  list.clear();
                }
                _getData();
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Image.network(
              list[index],
              width: 200.0,
              height: 200.0,
            );
          },
        ));
  }
}
