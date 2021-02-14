import 'package:flutter/material.dart';
import 'package:pos/src/models/user.dart';

class TileCategory extends StatelessWidget {
  final Category _category;
  TileCategory(this._category);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_category.name),
      trailing: Text('::'),
    );
  }
}
