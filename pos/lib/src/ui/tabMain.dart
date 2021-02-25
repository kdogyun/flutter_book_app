import 'package:flutter/material.dart';
import 'package:pos/src/ui/widgets/tabCal.dart';
import 'package:pos/src/ui/widgets/tabReceipt.dart';
import 'package:pos/src/ui/widgets/tabSetting.dart';
import 'package:pos/src/ui/widgets/tabStats.dart';
import 'package:pos/src/utils/strings.dart';

class TabMain extends StatefulWidget {
  final String _phone, _name;

  TabMain(this._phone, this._name);

  @override
  TabMainState createState() {
    return TabMainState();
  }
}

class TabMainState extends State<TabMain> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   widget._name + ' with ' + StringConstant.domain,
        //   style: TextStyle(color: Color.fromRGBO(224, 15, 26, .99)),
        // ),
        flexibleSpace: SafeArea(
          child: TabBar(
            controller: _tabController,
            tabs: <Tab>[
              Tab(text: StringConstant.tabReceipt),
              Tab(text: StringConstant.tabCal),
              Tab(text: StringConstant.tabStats),
              Tab(text: StringConstant.tabSetting),
            ],
          ),
        ),
        backgroundColor: Colors.red[50],
        elevation: 0.0,
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ReceiptScreen(widget._phone),
          CalScreen(widget._phone),
          StatsScreen(widget._phone),
          SettingScreen(widget._phone),
        ],
      ),
    );
  }
}
