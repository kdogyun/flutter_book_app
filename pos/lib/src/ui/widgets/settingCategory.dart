import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/models/user.dart';
import 'package:pos/src/ui/widgets/dialogCategory.dart';
import 'package:pos/src/ui/widgets/tile_category.dart';
import 'package:pos/src/utils/strings.dart';

class SettingCategoryScreen extends StatefulWidget {
  final String _phone;
  final DoBloc _bloc;

  SettingCategoryScreen(this._phone, this._bloc);

  @override
  _SettingCategorytState createState() {
    return _SettingCategorytState();
  }
}

class _SettingCategorytState extends State<SettingCategoryScreen> {
  // DoBloc _bloc;
  User _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _bloc = DoBlocProvider.of(context);
  }

  @override
  void dispose() {
    // _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstant.settingCategory,
          style: TextStyle(color: Color.fromRGBO(224, 15, 26, .99)),
        ),
        backgroundColor: Colors.red[50],
        elevation: 0.0,
      ),
      floatingActionButton: _bottomButtons(context),
      body: StreamBuilder(
          stream: widget._bloc.getUser(widget._phone),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              _user = User.fromJson(snapshot.data.data());
              if (_user.categories.isEmpty)
                return Center(
                  child: Text(StringConstant.noCategory),
                );
              else {
                Comparator<Category> orderComparator =
                    (a, b) => a.order.compareTo(b.order);
                _user.categories.sort(orderComparator);
                return ReorderableListView(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  onReorder: _updateItems,
                  children: [
                    for (final item in _user.categories)
                      Container(key: ValueKey(item), child: TileCategory(item))
                  ],
                );
              }
            } else
              return CircularProgressIndicator();
          }),
    );
  }

  // void reorderData(int oldindex, int newindex) {
  //   setState(() {
  //     if (newindex > oldindex) {
  //       newindex -= 1;
  //     }
  //     final items = widget.item.removeAt(oldindex);
  //     widget.item.insert(newindex, items);
  //   });
  // }

  void _updateItems(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      final item = _user.categories.removeAt(oldIndex);
      _user.categories.insert(newIndex, item);
      widget._bloc.setUser(_user);
    });
  }

  Widget _bottomButtons(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  DialogCategory(widget._bloc, _user, null));
        });
  }
}
