import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

//another similar way to fetch images from a website and display them. Doesn't work with all websites.
//use image_fetcher_2.dart instead

class ParsingWidget extends StatefulWidget {
  const ParsingWidget({Key? key}) : super(key: key);

  @override
  State<ParsingWidget> createState() => _ParsingWidgetState();
}

class _ParsingWidgetState extends State<ParsingWidget> {
  List<String> list = [];

  void _getData() async {
    final response = await http.get(Uri.parse('https://www.tiktok.com/en/'));
    dom.Document document = parser.parse(response.body);
    final elements = document.getElementsByClassName('thumb');

    setState(() {
      list = elements
          .map((element) =>
              element.getElementsByTagName("img")[0].attributes['src'])
          .toList() as List<String>;
    });
    print(list.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
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
