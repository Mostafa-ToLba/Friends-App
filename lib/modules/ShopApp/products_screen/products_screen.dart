
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/cubit.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/states.dart';
import 'package:mostafa1/model/ShopCategoriesModel/CategoriesModel.dart';
import 'package:mostafa1/model/shopHomeModel/homeModel.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>
      (listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
        condition: ShopLayoutCubit.get(context).homeModel!=null && ShopLayoutCubit.get(context).categoriesModel!=null ,
       // builder: (context)=> ProductsBuilder(ShopLayoutCubit.get(context).homeModel!,ShopLayoutCubit.get(context).categoriesModel!,context) ,
          fallback: (context)=> Center(child: CircularProgressIndicator()), builder: (BuildContext context) { return Container();},
        );
    },
    );

  }

  Widget? ProductsBuilder(HomeModel model,CategoriesModel categoriesModel,context)=> SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
            items: model.data!.banners.map((e) => Image(
              fit: BoxFit.cover,
              width: double.infinity,

              image: NetworkImage(
                '${e.image}',
              ),
            ),
            ).toList(),
            options:CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              initialPage: 0,
              autoPlayInterval: Duration(seconds: 5),
              reverse: false,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: true,
              pageSnapping: true,

            )),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>BuldCategoriesItem(categoriesModel.data!.data![index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 11,),
                    itemCount: categoriesModel.data!.data!.length),
              ),
              SizedBox(
                height:20,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),

            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(crossAxisCount: 2,
            childAspectRatio: 1/1.59,
             crossAxisSpacing:1 ,
             mainAxisSpacing:1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children:List.generate(model.data!.products.length, (index) => BuildGridProduct(model.data!.products[index],context) )

          ),
        )
      ],
    ),
  );

  Widget BuildGridProduct(ProductModel model,context)=>Container(
    color:Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          children: [
            Image(
              height: 200,
              width: double.infinity,
              alignment: Alignment.topCenter,

              image: NetworkImage(model.image!),),
            if(model.discount!=0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                style: TextStyle(
                  height: 1.2,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),

              ),
              Row(
                children: [
                  Text(
                    '${model.price}',
                   style:TextStyle(
                      fontSize: 15,
                     fontWeight: FontWeight.bold,
                     color :Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount!=0)
                  Text(
                    '${model.old_price}',
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
                        ShopLayoutCubit.get(context).changeFavorites(model.id!);
                      },
                      icon:
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: ShopLayoutCubit.get(context).Favorites[model.id!]! ? Colors.red:Colors.grey,
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
  );
    Widget BuldCategoriesItem(DataModell model)=>Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 120,
          width: 120,
        ),
        Container(
          color: Colors.black.withOpacity(.5),
          width: 120,
          height: 25,
         child: Text(
     '${model.name}',
    textAlign: TextAlign.center,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 16,
     fontWeight: FontWeight.w600,
           color: Colors.white,
     ),
    ),
        ),
      ],
    );
}