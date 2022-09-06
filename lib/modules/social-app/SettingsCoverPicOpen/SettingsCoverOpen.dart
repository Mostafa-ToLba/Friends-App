
import 'package:flutter/material.dart';

class SettingsCoverPicOpen extends StatelessWidget {
  var CoverPic;



  SettingsCoverPicOpen(this.CoverPic,  {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image(image: NetworkImage('${CoverPic}'),)
    );
  }
}