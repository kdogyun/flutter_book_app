import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/models/user.dart';

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
    return Container(
      alignment: Alignment(0.0, 0.0),
      child: StreamBuilder(
          stream: _bloc.getUser(widget._phone),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            final a = User.fromJson(snapshot.data.data());
            return Text('셋팅: ' + a.bItem);
          }),
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
