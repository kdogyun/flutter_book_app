import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/blocs/login_bloc.dart';
import 'package:pos/src/blocs/login_bloc_provider.dart';
import 'package:pos/src/ui/tabMain.dart';
import 'package:pos/src/utils/funcs.dart';
import 'package:pos/src/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInForm extends StatefulWidget {
  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  LoginBloc _bloc;
  bool doLogin = true;
  String _phone, _name;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  //시작할 때 폰번호 불러오기
  _loadPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // _phone = (prefs.getString('phone') ?? '01012341234');
      // _name = (prefs.getString('name') ?? 'plan');
      _phone = (prefs.getString('phone') ?? null);
      _name = (prefs.getString('name') ?? null);
    });
  }

  // shared에 폰번호 저장
  _savePhone(String phone, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _phone = phone;
      prefs.setString('phone', _phone);
      _name = name;
      prefs.setString('name', _name);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPhone();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/51216448/is-there-any-callback-to-tell-me-when-build-function-is-done-in-flutter
    if (_phone != null)
      WidgetsBinding.instance
        ..addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DoBlocProvider(child: TabMain(_phone, _name))),
          );
        });

    return Column(
      children: [
        FutureBuilder<Map<String, dynamic>>(
            future: _bloc.checkVersion(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data['version'] != StringConstant.version) {
                //버전이 다를 때
                return AlertDialog(
                  title: Text(StringConstant.errorVersion),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[Text(StringConstant.desVersion)],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('업데이트'),
                      onPressed: () async {
                        const url = 'https://flutter.dev';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    FlatButton(
                        child: Text('종료'),
                        onPressed: () => {
                              Navigator.pop(context, true),
                              SystemNavigator.pop(), // 앱종료
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop'),
                              //exit(0) //강제종료
                            }),
                  ],
                );
              } else {
                //   // 기존 로그인이 있을 경우
                //   if (_phone != null) {
                //     WidgetsBinding.instance..addPostFrameCallback((_) {
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 DoBlocProvider(child: TabMain(_phone, _name))),
                //       );
                //     });
                //     return CircularProgressIndicator();
                //   }
                // 기존 로그인이 없어서 새로 가입하거나 로그인을 다시 해야하는 경우
                // 기본적으로 로그인창이 먼저 뜬다.
                // else {
                return Container(
                    // child: CircularProgressIndicator(),
                    child: StreamBuilder<bool>(
                  stream: _bloc.changeStatus,
                  initialData: true,
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                        child: snapshot.data ? login() : join());
                  },
                ));
              }
            }
            // },
            ),
      ],
    );
  }

  Widget login() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        idField(),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        pwField(),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        Text(StringConstant.messageIDPW),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            loginButton(),
            changeDoButton(),
          ],
        )
      ],
    );
  }

  Widget join() {
    return Column(
      children: [
        phoneField(),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        nameField(),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        itemField(),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        areaField(),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        Text(StringConstant.messageIDPW),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            changeDoButton(),
            joinButton(),
          ],
        )
      ],
    );
  }

  Widget idField() {
    return StreamBuilder(
        stream: _bloc.phone,
        builder: (context, snapshot) {
          return TextField(
            controller: controller1,
            onChanged: _bloc.changePhone,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: StringConstant.phone,
                hintText: StringConstant.idLoginHint,
                errorText: snapshot.error),
          );
        });
  }

  Widget pwField() {
    return StreamBuilder(
        stream: _bloc.name,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            controller: controller2,
            onChanged: _bloc.changeName,
            // obscureText: true, // 비번처럼 **** 표시해주는거
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: StringConstant.bName,
                hintText: StringConstant.pwLoginHint,
                errorText: snapshot.error),
          );
        });
  }

  Widget phoneField() {
    return StreamBuilder(
        stream: _bloc.phone,
        builder: (context, snapshot) {
          return TextField(
            controller: controller1,
            onChanged: _bloc.changePhone,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: StringConstant.phone,
                hintText: StringConstant.phoneField,
                errorText: snapshot.error),
          );
        });
  }

  Widget nameField() {
    return StreamBuilder(
        stream: _bloc.name,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            controller: controller2,
            onChanged: _bloc.changeName,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: StringConstant.bName,
                hintText: StringConstant.nameField,
                errorText: snapshot.error),
          );
        });
  }

  Widget areaField() {
    return StreamBuilder(
        stream: _bloc.area,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeArea,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: StringConstant.bArea,
                hintText: StringConstant.areaField,
                errorText: snapshot.error),
          );
        });
  }

  Widget itemField() {
    return StreamBuilder(
        stream: _bloc.item,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: _bloc.changeItem,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: StringConstant.bItem,
                hintText: StringConstant.itemField,
                errorText: snapshot.error),
          );
        });
  }

  Widget loginButton() {
    return StreamBuilder(
        stream: _bloc.signInStatus,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.data || snapshot.hasError) {
            return lButton();
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget lButton() {
    return RaisedButton(
      child: Text(StringConstant.login),
      textColor: Colors.white,
      color: Colors.black,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      onPressed: () => authenticateUser(),
    );
  }

  Widget joinButton() {
    return StreamBuilder(
        stream: _bloc.signInStatus,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.data || snapshot.hasError) {
            return jButton();
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget jButton() {
    return RaisedButton(
      child: Text(StringConstant.join),
      textColor: Colors.white,
      color: Colors.black,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      onPressed: () => authenticateUser(),
    );
  }

  Widget changeDoButton() {
    return RaisedButton(
      child: doLogin
          ? Text(StringConstant.join)
          : Text(StringConstant.backToLogin),
      textColor: Colors.white,
      color: Colors.black,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      onPressed: () => changeDoLogin(),
    );
  }

  void changeDoLogin() {
    if (doLogin)
      doLogin = false;
    else
      doLogin = true;

    _bloc.chageButton(doLogin);

    controller1.text = '';
    controller2.text = '';
  }

  Future<void> authenticateUser() async {
    _bloc.showProgressBar(true);
    if (doLogin) {
      // 로그인
      // 정상 로그인 1, 아이디(폰번) 없음 0, 비번(상호명) 틀림 -1
      switch (await _bloc.login()) {
        case 1:
          _savePhone(controller1.text, controller2.text);
          break;
        case 0:
          // 아이디(폰번) 없음,
          Funcs().showErrorMessage(context, StringConstant.failID);
          break;
        case -1:
          // 비번(상호명) 틀림
          Funcs().showErrorMessage(context, StringConstant.failPW);
          break;
      }
    } else {
      // 회원가입
      // 정상가입 1, 폰번호 중복 -1
      switch (await _bloc.registerUser()) {
        case 1:
          _savePhone(controller1.text, controller2.text);
          break;

        case -1:
          // 폰번호 중복
          Funcs().showErrorMessage(context, StringConstant.duplicatePhone);
      }
    }
    _bloc.showProgressBar(false);
  }
}
