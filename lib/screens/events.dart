import 'package:bits_news/component/constants.dart';
import 'package:bits_news/modals/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final styles = Provider.of<CustomStyles>(context);
    final ScrollController _scrollController = ScrollController();
    return SafeArea(
      child: SingleChildScrollView(
          // physics: ScrollPhysics(parent: ),
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        height: styles.imageSize,
                        width: styles.imageSize,
                        image: AssetImage('assets/png/event.png')),
                    Text('Event',
                        style: TextStyle(fontSize: 42, color: korgShade3)),
                    SizedBox(width: 50)
                  ]),
              Calender(),
            ],
          )),
    );
  }
}

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarController _calendarController;

  _CalenderState();
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Color(0x30000000), offset: Offset(0, 0), blurRadius: 16)
        ],
      ),
      child:
          Center(child: TableCalendar(calendarController: _calendarController)),
    );
  }
}
