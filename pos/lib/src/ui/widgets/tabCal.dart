import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/ui/widgets/tile_item.dart';
import 'package:pos/src/utils/strings.dart';

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
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        4.0) //         <--- border radius here
                                    ),
                              ),
                              child: Center(child: Text('::')))),
                      Expanded(
                          flex: 9,
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        4.0) //         <--- border radius here
                                    ),
                              ),
                              child: Center(child: Text('총액')))),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                    color: Colors.red,
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        4.0) //         <--- border radius here
                                    ),
                              ),
                              child: Center(child: Text('할인')))),
                      Expanded(
                          flex: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        4.0) //         <--- border radius here
                                    ),
                              ),
                              child: Center(child: Text('기타')))),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                    color: Colors.red,
                  )),
              Expanded(
                  flex: 5,
                  child: Container(
                      alignment: Alignment(0.0, 0.0), child: orderList())),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                    color: Colors.red,
                  )),
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        4.0) //         <--- border radius here
                                    ),
                              ),
                              child: Center(child: Text('현금')))),
                      Expanded(
                          flex: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        4.0) //         <--- border radius here
                                    ),
                              ),
                              child: Center(child: Text('카드')))),
                    ],
                  )),
            ],
          )),
      Expanded(
        flex: 7,
        child: Container(
          alignment: Alignment(0.0, 0.0),
          child: RaisedButton(
              onPressed: () =>
                  addContent(new Content.three('coffee', 1000, 1))),
        ),
      ),
    ]);
  }

  void addContent(Content c) {
    int index = _bloc.orders.indexWhere((element) => element.name == c.name);
    if (index == -1)
      _bloc.orders.add(c);
    else
      _bloc.orders[index].up();

    _bloc.changeOrder;
  }

  void deleteContent(int index) {
    if (!_bloc.orders[index].down()) _bloc.orders.removeAt(index);

    _bloc.changeOrder;
  }

  StreamBuilder orderList() {
    return StreamBuilder(
      stream: _bloc.order,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0)
            return Center(child: Text(StringConstant.noOrder));
          else
            return Scrollbar(
                child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () => deleteContent(index),
                  child: TileItem(snapshot.data[index])),
              itemCount: snapshot.data.length,
            ));
        } else
          return Center(child: Text(StringConstant.noOrder));
      },
    );
  }

  // ListView buildList(List<Goal> goalsList) {
  //   return ListView.separated(
  //       separatorBuilder: (BuildContext context, int index) => Divider(),
  //       itemCount: goalsList.length,
  //       itemBuilder: (context, index) {
  //         final item = goalsList[index];
  //         return Dismissible(
  //             key: Key(item.id.toString()),
  //             onDismissed: (direction) {
  //               _bloc.removeGoal(item.title, widget._emailAddress);
  //             },
  //             background: Container(color: Colors.red),
  //             child: ListTile(
  //               title: Text(
  //                 goalsList[index].title,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               subtitle: Text(goalsList[index].message),
  //             ));
  //       });
  // }
}
