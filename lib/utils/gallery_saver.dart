
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';

import '../service/download_image_service.dart';
import 'get_permission.dart';
import 'log_service.dart';

Future<void> saveGallery(String url) async {
  EasyLoading.show();
  if(Platform.isAndroid){
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var androidInfo = await deviceInfo.androidInfo;
    var release = androidInfo.version.release;
    if (int.parse(release!) <= 10) {
      if(await requestPermission(Permission.storage)){

        var res = await DownloadImageService.downloadImage(url);
        res?.fold((l) {
          EasyLoading.showError(l);
        }, (r){
          EasyLoading.showSuccess('Successfully download');
        });

      }
    } else {
      if(
      await requestPermission(Permission.manageExternalStorage) &&
          await requestPermission(Permission.accessMediaLocation)){
        Log.i('Downloading');
        var res = await DownloadImageService.downloadImage(url);
        res?.fold((l) {
          EasyLoading.showError(l);
        }, (r){
          EasyLoading.showSuccess('Successfully download');
        });
      }
    }
  }else if(Platform.isIOS){
    if (await requestPermission(Permission.photos)) {
      var res = await DownloadImageService.downloadImage(url);
      res?.fold((l) {
        EasyLoading.showError(l);
      }, (r){
        EasyLoading.showSuccess('Successfully download');
      });
    }
  }







}