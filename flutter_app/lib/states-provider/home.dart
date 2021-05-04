import 'package:flutter/material.dart';
import 'package:flutter_app/states-provider/drawer-menu.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/states-provider/model/ui.dart';

const kAppTitle = 'State Management by Provider';
const kStateType = 'Provider';

class Home extends StatelessWidget {
  String text = lorem(paragraphs: 3, words: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppTitle),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerMenu(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Consumer<UI>(
          builder: (context, ui, child) {
            print('home: ${ui.fontSize}');
            return RichText(
              text: TextSpan(
                  text: text,
                  style: TextStyle(fontSize: ui.fontSize, color: Colors.black)),
            );
          },
        ),
      ),
    );
  }
}
