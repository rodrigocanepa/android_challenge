import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpServices{

  Future<Map<String, dynamic>> getData(String url) async{
    http.Response response = await http.get(
        Uri.parse(url),
    );

    final responseStatus = response.statusCode;
    final responseJson = jsonDecode(response.body);
    print(responseJson);
    Map<String, dynamic> data = {
      'status': responseStatus,
      'body': responseJson
    };
    return data;
  }
}