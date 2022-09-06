
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/cubit.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/states.dart';
import 'package:mostafa1/modules/NewsApp/SearchScreen/search_screen.dart';
import 'package:mostafa1/modules/ShopApp/OnBoarding_Screen/Onboarding.dart';
import 'package:mostafa1/modules/ShopApp/search_Screen/search_screen.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';

class ShopLayoutScreen extends StatelessWidget {
   const ShopLayoutScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object? state) {
         return Scaffold(
           appBar: AppBar(
             title: Text('Little Shop'),
             actions:
             [
               IconButton(onPressed: ()
               {
                 NavigateTo(context, ShopSearchScreen());
               },
                   icon: Icon(
                       Icons.search,
                     size: 30,
                   )),
             ],
           ),
           body: ShopLayoutCubit.get(context).BottomScreens[ShopLayoutCubit.get(context).currentIndex],
           bottomNavigationBar: BottomNavigationBar
             (
             onTap: (index)
             {
               ShopLayoutCubit.get(context).ChangeNavBar(index,context);
             },
             currentIndex: ShopLayoutCubit.get(context).currentIndex,
             items:
             [
               BottomNavigationBarItem(
                 icon:Icon(Icons.home),
                 label: 'Home',
               ),
               BottomNavigationBarItem(
                 icon:Icon(Icons.apps),
                 label: 'Categories',
               ),
               BottomNavigationBarItem(
                 icon:Icon(Icons.favorite),
                 label: 'Favourites',
               ),
               BottomNavigationBarItem(
                 icon:Icon(Icons.settings),
                 label: 'Settings',
               ),
             ],),
         );
       },
     );
   }
 }
