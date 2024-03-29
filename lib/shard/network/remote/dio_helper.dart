
import 'package:consultme/components/components.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:consultme/moduls/login/cubit/cubit.dart';


import '../end_point.dart';

class DioHelper{
  static late Dio dio;

  static init(){
      dio = Dio(
        BaseOptions(
          baseUrl: BASE_URL,
          receiveDataWhenStatusError: true,
          connectTimeout: 10000,
          receiveTimeout: 10000,
        ),
      );

  }

  static Future<Response?> postData({
    required String url,
    required var data,
    String? token,
  })async
  {

    try{
      return await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : 'Bearer ${token??''}'
          },
        ),
      );
    }on DioError catch(e){
      var message =  e.response!.data['message'].toString();
      showToast(message: message, state: ToastStates.ERROR);
    }

  }



  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  })async
  {
    try{
      return await dio.get(
        url,
        queryParameters: query ,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : 'Bearer ${token??''}',
          },

        ),
      );
    }on DioError catch(e){
      var message =  e.response!.data.toString();
      showToast(message: message, state: ToastStates.ERROR);
    }

  }



  static Future<Response?> putData({
    required String url,
    required var data,
    Map<String, dynamic>? query,
    String? token,
  })async
  {
    try{
      return await dio.put(
        url,
        data: data,
        queryParameters: query,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : 'Bearer ${token??''}'
          },
        ),
      );
    }on DioError catch(e){
      var message =  e.response!.data['message'].toString();
      showToast(message: message, state: ToastStates.ERROR);
    }

  }


  static Future<Response?> patchData({
    required String url,
    required var data,
    String? token,
  })async
  {
    try{
      return await dio.patch(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : 'Bearer ${token??''}'
          },
        ),
      );
    }on DioError catch(e){
      var message =  e.response!.data['message'].toString();
      showToast(message: message, state: ToastStates.ERROR);
    }

  }



  static Future<Response?> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  })async
  {
    try{
      return await dio.delete(
        url,
        data: data,
        queryParameters: query,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : 'Bearer ${token??''}'
          },
        ),
      );
    }on DioError catch(e){
      var message =  e.response!.data['message'].toString();
      showToast(message: message, state: ToastStates.ERROR);
    }

  }

}