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
        // : ListTile(
        //     title: Text(_menu.name,
        //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        //     subtitle:
        //         Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        //       Text(Funcs().numComma(_menu.price),
        //           style: TextStyle(fontSize: 22)),
        //     ]));
        : Container(
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(_menu.name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(Funcs().numComma(_menu.price),
                      style: TextStyle(
                          fontSize: 22,
                          // fontWeight: FontWeight.bold,
                          color: Colors.grey[600])),
                ),
              ],
            ));
  }
}
