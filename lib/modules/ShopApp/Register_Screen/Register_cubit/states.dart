
import 'package:mostafa1/model/ShopLoginModel/ShopModel.dart';

abstract class ShopRegisterCubitStates {}

class ShopRegisterCubitInitialState extends ShopRegisterCubitStates {}

class ShopRegisterCubitSuccessState extends ShopRegisterCubitStates {
  ShopRegisterCubitSuccessState(ShopLoginUserModel? userRegister);
}

class ShopRegisterCubitErrorState extends ShopRegisterCubitStates {
  final error;
  ShopRegisterCubitErrorState(this.error);
}
class ShopRegisterCubitLoadingState extends ShopRegisterCubitStates {}

class ShopRegisterCubitChangeSuffixState extends ShopRegisterCubitStates {}
