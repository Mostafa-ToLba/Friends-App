
import 'package:flutter/material.dart';

class userModel {
   final int id;
   final String name;
   final String phone;

  userModel({
    required this.id ,
    required this.name,
    required this.phone,
  });
}


class Users extends StatelessWidget {
   Users({Key? key}) : super(key: key);

  List<userModel> users = [
    userModel(
      id: 1,
      name: 'Mostafa Mahmoud Mohamed Tolba',
      phone: '01090964348',
    ),
    userModel(
      id: 2,
      phone: '01032345343',
      name: 'Mohamed Ahmed Ali',
    ),
    userModel(
      id: 3,
      name: 'Khaled ahmed ragab',
      phone: '01123953343'
    ),
    userModel(
        id: 4,
        name: 'amr ahmed ragab',
        phone: '012233953343',
    ),
    userModel(
      id: 4,
      name: 'amr ahmed ragab',
      phone: '012233953343',
    ),
    userModel(
      id: 4,
      name: 'amr ahmed ragab',
      phone: '012233953343',
    ),
    userModel(
      id: 4,
      name: 'amr ahmed ragab',
      phone: '012233953343',
    ),
    userModel(
      id: 4,
      name: 'amr ahmed ragab',
      phone: '012233953343',
    ),
    userModel(
      id: 4,
      name: 'amr ahmed ragab',
      phone: '012233953343',
    ),
    userModel(
      id: 4,
      name: 'amr ahmed ragab',
      phone: '012233953343',
    ),
    userModel(
      id: 4,
      name: 'amr ahmed ragab',
      phone: '012233953343',
    ),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: Text('Users Phone', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.separated(
          itemBuilder:(context , index ) =>buildUsersItem(users[index]) ,
          separatorBuilder: (context , index ) => Container(
            color: Colors.grey[300],
                width: double.infinity,
            height: 1.0,
          ),
          itemCount:users.length ),
    );
  }

  Widget buildUsersItem(userModel user) => Padding(
        padding: const EdgeInsets.all(22.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 25.0,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.phone}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
