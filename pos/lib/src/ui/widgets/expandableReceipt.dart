import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/utils/funcs.dart';
import 'package:pos/src/utils/strings.dart';

// https://www.youtube.com/watch?v=X04rKtYRkSs
class ExpandableReceipt extends StatefulWidget {
  final DoBloc _bloc;
  final String _phone;
  ExpandableReceipt(this._bloc, this._phone);

  @override
  State<StatefulWidget> createState() => _ExpandableReceiptState(_bloc);
}

class _ExpandableReceiptState extends State<ExpandableReceipt> {
  final DoBloc _bloc;
  _ExpandableReceiptState(this._bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.getReceipt(widget._phone),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length != 0)
              return _buildList(context, snapshot.data.docs);
            else
              return Center(child: Text(StringConstant.noReceipt));
          } else
            return CircularProgressIndicator();
        });
  }

  _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        final Receipt _r = Receipt.fromJson(snapshot[index].data());
        return new ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getDate(_r),
                  style: new TextStyle(
                    fontSize: 20.0,
                  )),
              Text(getContent(_r),
                  style: new TextStyle(
                    fontSize: 20.0,
                  )),
              Text(
                getPrice(_r),
                style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          children: <Widget>[
            _buildExpandableContent(_r),
          ],
        );
      },
    );
  }

  _buildExpandableContent(Receipt _r) {
    return Column(
      children: [
            for (final item in _r.contents)
              Row(
                children: [
                  Expanded(
                      child: ListTile(
                    leading: Text(item.name),
                    title: Text(getCount(item)),
                    trailing: Text(Funcs().numComma(item.sum)),
                  ))
                ],
              )
          ] +
          [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                  onTap: () => changeType(_r),
                  child: Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(StringConstant.changeType))),
              Container(
                  margin: EdgeInsets.all(20.0), child: Text(getTotal(_r))),
            ])
          ],
      // children: [
      //                   for (final item in _user.menus)
      //                     Container(
      //                         key: ValueKey(item),
      //                         child: InkWell(
      //                             onTap: () => addContent(item),
      //                             child: GridMenu(item, false)))
      //                 ],
    );
  }

  String getDate(Receipt _r) {
    return '${DateFormat('yyyy년 MM월 dd일 (EEEE) hh:mm').format(_r.createdAt)}';
  }

  String getContent(Receipt _r) {
    return '${_r.contents.first.name}외 ${_r.contents.length - 1}개';
  }

  String getPrice(Receipt _r) {
    return '${Funcs().numComma(_r.total)}원 (${_r.type})';
  }

  String getCount(Content _c) {
    return 'X${_c.count}';
  }

  String getTotal(Receipt _r) {
    return '총 ${Funcs().numComma(_r.total)}원';
  }

  void changeType(Receipt _r) {
    _r.type = (_r.type == '현금') ? '카드' : '현금';
    _bloc.updateReceipt(_r);
  }
}
