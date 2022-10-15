import 'dart:convert';

import 'package:customer_web/models/transport.dart';

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

}