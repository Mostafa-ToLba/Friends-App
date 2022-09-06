
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/shared/bloc_newsApp/newsAppBloc.dart';
import 'package:mostafa1/shared/bloc_newsApp/newsAppStates.dart';
import 'package:mostafa1/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
    SearchScreen({Key? key}) : super(key: key);
   var SearchControle=TextEditingController();
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<NewsCubit,NewsCubitStates>(
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object? state) {
         return Scaffold(
           appBar: AppBar(),
           body: Column(
             children: [
               defultformfield(
                   textStyle: Theme.of(context).textTheme.subtitle1,
                   controle: SearchControle,
                   label: 'Search',
                   validate: (value)
                   {
                     if(value.isEmpty)
                     {
                       return'Search Must Not Be Empty';
                     }else
                       return null;
                   },
                   prefix: Icons.search,
                   keyboard: TextInputType.text,
                   onchange: (String value)
                   {
                     NewsCubit.get(context).getSearch(value);
                     if(value.isEmpty)
                       NewsCubit.get(context).Search=[];
                   }
               ),
               SizedBox(
                 height: 5,
               ),
               Expanded(child: BuildNewsListWithCondtionalBilder(NewsCubit.get(context).Search,context,isSearch: true)),


             ],
           ),
         );
       },

     );
   }
 }
