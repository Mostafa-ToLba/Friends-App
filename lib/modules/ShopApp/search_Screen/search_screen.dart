import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/model/SearchModel/SearchModel.dart';
import 'package:mostafa1/modules/ShopApp/search_Screen/searchCubit/searchCubit.dart';
import 'package:mostafa1/modules/ShopApp/search_Screen/searchCubit/searchStates.dart';
import 'package:mostafa1/shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopSearchCubit(ShopSearchCubitInitialState()),
      child: BlocConsumer<ShopSearchCubit,ShopSearchCubitStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defultformfield(
                    prefix:  Icons.search,
                    label: 'Search',
                    keyboard: TextInputType.text,
                    onfieldsubmite: (String text)
                    {
                      ShopSearchCubit.get(context).getSearch(text);
                    }
                  ),
                ),
                SizedBox(height: 20,),
                if(state is ShopSearchCubitLoadingState)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                if(ShopSearchCubit.get(context).searchModel!=null)
                Expanded (
                  child: ListView.separated(itemBuilder: (context,index)=>BultSearchItem(ShopSearchCubit.get(context).searchModel!.data!.data![index]) ,
                      separatorBuilder: (context,index)=> Container(
                        height: 2,
                        color:Colors.grey,
                      ),
                      itemCount: ShopSearchCubit.get(context).searchModel!.data!.data!.length),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget BultSearchItem(Product data)=> Padding(
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
                image: NetworkImage("${data.image}"),),
              if(data.discount!=0&&data.discount!=null)
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
                  '${data.name}',
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
                      '${data.price}',
                      style:TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color :Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if(data.discount!=0 &&data.oldPrice!=null)
                      Text(
                        '${data.oldPrice}',
                        style:TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color :Colors.grey,
                        ),
                      ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}