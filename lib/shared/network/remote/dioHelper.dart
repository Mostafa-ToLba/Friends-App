
 import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DioHelper {
  static Dio? dio;

  static Init() {
    dio = Dio(
      BaseOptions(
        //'https://newsapi.org/'
        //'https://student.valuxapps.com/api/'
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),

    );
  }

  static Future<Response> GetData(
      {@required String? url,  Map<String, dynamic>? query,
        dynamic lang = 'en',
        dynamic token,}) async {
    dio!.options.headers=
    {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',

    };
    return await dio!.get(url!, queryParameters: query,);
  }

  static Future<Response>? PostData({@required String? url,
    Map<String, dynamic>? query,
    @required Map<String, dynamic>? data,
    dynamic lang = 'en',
    dynamic token,
  }) async {
    dio!.options.headers =
    {
      'Content-Type': 'application/json',
      'lang': lang,
        'Authorization': token??'',
    } ;

    return dio!.post(url!, queryParameters: query, data: data,);
  }



  static Future<Response>? PutData({@required String? url,
    Map<String, dynamic>? query,
    @required Map<String, dynamic>? data,
    dynamic lang = 'en',
    dynamic token,
  }) async {
    dio!.options.headers =
    {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    } ;

    return dio!.put(url!, queryParameters: query, data: data,);
  }

}
