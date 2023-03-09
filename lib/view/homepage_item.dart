import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest_flutter/model/photo_model.dart';

Widget HomeItem(BuildContext context, PhotoModel post){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      FadeInImage(
        image: NetworkImage(post.urls.small),
        placeholder: const AssetImage('assets/back.png'),
        width: MediaQuery.of(context).size.width,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.favorite, color: Colors.red,size: 20,),
              Text(post.likes.toString())

            ],
          ),
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      Text(post.altDescription??'',
          maxLines: 2)

    ],
  );
}