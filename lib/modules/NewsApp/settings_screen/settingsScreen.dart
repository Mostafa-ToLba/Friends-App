
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostafa1/shared/Bloc_todoApp/bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: ()
        {
           AppCubit.get(context).MakeItDark();
           AppCubit.get(context).ChangeText();
        },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
              Icons.dark_mode,
            size: 70,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            '${AppCubit.get(context).textchange? 'Switch To Light Mode':'Switch To Dark Mode'}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),

      ),
    );
  }
}