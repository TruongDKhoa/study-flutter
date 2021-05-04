import 'package:flutter/material.dart';

const kTitle = 'Provider';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                kTitle,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.title.fontSize,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(color: Colors.teal),
          ),
          getListTitle('Home', onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          }),
          getLine(),
          getListTitle('About', onTap: () {
            Navigator.pushReplacementNamed(context, '/about');
          }),
          getLine(),
          getListTitle('Setting', onTap: () {
            Navigator.pushReplacementNamed(context, '/setting');
          }),
        ],
      ),
    );
  }

  Widget getLine() {
    return SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget getListTitle(title, {Function onTap}) {
    return ListTile(title: Text(title), onTap: onTap);
  }
}
