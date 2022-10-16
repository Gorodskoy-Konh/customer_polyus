import 'dart:convert';

import 'package:customer_web/models/transport.dart';

import '../models/customer.dart';
import 'package:http/http.dart' as http;

import '../models/order.dart';

class ApiMethods{
  static List<Transport> parseStringToTransportList(String s){
    final List json = jsonDecode(s);
    // print(json[15]);
    // final transport = Transport.fromJson(json[15]);
    // print(transport);
    // List<Transport> transportList = json.map((e) => Transport.fromJson(e)).toList();
    List<Transport> transportList = [];
    for (int i = 0; i < json.length; i++){
      try{
        transportList.add(Transport.fromJson(json[i]));
      }catch(e){
        print(json[i]);
        print(i);
      }
    }
    return transportList;
  }

  static List<Order> parseStringToOrderList(String s){
    final List json = jsonDecode(s);
    List<Order> orderList = [];
    for (int i = 0; i < json.length; i++){
      try{
        orderList.add(Order.fromJson(json[i]));
        print(orderList[i]);
      }catch(e){
        print(json[i]);
        print(i);
      }
    }
    return orderList;
  }

  static const String _mainAPI = 'http://192.168.137.1:3000/';

  static Future<bool> register(Customer customer) async{
    final uri = Uri.parse('${_mainAPI}register');
    final headers = {"Content-Type":"application/json"};
    final body = jsonEncode(customer.toJson());
    final response = await http.post(uri, headers: headers, body: body);
    var answer = jsonDecode(response.body);
    if (answer['error'] == true){
      return false;
    } else{
      return true;
    }
  }

  static Future<bool> login(Customer customer) async{
    final uri = Uri.parse('${_mainAPI}login');
    final headers = {"Content-Type":"application/json"};
    final body = jsonEncode(customer.toJson());
    final response = await http.post(uri, headers: headers, body: body);
    var answer = jsonDecode(response.body);
    if (answer['error'] == true){
      return false;
    } else{
      return true;
    }
  }
}