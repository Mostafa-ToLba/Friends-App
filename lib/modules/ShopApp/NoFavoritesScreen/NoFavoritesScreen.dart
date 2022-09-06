
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/shopAppLayout/ShopLayout/ShopLayout.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/cubit.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/states.dart';
import 'package:mostafa1/modules/ShopApp/products_screen/products_screen.dart';
import 'package:mostafa1/shared/components/components.dart';

class NoFavScreen extends StatelessWidget {
   const NoFavScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
       listener: (BuildContext context, state) {
       },
       builder: (BuildContext context, Object? state) {
         return Scaffold(
           appBar: AppBar(
             title: IconButton(icon: Icon(Icons.arrow_back_ios),
               onPressed: ()
               {
                 NavigateAndFinsh(context, ShopLayoutScreen());

               },
             ),
           ),
           body:   Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(
                   Icons.favorite_border_outlined,
                   size: 150,
                   color: Colors.red,
                 ),
                 SizedBox(height: 10,),
                 Text('There Is No Favorites Yet,',
                   style: TextStyle(
                       color: Colors.grey,
                       fontSize: 25
                   ),),
               ],
             ),
           ),
         );
       },
     );
   }
 }
