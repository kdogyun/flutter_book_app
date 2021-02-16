import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/models/user.dart';

import 'expandableReceipt.dart';

class ReceiptScreen extends StatefulWidget {
  final String _phone;

  ReceiptScreen(this._phone);

  @override
  _ReceiptState createState() {
    return _ReceiptState();
  }
}

class _ReceiptState extends State<ReceiptScreen> {
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
      child: ExpandableReceipt(_bloc, widget._phone),
    );
  }
}
