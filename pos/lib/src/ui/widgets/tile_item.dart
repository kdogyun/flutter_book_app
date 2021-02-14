import 'package:flutter/material.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/utils/funcs.dart';

class TileItem extends StatelessWidget {
  final Content _content;
  TileItem(this._content);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_content.name),
      subtitle: Text("${_content.count} 개"),
      trailing: Text(Funcs().numComma(_content.sum)),
      // trailing: Text(NumberFormat.currency(locale: 'ko_KR', decimalDigits: 3)
      //     .format(_content.sum)),
      // subtitle: Text("${_content.price} 원\n${_content.count} 개"),
      // isThreeLine: true,
      // subtitle: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [Text('First'), Text('Second')]),
    );
  }
}
