
import 'package:mostafa1/model/ShopLoginModel/ShopModel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  ShopLoginSuccessState(ShopLoginUserModel? userLogin);
}

class ShopLoginErrorState extends ShopLoginStates {
  final error;

  ShopLoginErrorState(this.error);
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginChangeSuffixState extends ShopLoginStates {}

