import 'package:flutter/material.dart';
import 'package:pos/src/models/user.dart';
import 'package:pos/src/utils/funcs.dart';

class GridMenu extends StatelessWidget {
  final Menu _menu;
  final bool _show; // show Category
  final User _user;
  GridMenu(this._user, this._menu, this._show);

  @override
  Widget build(BuildContext context) {
    return _show
        ? ListTile(
            title: Text(_menu.name, style: TextStyle(fontSize: 30)),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_menu.category, style: TextStyle(fontSize: 25)),
            ]),
            trailing: Text(Funcs().numComma(_menu.price),
                style: TextStyle(fontSize: 30)),
          )
        : ListTile(
            title: Text(_menu.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(Funcs().numComma(_menu.price),
                  style: TextStyle(fontSize: 22)),
            ]));
  }
}
