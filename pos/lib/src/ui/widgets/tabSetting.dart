import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/ui/widgets/settingCategory.dart';
import 'package:pos/src/ui/widgets/settingMenu.dart';
import 'package:pos/src/utils/funcs.dart';
import 'package:pos/src/utils/strings.dart';

class SettingScreen extends StatefulWidget {
  final String _phone;

  SettingScreen(this._phone);

  @override
  _SettingState createState() {
    return _SettingState();
  }
}

class _SettingState extends State<SettingScreen> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
            onTap: () => showMessageOrDialog(),
            child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(
                      Radius.circular(4.0) //         <--- border radius here
                      ),
                ),
                child: Center(child: Text(StringConstant.settingMenu)))),
        InkWell(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SettingCategoryScreen(widget._phone, _bloc);
                  }),
                ),
            child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(
                      Radius.circular(4.0) //         <--- border radius here
                      ),
                ),
                child: Center(child: Text(StringConstant.settingCategory)))),
        Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.all(
                  Radius.circular(4.0) //         <--- border radius here
                  ),
            ),
            child: Center(child: Text(StringConstant.settingContact))),
      ],
    );
  }

  void showMessageOrDialog() {
    if (0 == 0)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return SettingMenuScreen(widget._phone, _bloc);
        }),
      );
    else
      Funcs().showErrorMessage(context, StringConstant.preorderCategory);
  }
}
