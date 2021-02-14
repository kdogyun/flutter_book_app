import 'package:flutter/material.dart';
import 'package:pos/src/models/user.dart';
import 'package:pos/src/utils/funcs.dart';

class GridMenu extends StatelessWidget {
  final Menu _menu;
  final bool _show; // show Category
  GridMenu(this._menu, this._show);

  @override
  Widget build(BuildContext context) {
    return _show
        ? ListTile(
            title: Text(_menu.name),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_menu.category),
            ]),
            trailing: Text(Funcs().numComma(_menu.price)),
          )
        : ListTile(
            title: Text(_menu.name),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(Funcs().numComma(_menu.price)),
            ]));
  }
}
