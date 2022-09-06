import 'package:flutter/material.dart';

class ProfilePicOpen extends StatelessWidget {
  var profilePic;



  ProfilePicOpen(this.profilePic,  {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image(image: NetworkImage('${profilePic}'),)
    );
  }
}
