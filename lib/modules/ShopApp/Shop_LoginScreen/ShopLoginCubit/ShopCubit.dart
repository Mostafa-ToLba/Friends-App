import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/model/ShopLoginModel/ShopModel.dart';
import 'package:mostafa1/modules/ShopApp/Shop_LoginScreen/ShopLoginCubit/ShopStates.dart';
import 'package:mostafa1/shared/components/constants.dart';
import 'package:mostafa1/shared/network/endPoint/endPoint.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';
import 'package:mostafa1/shared/network/remote/dioHelper.dart';

 class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit(ShopLoginStates ShopLoginInitialState) : super(ShopLoginInitialState);


  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  ShopLoginUserModel? userLogin ;
  
  getUserData({
    @required String? Email,
    @required String? Password,
  })
  {
    emit(ShopLoginLoadingState());
    DioHelper.PostData(url:Login, token:token, data:
    {
      'email':Email,
      'password':Password,
    }
    )!.then((value)
    {
      userLogin =ShopLoginUserModel.fromJson(value.data);
      emit(ShopLoginSuccessState(userLogin));
    }).catchError((error)
    {
      emit(ShopLoginErrorState(error.toString()));
      print(error);
    }
    );

  }

  bool UnvisibleBassword=true ;
  IconData Suffix= Icons.visibility_off_rounded ;
  ChangeSuffix () {
    UnvisibleBassword = !UnvisibleBassword;
    UnvisibleBassword ? Suffix= Icons.visibility_off_rounded : Suffix =Icons.remove_red_eye_outlined;
    emit(ShopLoginChangeSuffixState());
  }
}




