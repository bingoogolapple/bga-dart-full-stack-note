import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpUtil {
  static Future<String> asyncGet(String current) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(current));
    var response = await request.close();
    return await response.transform(utf8.decoder).join();
  }

  static void get(String url, Function successCallback, Function failureCallback) async {
    try {
      http.Response res = await http.get(url);
      if (successCallback != null) {
        successCallback(res.body);
      }
    } catch (exception) {
      if (failureCallback != null) {
        failureCallback(exception);
      }
    }
  }

  static void post(String url, Function successCallback, {Map<String, String> params, Function failureCallback}) async {
    try {
      http.Response res = await http.post(url, body: params);
      if (successCallback != null) {
        successCallback(res.body);
      }
    } catch (e) {
      if (failureCallback != null) {
        failureCallback(e);
      }
    }
  }
}
