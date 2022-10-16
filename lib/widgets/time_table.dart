import 'dart:convert';

import 'package:customer_web/models/transport.dart';
import 'package:customer_web/web/api_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timetable/flutter_timetable.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/order.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key, this.transport}) : super(key: key);
  final Transport? transport;

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.137.1:9000'),
  );

  @override
  void initState() {
    channel.sink.add(jsonEncode({"select": true, "data": ""}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.transport != null) {
      print('!');
      channel.sink.add(
          jsonEncode({"select": true, "data": widget.transport!.toJson()}));
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromRGBO(255, 255, 255, 0.85),
      ),
      margin: const EdgeInsets.all(25),
      child: StreamBuilder(
        stream: channel.stream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            List<TimetableItem<String>> list = []; // For Timetable(old)
            List<Order> orders =
                ApiMethods.parseStringToOrderList(snapshot.data);
            for (int i = 0; i < orders.length; i++) {
              list.add(TimetableItem(orders[i].begin, orders[i].end,
                  data: 'Ordered'));
            }
            return Timetable<String>(
              items: list,
              cellBuilder: (datetime) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 0.2),
                ),
                child: Center(
                  child: Text(
                    DateFormat("MM/d/yyyy\nha").format(datetime),
                    style: TextStyle(
                      color: Color(0xff000000 +
                              (0x002222 * datetime.hour) +
                              (0x110000 * datetime.day))
                          .withOpacity(0.5),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              cornerBuilder: (datetime) => Container(
                color: Colors.accents[datetime.day % Colors.accents.length],
                child: Center(child: Text("${datetime.year}")),
              ),
              headerCellBuilder: (datetime) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 2)),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat("E\nMMM d").format(datetime),

                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              hourLabelBuilder: (time) {
                final hour = time.hour == 12 ? 12 : time.hour % 12;
                final period = time.hour < 12 ? "am" : "pm";
                final isCurrentHour = time.hour == DateTime.now().hour;
                return Text(
                  "$hour$period",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        isCurrentHour ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              },
              itemBuilder: (item) => Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(220),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Center(
                  child: Text(
                    item.data ?? "",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              nowIndicatorColor: Colors.red,
              snapToDay: true,
            );
          } else {
            return const Center(
              child: Text(
                'Выберете транспорт',
                style: TextStyle(
                  fontSize: 35,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

/*

 */
