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

  final ScrollController _scrollController = ScrollController();

  int _currentPage  = 1;

  @override
  void initState() {
    super.initState();
    _loadMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels  ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MasonryGridView.count(

          controller: _scrollController,
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
      )
    );
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreData() async {
   var res = await PhotoService.getPhotos(_currentPage);
   res.fold((l) {
     EasyLoading.showError(l);
   }, (r) {
     setState(() {
       photoList.addAll(r);
       _currentPage++;
     });
     return photoList;
   });
  }
}


