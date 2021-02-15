import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:pos/src/blocs/do_bloc.dart';
import 'package:pos/src/blocs/do_bloc_provider.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/models/user.dart';
import 'package:pos/src/utils/strings.dart';

class StatsScreen extends StatefulWidget {
  final String _phone;

  StatsScreen(this._phone);

  @override
  _StatsState createState() {
    return _StatsState();
  }
}

class _StatsState extends State<StatsScreen> {
  DoBloc _bloc;
  DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime(2019, 2, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
  DateTime _targetDateTime = DateTime(2019, 2, 3);

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
    return SingleChildScrollView(
        child: ExpansionTile(
            initiallyExpanded: true,
            title: Text('달력'),
            children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) {
                this.setState(() => _currentDate = date);
              },
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
              customDayBuilder: (
                /// you can provide your own build function to make custom day containers
                bool isSelectable,
                int index,
                bool isSelectedDay,
                bool isToday,
                bool isPrevMonthDay,
                TextStyle textStyle,
                bool isNextMonthDay,
                bool isThisMonthDay,
                DateTime day,
              ) {
                /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                /// This way you can build custom containers for specific days only, leaving rest as default.

                // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: [6, 7].contains(day.weekday)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'asd',
                        ),
                      )
                    ]);
              },
              weekFormat: false,
              markedDatesMap: _markedDateMap,
              height: 420.0,
              selectedDateTime: _currentDate,
              daysHaveCircularBorder: false,

              /// null for not rendering any border, true for circular border, false for rectangular border
            ),
          )
        ]));
    // return StreamBuilder(
    //     stream: _bloc.getReceipt(widget._phone),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         if (snapshot.data.docs.length != 0)
    //           return _buildList(context, snapshot.data.docs);
    //         else
    //           return Center(child: Text(StringConstant.noStats));
    //       } else
    //         return CircularProgressIndicator();
    //     });
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
              // Text(getDate(_r),
              //     style: new TextStyle(
              //       fontSize: 20.0,
              //     )),
              // Text(getContent(_r),
              //     style: new TextStyle(
              //       fontSize: 20.0,
              //     )),
              // Text(
              //   getPrice(_r),
              //   style: new TextStyle(
              //     fontSize: 20.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // )
            ],
          ),
          children: <Widget>[
            // _buildExpandableContent(_r),
          ],
        );
      },
    );
  }

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );
}
