

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/shared/bloc_newsApp/newsAppBloc.dart';
import 'package:mostafa1/shared/bloc_newsApp/newsAppStates.dart';
import 'package:mostafa1/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsCubitStates> (
      listener: (context,state){},
      builder: (context,state) {
        var list=NewsCubit.get(context).Sports;

        return BuildNewsListWithCondtionalBilder(list,context);
      },


    );
  }
}

