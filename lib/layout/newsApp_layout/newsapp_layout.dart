
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/modules/NewsApp/SearchScreen/search_screen.dart';
import 'package:mostafa1/shared/bloc_newsApp/newsAppBloc.dart';
import 'package:mostafa1/shared/bloc_newsApp/newsAppStates.dart';


class NewsAppLayout extends StatelessWidget {
    const NewsAppLayout({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return BlocConsumer<NewsCubit,NewsCubitStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state)
        {
          var cubit = NewsCubit.get(context) ;
         return Scaffold(
            appBar: AppBar(
              titleSpacing: 17,
              title: Text(
                'NewsApp',
              ),
              actions: [
                IconButton(onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                },
                  icon: Icon(
                  Icons.search,
                ),
                )
              ],
            ),
            body: cubit.Screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(items:
              cubit.BottomNavIcons,
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeNavBar(index);
              },
           ),
          );
        }
      );
    }
  }