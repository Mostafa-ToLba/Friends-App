import 'package:flutter/material.dart';

class SocialCommentPhotoOpen extends StatelessWidget {
  var commnetPhoto;



  SocialCommentPhotoOpen(this.commnetPhoto,  {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image(image: NetworkImage('${commnetPhoto}'),)
    );
  }
}
