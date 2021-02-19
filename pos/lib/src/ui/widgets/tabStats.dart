import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/utils/funcs.dart';
import 'package:pos/src/utils/strings.dart';
import 'package:table_calendar/table_calendar.dart';

class StatsScreen extends StatefulWidget {
  final String _phone;

  StatsScreen(this._phone);

  @override
  _StatsState createState() {
    return _StatsState();
  }
}

class _StatsState extends State<StatsScreen> with TickerProviderStateMixin {
  DoBloc _bloc;
  DateTime _currentDate = new DateTime.now();
  // DateTime _currentDate2 = new DateTime.now();
  DateTime _currentMonth = new DateTime.now();
  // String _currentMonth = DateFormat.yMMM().format(new DateTime.now());
  // DateTime _targetDateTime = DateTime(2019, 2, 3);
  AnimationController _animationController;
  CalendarController _calendarController;
  Map<int, List<Receipt>> _receipts = <int, List<Receipt>>{};
  List<MenuData> _menuData = <MenuData>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = DoBlocProvider.of(context);
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _bloc.dispose();
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.getReceipt(
            widget._phone,
            DateTime(_currentMonth.year, _currentMonth.month, 1),
            DateTime(_currentMonth.year, _currentMonth.month + 1, 0)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length != 0)
              return _buildList(context, snapshot.data.docs);
            else
              return Center(child: Text(StringConstant.noStats));
          } else
            return CircularProgressIndicator();
        });
  }

  _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    int index = 0;
    for (int i = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
        i >= 1;
        i--) {
      _receipts[i] = <Receipt>[];
      int start =
          DateTime(_currentMonth.year, _currentMonth.month, i, 0, 0, 0, 000)
              .millisecondsSinceEpoch;
      int end =
          DateTime(_currentMonth.year, _currentMonth.month, i, 23, 59, 59, 999)
              .millisecondsSinceEpoch;
      while (index < snapshot.length) {
        final Receipt _r = Receipt.fromJson(snapshot[index].data());
        if (start <= _r.createdAt.millisecondsSinceEpoch &&
            _r.createdAt.millisecondsSinceEpoch <= end) {
          _receipts[i].add(_r);
          index++;
        } else
          break;
      }
    }
    return _buildCalendar(context);
  }

  void _onDaySelected(DateTime day) {
    // print('CALLBACK: _onDaySelected');
    setState(() {
      _currentDate = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onCalendarCreated');
  }

  _buildCalendar(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      // ExpansionTile(initiallyExpanded: true, title: Text('달력'), children: [
      TableCalendar(
        calendarController: _calendarController,
        locale: 'ko_KR',
        // events: _events,
        // holidays: _holidays,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.all,
        availableCalendarFormats: const {
          CalendarFormat.month: '',
          CalendarFormat.week: '',
        },
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          eventDayStyle: TextStyle(fontSize: 50),
          weekdayStyle: TextStyle(fontSize: 50),
          weekendStyle:
              TextStyle(fontSize: 50).copyWith(color: Colors.blue[800]),
          holidayStyle:
              TextStyle(fontSize: 50).copyWith(color: Colors.blue[800]),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
        ),
        headerStyle: HeaderStyle(
          // YYYY년 MM월 찍히는 부분
          centerHeaderTitle: true,
          formatButtonVisible: false,
        ),
        builders: CalendarBuilders(
          selectedDayBuilder: (context, date, _) {
            return FadeTransition(
              opacity:
                  Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0),
                color: Colors.deepOrange[300],
                width: 500,
                height: 500,
                child: _presentDay(date),
              ),
            );
          },
          todayDayBuilder: (context, date, _) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0),
              color: Colors.amber[400],
              width: 500,
              height: 500,
              child: _presentDay(date),
            );
          },
          dayBuilder: (context, date, _) {
            return Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0),
                color: Colors.transparent,
                width: 500,
                height: 500,
                child: _presentDay(date));
          },
        ),
        onDaySelected: (date, events, holidays) {
          _onDaySelected(date);
          _animationController.forward(from: 0.0);
        },
        onVisibleDaysChanged: _onVisibleDaysChanged,
        onCalendarCreated: _onCalendarCreated,
      ),
      // ]),
      Container(margin: EdgeInsets.only(top: 25.0, bottom: 25.0)),
      _rankWidget(),
      Container(margin: EdgeInsets.only(top: 40.0, bottom: 40.0)),
      _chartWidget(),
    ]));
  }

  _presentDay(DateTime date) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        date.day.toString(),
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: [6, 7].contains(date.weekday) ? Colors.red : Colors.black,
        ),
      ),
      Column(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              sumDay(_receipts[date.day], StringConstant.cash),
              style: TextStyle(
                  fontSize: 20.0,
                  // backgroundColor: Colors.blue,
                  color: Colors.red),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              sumDay(_receipts[date.day], StringConstant.card),
              style: TextStyle(
                  fontSize: 20.0,
                  // backgroundColor: Colors.red,
                  color: Colors.blue),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              sumDay(_receipts[date.day], 'both'),
              style: TextStyle(
                  fontSize: 20.0,
                  // backgroundColor: Colors.red,
                  color: Colors.black),
            ),
          )
        ],
      )
    ]);
  }

  String sumDay(List<Receipt> _r, String type) {
    int _temp = 0;
    if (_r == null || _r.length == 0) return '';
    _r.forEach((element) {
      if (type == 'both')
        _temp += element.total;
      else if (element.type == type) _temp += element.total;
    });
    return Funcs().numComma(_temp);
  }

  _chartWidget() {
    List<Receipt> _r = _receipts[_currentDate.day];
    Map<String, int> _map = <String, int>{};
    _r.forEach((element) {
      element.contents.forEach((c) {
        int _temp = _map[c.name] ?? 0;
        _map[c.name] = _temp + c.count;
      });
    });
    var sortedKeys = _map.keys.toList(growable: false)
      ..sort((k1, k2) =>
          _map[k2].compareTo(_map[k1])); // 오름차순, 내림차순은 여기서 k1, k2 순서만 바꾸면 됨
    LinkedHashMap _sMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => _map[k]);
    _menuData = <MenuData>[];
    _sMap.forEach((k, v) => _menuData.add(MenuData(k, v)));
    _r = null;
    _map = null;
    _sMap = null;
    return _menuData.length != 0
        ? BarChart(BarChartData(
            alignment: BarChartAlignment.spaceAround,
            // maxY: 20,
            // barTouchData: BarTouchData(
            //   enabled: false,
            //   touchTooltipData: BarTouchTooltipData(
            //     tooltipBgColor: Colors.transparent,
            //     tooltipPadding: const EdgeInsets.all(0),
            //     tooltipBottomMargin: 8,
            //     getTooltipItem: (
            //       BarChartGroupData group,
            //       int groupIndex,
            //       BarChartRodData rod,
            //       int rodIndex,
            //     ) {
            //       return BarTooltipItem(
            //         rod.y.round().toString(),
            //         TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                rotateAngle: 45,
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                margin: 20,
                getTitles: (double value) {
                  return _menuData[value.toInt()].name;
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              for (final index
                  in Iterable<int>.generate(_menuData.length).toList())
                BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                        y: _menuData[index].count.toDouble(),
                        colors: [Colors.lightBlueAccent, Colors.greenAccent])
                  ],
                  showingTooltipIndicators: [0],
                )
            ],
          ))
        : Container();
  }

  _rankWidget() {
    int _sum = 0;
    _menuData.forEach((element) {
      _sum += element.count;
    });
    return _menuData.length != 0
        ? Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                        Text('<판매왕>',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 7.0, bottom: 7.0))
                      ] +
                      [
                        for (final index in Iterable<int>.generate(
                                _menuData.length >= 3 ? 3 : _menuData.length)
                            .toList())
                          Text(
                              '${index + 1}위.\t${_menuData[index].name}\t(${(_menuData[index].count / _sum * 100).toStringAsFixed(2)}%, ${_menuData[index].count}개)',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))
                      ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                        Text('<거지왕>',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(top: 7.0, bottom: 7.0))
                      ] +
                      [
                        for (final index in Iterable<int>.generate(
                                _menuData.length >= 3 ? 3 : _menuData.length)
                            .toList())
                          Text(
                              '${index + 1}위.\t${_menuData[_menuData.length - index - 1].name}\t(${(_menuData[_menuData.length - index - 1].count / _sum * 100).toStringAsFixed(2)}%, ${_menuData[_menuData.length - index - 1].count}개)',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))
                      ],
                ),
              ),
            ],
          )
        : Container();
  }
}

class MenuData {
  String name;
  int count;

  MenuData(this.name, this.count);

  @override
  String toString() {
    return '{ ${this.name}, ${this.count} }';
  }
}
