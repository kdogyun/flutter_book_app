import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/models/user.dart';
import 'package:pos/src/ui/widgets/grid_menu.dart';
import 'package:pos/src/utils/funcs.dart';
import 'package:pos/src/utils/strings.dart';

import 'dialogMenu.dart';

class SettingMenuScreen extends StatefulWidget {
  final String _phone;
  final DoBloc _bloc;

  SettingMenuScreen(this._phone, this._bloc);

  @override
  _SettingMenutState createState() {
    return _SettingMenutState();
  }
}

class _SettingMenutState extends State<SettingMenuScreen> {
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
        // 키보드에 의해 깨지는 거 방지
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            StringConstant.settingCategory,
            style: TextStyle(color: Color.fromRGBO(224, 15, 26, .99)),
          ),
          backgroundColor: Colors.red[50],
          elevation: 0.0,
        ),
        // Scaffold 안에서 스낵바를 호출하면 문제가 된다.
        // https://here4you.tistory.com/154 링크에서 소개되는 방법 중, 나는 2번째 이용.
        floatingActionButton: Builder(builder: (BuildContext context) {
          return _bottomButtons(context);
        }),
        body: StreamBuilder(
            stream: widget._bloc.getUser(widget._phone),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                _user = User.fromJson(snapshot.data.data());
                if (_user.menus.isEmpty)
                  return Center(
                    child: Text(StringConstant.noMenu),
                  );
                else {
                  // 카테고리별로 정렬
                  final Map<String, int> cOrder = {};
                  for (final item in _user.categories)
                    cOrder[item.name] = item.order;
                  Comparator<Menu> orderComparator = (a, b) =>
                      cOrder[a.category].compareTo(cOrder[b.category]);
                  _user.menus.sort(orderComparator);

                  return GridView.extent(
                    scrollDirection: Axis.vertical,
                    maxCrossAxisExtent: 300.0, //필수값
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      for (final item in _user.menus)
                        Container(
                            key: ValueKey(item),
                            child: GridMenu(_user, item, true))
                    ],
                  );
                }
              } else
                return CircularProgressIndicator();
            }));
  }

  Widget _bottomButtons(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_user.categories.length == 0) {
            Funcs().showErrorMessage(context, StringConstant.preorderCategory);
          } else
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogMenu(widget._bloc, _user, null);
                });
        });
  }
}
