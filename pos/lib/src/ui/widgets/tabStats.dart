import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/models/user.dart';
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
    Map<int, List<Receipt>> _receipts = <int, List<Receipt>>{};
    for (int i = 1;
        i <= DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
        i++) {
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
    return _buildCalendar(context, _receipts);
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    // print('CALLBACK: _onDaySelected');
    // setState(() {
    //   _selectedEvents = events;
    // });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onCalendarCreated');
  }

  _buildCalendar(BuildContext context, Map<int, List<Receipt>> _receipts) {
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
                child: _presentDay(date, _receipts),
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
              child: _presentDay(date, _receipts),
            );
          },
          dayBuilder: (context, date, _) {
            return Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0),
                color: Colors.transparent,
                width: 500,
                height: 500,
                child: _presentDay(date, _receipts));
          },
        ),
        onDaySelected: (date, events, holidays) {
          _onDaySelected(date, events, holidays);
          _animationController.forward(from: 0.0);
        },
        onVisibleDaysChanged: _onVisibleDaysChanged,
        onCalendarCreated: _onCalendarCreated,
      ),
      // ]),
      Text('sdfsdfsd'),
    ]));
  }

  _presentDay(DateTime date, Map<int, List<Receipt>> _receipts) {
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
              sumDay(_receipts[date.day], StringConstant.card),
              style: TextStyle(
                  // backgroundColor: Colors.blue,
                  color: Colors.blue),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              sumDay(_receipts[date.day], StringConstant.cash),
              style: TextStyle(
                  // backgroundColor: Colors.red,
                  color: Colors.red),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '',
              style: TextStyle(
                  // backgroundColor: Colors.red,
                  color: Colors.red),
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
      if (element.type == type) _temp += element.total;
    });
    return Funcs().numComma(_temp);
  }
}
