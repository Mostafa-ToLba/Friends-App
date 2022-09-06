
 import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/model/SearchModel/SearchModel.dart';
import 'package:mostafa1/modules/ShopApp/search_Screen/searchCubit/searchStates.dart';
import 'package:mostafa1/shared/components/constants.dart';
import 'package:mostafa1/shared/network/endPoint/endPoint.dart';
import 'package:mostafa1/shared/network/remote/dioHelper.dart';

class ShopSearchCubit extends Cubit<ShopSearchCubitStates>{
  ShopSearchCubit(initialState) : super(initialState);

   static ShopSearchCubit get(context) => BlocProvider.of(context);

     GetSearchModel? searchModel;
  
  void getSearch(String text)
  {
    emit(ShopSearchCubitLoadingState());
    DioHelper.PostData(url: productsSearch, data:
    {
      'text':text,
    },
      token: token,
    )!.then((value)
    {
      searchModel = GetSearchModel.fromJson(value.data);
      emit(ShopSearchCubitSuccessState());

    }).catchError((error)
    {
      emit(ShopSearchCubitErrorState());
      print(error.toString());
    });
    
  }
}