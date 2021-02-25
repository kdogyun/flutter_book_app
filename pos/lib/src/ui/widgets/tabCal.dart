import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/models/user.dart';
import 'package:pos/src/ui/widgets/dialogETC.dart';
import 'package:pos/src/ui/widgets/tile_item.dart';
import 'package:pos/src/utils/funcs.dart';
import 'package:pos/src/utils/strings.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'grid_menu.dart';

class CalScreen extends StatefulWidget {
  final String _phone;

  CalScreen(this._phone);

  @override
  _CarState createState() {
    return _CarState();
  }
}

class _CarState extends State<CalScreen> {
  DoBloc _bloc;
  User _user;
  ItemScrollController _scrollController = ItemScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = DoBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 3,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () => clearContent(),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            4.0) //         <--- border radius here
                                        ),
                                  ),
                                  child: Center(
                                      child: Text('::',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)))))),
                      Expanded(
                          flex: 9,
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        4.0) //         <--- border radius here
                                    ),
                              ),
                              child: Center(
                                  child: StreamBuilder(
                                      stream: _bloc.total,
                                      builder: (context, element) {
                                        if (element.hasData) {
                                          if (element.data == 0)
                                            return Text(StringConstant.noCash,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold));
                                          else
                                            return Text(
                                                Funcs().numComma(element.data),
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold));
                                        } else
                                          return Text(StringConstant.noCash,
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold));
                                      })))),
                    ],
                  )),

              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: InkWell(
                              onTap: () => showMessageOrSave(true),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            4.0) //         <--- border radius here
                                        ),
                                  ),
                                  child: Center(
                                      child: Text(StringConstant.cash,
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)))))),
                      Expanded(
                          flex: 5,
                          child: InkWell(
                              onTap: () => showMessageOrSave(false),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            4.0) //         <--- border radius here
                                        ),
                                  ),
                                  child: Center(
                                      child: Text(StringConstant.card,
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)))))),
                    ],
                  )),
              // Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child:
              // Divider(
              //   thickness: 1,
              //   color: Colors.red,
              // ),
              Expanded(
                  flex: 7,
                  child: Container(
                      alignment: Alignment(0.0, 0.0), child: orderList())),
              // Divider(
              //   thickness: 1,
              //   color: Colors.red,
              // ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 5,
                          child: InkWell(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DialogETC(_bloc, true)),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            4.0) //         <--- border radius here
                                        ),
                                  ),
                                  child: Center(
                                      child: Text(StringConstant.etc,
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)))))),
                      Expanded(
                          flex: 6,
                          child: InkWell(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DialogETC(_bloc, false)),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            4.0) //         <--- border radius here
                                        ),
                                  ),
                                  child: Center(
                                      child: Text(StringConstant.discount,
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)))))),
                    ],
                  )),
              // Divider(
              //   thickness: 1,
              //   color: Colors.red,
              // ),
            ],
          )),
      // VerticalDivider(
      //   thickness: 1,
      //   color: Colors.red,
      // ),
      Expanded(
        flex: 7,
        child: Container(
          alignment: Alignment(0.0, 0.0),
          child: StreamBuilder(
              stream: _bloc.getUser(widget._phone),
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

                    return Container(
                        child: GridView.extent(
                      scrollDirection: Axis.vertical,
                      maxCrossAxisExtent: 300.0, //필수값
                      // crossAxisSpacing: 10,
                      // mainAxisSpacing: 10,
                      childAspectRatio: 3,
                      children: [
                        for (final item in _user.menus)
                          Ink(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                  ),
                                  color: cOrder[item.category] % 2 == 1
                                      ? Colors.red[50]
                                      : null),
                              child: InkWell(
                                  onTap: () => addContent(item),
                                  child: GridMenu(_user, item, false)))
                      ],
                    ));
                  }
                } else
                  return CircularProgressIndicator();
              }),
        ),
      ),
    ]);
  }

  void addContent(Menu m) {
    int _index = _bloc.orders.indexWhere((element) => element.name == m.name);
    if (_index == -1)
      _bloc.orders.add(new Content.three(m.name, m.price, 1));
    else
      _bloc.orders[_index].up();

    _bloc.changeOrder;
    if (_index == -1) _index = _bloc.orders.length - 1;
    _scrollController.scrollTo(index: _index, duration: Duration(seconds: 1));
  }

  void deleteContent(int index) {
    if (!_bloc.orders[index].down()) _bloc.orders.removeAt(index);

    _bloc.changeOrder;
  }

  void clearContent() {
    _bloc.orders.clear();

    _bloc.changeOrder;
  }

  StreamBuilder orderList() {
    return StreamBuilder(
      stream: _bloc.order,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0)
            return Center(
                child: Text(StringConstant.noOrder,
                    style: TextStyle(fontSize: 15)));
          else
            return Scrollbar(
                child: ScrollablePositionedList.builder(
              padding: EdgeInsets.all(10.0),
              itemScrollController: _scrollController,
              itemBuilder: (context, index) => InkWell(
                  onTap: () => deleteContent(index),
                  child: TileItem(snapshot.data[index])),
              itemCount: snapshot.data.length,
            ));
        } else
          return Center(child: Text(StringConstant.noOrder));
      },
    );
  }

  void showMessageOrSave(bool _cash) {
    if (_bloc.orders.length == 0)
      Funcs().showErrorMessage(context, StringConstant.noOrder);
    else {
      _bloc.setReceipt(new Receipt.exceptDate(
          widget._phone,
          _cash ? StringConstant.cash : StringConstant.card,
          _bloc.getTotal,
          _bloc.orders));
      clearContent();
    }
  }
}
