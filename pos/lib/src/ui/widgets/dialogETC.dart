import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/models/user.dart';
import 'package:pos/src/utils/const.dart';
import 'package:pos/src/utils/strings.dart';

class DialogETC extends StatelessWidget {
  final DoBloc _bloc;
  final bool _etc;
  final myController = TextEditingController();
  DialogETC(this._bloc, this._etc);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            content(context),
          ],
        ));
  }

  Widget content(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Consts.avatarRadius + Consts.padding,
        bottom: Consts.padding,
        left: Consts.padding,
        right: Consts.padding,
      ),
      margin: EdgeInsets.only(top: Consts.avatarRadius),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Consts.padding),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(8),
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: StringConstant.namePrice,
                  hintText: StringConstant.namePrice,
                ),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              )),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Text(StringConstant.cancle),
              ),
              FlatButton(
                onPressed: () {
                  _bloc.orders.add(new Content.three(
                      _etc ? '기타' : '할인',
                      _etc
                          ? int.parse(myController.text)
                          : -1 * int.parse(myController.text),
                      1));
                  _bloc.changeOrder;
                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Text(StringConstant.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
