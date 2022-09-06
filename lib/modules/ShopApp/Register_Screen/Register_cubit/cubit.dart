import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/model/ShopLoginModel/ShopModel.dart';
import 'package:mostafa1/modules/ShopApp/Register_Screen/Register_cubit/states.dart';
import 'package:mostafa1/shared/network/endPoint/endPoint.dart';
import 'package:mostafa1/shared/network/remote/dioHelper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterCubitStates>
{
  ShopRegisterCubit(ShopRegisterCubitStates ShopLRegisterInitialState) : super(ShopRegisterCubitInitialState());


  static ShopRegisterCubit get(context)=> BlocProvider.of(context);


  ShopLoginUserModel? userRegister ;

  UserRegister({
    @required String? Email,
    @required String? Password,
    @required String? phone,
    @required String? name,

  })
  {

    emit(ShopRegisterCubitLoadingState());
    DioHelper.PostData(url:Register,
     data:
    {
      'name':name,
      'email':Email,
      'password':Password,
      'phone':phone,
    },
    )!.then((value)
    {
        userRegister =ShopLoginUserModel.fromJson(value.data);
      emit(ShopRegisterCubitSuccessState(userRegister));

    }).catchError((error)
    {
      emit(ShopRegisterCubitErrorState(error));
      print(error.toString());
    }
    );
  }

  bool UnvisibleBassword=true ;
  IconData Suffix= Icons.visibility_off_rounded ;
  ChangeSuffix () {
    UnvisibleBassword = !UnvisibleBassword;
    UnvisibleBassword ? Suffix= Icons.visibility_off_rounded : Suffix =Icons.remove_red_eye_outlined;
    emit(ShopRegisterCubitChangeSuffixState());
  }
}




