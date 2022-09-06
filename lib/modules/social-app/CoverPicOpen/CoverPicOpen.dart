

import 'package:flutter/material.dart';

class CoverPicOpen extends StatelessWidget {
  String posterCover;


  CoverPicOpen(String this.posterCover, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image(image: NetworkImage('${posterCover}'),)
    );
  }
}