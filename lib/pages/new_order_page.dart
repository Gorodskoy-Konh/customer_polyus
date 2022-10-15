import 'dart:convert';

import 'package:customer_web/web/api_methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/order.dart';
import '../models/transport.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> with RestorationMixin {
  final String _pathSvg = 'assets/page.png';
  final TextEditingController _comment = TextEditingController();

  Transport? _selectedTransport = null;

  List<Transport> transportList = [];
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.137.1:9000'),
  );

  @override
  void initState() {
    ///тут пиши
    channel.sink.add('{"type":"Transports"}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 108, 0, 0.25),
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.1),
        title: const Center(child: Text('Новый заказ')),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
      body: Stack(
        children: [
          // SvgPicture.asset(
          //   _pathSvg,
          //   fit: BoxFit.cover,
          // ),
          Image.asset(
            _pathSvg,
            fit: BoxFit.cover,
            width: 1920,
          ),

          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'Начало заказа',
                    style: TextStyle(color: Color.fromRGBO(255, 108, 0, 1)),
                  ),
                  subtitle:
                  Text(DateFormat.yMMMd().format(_selectedDate.value)),
                  onTap: () {
                    _restorableDatePickerRouteFuture.present();
                  },
                ),
                ListTile(
                  title: const Text(
                    'Конец заказа',
                    style: TextStyle(color: Color.fromRGBO(255, 108, 0, 1)),
                  ),
                  subtitle:
                  Text(DateFormat.yMMMd().format(_selectedFinalDate.value)),
                  onTap: () {
                    _restorableFinalDatePickerRouteFuture.present();
                  },
                ),

                const Divider(
                  thickness: 2,
                ),

                ///*****************************************************************

                ListTile(
                  title: StreamBuilder(
                    stream: channel.stream,
                    builder: (context, snapshot) {
                      // if (!snapshot.hasData) {
                      //   return Container(
                      //     width: 35,
                      //     height: 35,
                      //     alignment: Alignment.center,
                      //     margin: const EdgeInsets.all(20),
                      //     child: const CircularProgressIndicator(
                      //       color: Color.fromRGBO(255, 108, 0, 1),
                      //     ),
                      //   );
                      // }
                      // transportList =
                      //     ApiMethods.parseStringToTransportList(snapshot.data);
                      List<PopupMenuItem<Transport>> list = [];
                      for (int i = 0; i < transportList.length; i++) {
                        if (i > 0 &&
                            transportList[i].name ==
                                transportList[i - 1].name) {
                          continue;
                        }
                        list.add(PopupMenuItem(
                          value: transportList[i],
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          child: Text(
                              '${transportList[i].type}\n${transportList[i]
                                  .name}\n'),
                        ));
                        // if (i != transportList.length - 1){
                        //   list.add(PopupMenuDivider());
                        // }
                      }
                      // PopupMenu
                      return PopupMenuButton(
                        tooltip: '',
                        onSelected: (Transport newOne) {
                          _selectedTransport = newOne;
                          setState(() {});
                        },
                        itemBuilder: (context) {
                          return list;
                        },
                        child: const Text(
                          'Выберете транспорт',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(255, 108, 0, 1),
                          ),
                        ),
                      );
                    },
                  ),
                  subtitle: Text(
                      _selectedTransport == null ? '' : _selectedTransport!
                          .name),
                ),

                ///*****************************************************************
                TextField(
                  controller: _comment,
                  //TODO: Like their field
                  maxLines: 5,
                  minLines: 5,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Описание работы',
                    labelStyle: const TextStyle(
                      color: Color.fromRGBO(255, 108, 0, 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(255, 182, 53, 1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                ///Map here

                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 108, 0, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 130,
                  width: 350,
                  child: TextButton(
                    onPressed: () {
                      if (_selectedTransport == null) {
                        showDialog(context: context,
                          builder: (context){
                            return const AlertDialog(
                              title: Text('Не все поля выбраны'),

                            );
                          }
                        );
                      }
                      Order order = Order(id: "",
                          customerId: "123",
                          begin: _selectedDate.value,
                          end: _selectedFinalDate.value,
                          transportId: _selectedTransport!.id);
                      channel.sink.add('{"type":"Orders","data":"${jsonEncode(order.toJson())}"}');
                    },
                    child: const Text('Создать заказ', style: TextStyle(
                      fontSize: 35, color: Color.fromRGBO(255, 255, 255, 1),),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
      });
    }
  }

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime.now().add(const Duration(days: 1)));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(BuildContext context,
      Object? arguments) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now().add(const Duration(days: 1)),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );
      },
    );
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_selectedFinalDate, 'selected_final_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
    registerForRestoration(_restorableFinalDatePickerRouteFuture,
        'final_date_picker_route_future');
  }

  void _selectFinalDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedFinalDate.value = newSelectedDate;
      });
    }
  }

  final RestorableDateTime _selectedFinalDate =
  RestorableDateTime(DateTime.now().add(const Duration(days: 1)));
  late final RestorableRouteFuture<DateTime?>
  _restorableFinalDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
    onComplete: _selectFinalDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _finalDatePickerRoute,
        arguments: _selectedFinalDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _finalDatePickerRoute(BuildContext context,
      Object? arguments) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'final_date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now().add(const Duration(days: 1)),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );
      },
    );
  }
}
