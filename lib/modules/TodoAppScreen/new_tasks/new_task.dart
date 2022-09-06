
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/shared/Bloc_todoApp/bloc.dart';
import 'package:mostafa1/shared/Bloc_todoApp/states.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/components/constants.dart';


class NewTask extends StatelessWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,) {
    return BlocConsumer<AppCubit,BlocStates>
      (listener: ( context, state) {  },
      builder: ( context, Object? state) {
        return  ConditionalTaskBilder(
          tasks: AppCubit.get(context).newtasks,

        );
      },

    );
  }
}
