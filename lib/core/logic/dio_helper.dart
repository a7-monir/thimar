import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl:'https://thimar.amr.aait-d.com/public/api/' ,
        receiveDataWhenStatusError: true,

      )
    );
  }


  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String lang ='ar',
    String? token,
  }

  ) async
  {
    dio!.options=BaseOptions(
        headers: {
          'lang':lang,
          'token':token
        }
    );
   return await dio!.get(url,queryParameters:query);
  }


  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang ='ar',
    String? token,
  }) async
  {
    dio!.options.headers={
      'lang':lang,
      'token':token
    };
    return await dio!.post(
        url,
        queryParameters:query,
      data: data,
    );
  }
}



