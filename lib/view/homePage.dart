import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_flutter/service/photo_service.dart';
import 'package:pinterest_flutter/utils/log_service.dart';

import '../model/photo_model.dart';
import 'homepage_item.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<PhotoModel> photoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: PhotoService.getPhotos(),
        builder: (ctx,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            EasyLoading.show();
            return const SizedBox();
          }else if (snapshot.hasData) {
            snapshot.data?.fold((l) {
              EasyLoading.showError(l);
            }, (r) {
              EasyLoading.dismiss();
              photoList = r;
            });
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: photoList.length,
                itemBuilder: (context, index) {
                  return HomeItem(
                    context,
                    photoList[index],
                    // index: index,
                    // extent: (index % 5 + 1) * 100,
                  );
                },
              ),
            );
          }
          else  {
            return Text("Error: ${snapshot.error}");
          }
        })
    );
  }
}
