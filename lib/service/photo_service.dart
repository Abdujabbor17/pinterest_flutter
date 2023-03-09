
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pinterest_flutter/model/photo_model.dart';
import '../core/dio/apis.dart';
import '../core/dio/dio_error_exception.dart';
import '../utils/log_service.dart';

class PhotoService{

  static Future<Either<String,List<PhotoModel>>> getPhotos() async{
    try{
      Response response = await Dio().get(
          Endpoints.getPhotos,
          options: Options(headers: {
            'x-api-key': Endpoints.apiKey,
            'Authorization': 'Bearer ${Endpoints.token}'
          })
      );
      Log.w(response.statusCode.toString());
      if(response.statusCode == 200 || response.statusCode == 201){
        List<PhotoModel> photos = [];
        for (var e in (response.data as List)) {
          photos.add(PhotoModel.fromJson(e));
        }
        return right(photos);
      }else{
        Log.e( DioExceptions.fromDioError(response.data).toString());
        return left(DioExceptions.fromDioError(response.data).toString());
      }
    } on DioError catch (e) {
      Log.e( e.toString());
      if(DioExceptions.fromDioError(e).toString() == 'Unauthorized'){
        return left('Token xatoo');
      }
      return left(DioExceptions.fromDioError(e).toString());
    } catch (m) {
      Log.e( m.toString());
      return left(m.toString());
    }
  }


}