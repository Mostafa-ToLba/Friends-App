import 'package:flutter/material.dart';

class SocialPhotoChatOpen extends StatelessWidget {
  String chatImage;


  SocialPhotoChatOpen(String this.chatImage,   {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image(image: NetworkImage('${chatImage}'),)
    );
  }
}
