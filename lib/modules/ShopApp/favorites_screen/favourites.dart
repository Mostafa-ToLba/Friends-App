
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/cubit.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/states.dart';
import 'package:mostafa1/model/GetFavoritesModel/getFavorites.dart';


class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>
    (listener: (BuildContext context, state) {  },
    builder: (BuildContext context, Object? state) {
      return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildFavoriteItem(ShopLayoutCubit.get(context).favoritesModel!.data!.data![index], context),
            separatorBuilder: (context, index) => Container(
                  height: 2,
                  color: Colors.grey,
                ),
            itemCount: ShopLayoutCubit.get(context).favoritesModel!.data!.data!.length);
    }
    );
}

Widget buildFavoriteItem(Dataaa data,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          children: [
            Image(
              width: 150,
              height:130,
              alignment: Alignment.topCenter,
              image: NetworkImage("${data.product!.image}"),),
            if(data.product!.discount!=0)
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text('DISCOUNT',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),)),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${data.product!.name}',
                maxLines: 2,
                style: TextStyle(
                  height: 1.2,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),

              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${data.product!.price}',
                    style:TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color :Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(data.product!.discount!=0)
                    Text(
                      '${data.product!.oldPrice}',
                      style:TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color :Colors.grey,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: ()
                      {
                        ShopLayoutCubit.get(context).changeFavorites(data.product!.id!);
                      },
                      icon:
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: ShopLayoutCubit.get(context).changeFavoritesModel!.status! ? Colors.red:Colors.grey,
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                          size: 25,

                        ),
                      )
                  )
                ],
              ),

            ],
          ),
        ),
      ],
    ),
  ),
) ;
}