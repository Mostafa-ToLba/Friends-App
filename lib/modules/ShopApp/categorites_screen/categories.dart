
 import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/cubit.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/states.dart';
import 'package:mostafa1/model/ShopCategoriesModel/CategoriesModel.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
    listener: (BuildContext context, state) {  },
    builder: (BuildContext context, Object? state) {
      return ListView.separated(
        physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => BuildCategoryItem(ShopLayoutCubit.get(context).categoriesModel!.data!.data![index]),
          separatorBuilder: (context, index) => Container(
                height: 2,
                color: Colors.grey,
              ),
          itemCount: ShopLayoutCubit.get(context).categoriesModel!.data!.data!.length);
    }
    );
}

  Widget BuildCategoryItem(DataModell modell)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(image:
        NetworkImage('${modell.image}'),
          height: 100,
          width: 100,
        ),
        SizedBox(width: 20,),
        Text(
          '${modell.name}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),

        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 30,
        ),

      ],
    ),
  );
}