import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest_flutter/model/photo_model.dart';

import 'detail_page.dart';

Widget HomeItem(BuildContext context, PhotoModel post){
  return InkWell(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(item: post),
            maintainState: false),);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInImage(
          image: NetworkImage(post.urls != null ? post.urls?.small?? 'https://yandex.uz/images/search?source=morda&text=%D1%84%D0%BE%D1%82%D0%BE+%D1%8D%D0%BD%D1%86%D0%B5%D0%BB%D0%B0%D0%B4%D0%B0&pos=7&rpt=simage&img_url=http%3A%2F%2Favatars.dzeninfra.ru%2Fget-zen_doc%2F57035%2Fpub_5b4716e1c2be9800a82365c3_5b47171678c21800a90ab1d8%2Fscale_1200&nl=1&lr=10335&utm_source=main_stripe_big': 'https://yandex.uz/images/search?source=morda&text=%D1%84%D0%BE%D1%82%D0%BE+%D1%8D%D0%BD%D1%86%D0%B5%D0%BB%D0%B0%D0%B4%D0%B0&pos=7&rpt=simage&img_url=http%3A%2F%2Favatars.dzeninfra.ru%2Fget-zen_doc%2F57035%2Fpub_5b4716e1c2be9800a82365c3_5b47171678c21800a90ab1d8%2Fscale_1200&nl=1&lr=10335&utm_source=main_stripe_big'),
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
    ),
  );
}