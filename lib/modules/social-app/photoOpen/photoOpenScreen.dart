import 'package:flutter/material.dart';

class SocialPhotoOpen extends StatelessWidget {
  String postImage;

   SocialPhotoOpen( this.postImage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: NetworkImage('${postImage}'),)
    );
  }
}
