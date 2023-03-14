import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../core/dio/dio_error_exception.dart';
import '../utils/log_service.dart';
import 'package:path/path.dart' as path;


class DownloadImageService{

  static Future<Either<String, bool>?> downloadImage(String url) async {
    try {
      Response response = await Dio().get(url,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          response.data as Uint8List,
          quality: 60,
          name: getImageName(url));

     Log.w(result['isSuccess'].toString());
      if(result['isSuccess']){
        return right(true);
      }else{
        return left('Something is wrong');
      }
    } on DioError catch (e) {
      Log.e( e.toString());

      return left(DioExceptions.fromDioError(e).toString());
    } catch (m) {
      Log.e( m.toString());
      return left(m.toString());
    }
  }
}



String getImageName(String imageUrl) {
  return path.basename(imageUrl);
}