import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/models/user.dart';
import 'package:pos/src/utils/const.dart';
import 'package:pos/src/utils/strings.dart';

class DialogMenu extends StatefulWidget {
  final DoBloc _bloc;
  final User _user;
  final Menu _menu;
  DialogMenu(this._bloc, this._user, this._menu);

  @override
  _DialogMenutState createState() {
    return _DialogMenutState();
  }
}

class _DialogMenutState extends State<DialogMenu> {
  final myController = TextEditingController();
  String myController2;
  final myController3 = TextEditingController();

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
    if (widget._menu != null) {
      myController.text = widget._menu.name;
      // myController2 = widget._user.categories
      //     .firstWhere((element) => element.name == widget._menu.category);
      myController2 = widget._menu.category;
      myController3.text = '${widget._menu.price}';
    }

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
      // 키보드에 의해 깨지는 거 방지
      child: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: [
          Container(
              margin: EdgeInsets.all(8),
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: StringConstant.nameMenu,
                  hintText: StringConstant.nameMenu,
                ),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              )),
          SizedBox(height: 16.0),
          Container(
              margin: EdgeInsets.all(8),
              child: TextField(
                controller: myController3,
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
          SizedBox(height: 16.0),
          Container(
              margin: EdgeInsets.all(8),
              child: DropdownButton(
                isExpanded: true,
                hint: Text(StringConstant.nameCategory),
                value: myController2,
                onChanged: (value) {
                  setState(() {
                    myController2 = value;
                  });
                },
                items: widget._user.categories.map(
                  (cateogry) {
                    return DropdownMenuItem(
                      value: cateogry.name,
                      child: Text(cateogry.name),
                    );
                  },
                ).toList(),
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
                  widget._user.menus.add(new Menu(myController.text,
                      myController2, int.parse(myController3.text)));
                  widget._bloc.setUser(widget._user);
                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Text(StringConstant.save),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
