
 import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/states.dart';
import 'package:mostafa1/model/ChangeFavoritesModel/ChangeFavoritesModel.dart';
import 'package:mostafa1/model/GetFavoritesModel/getFavorites.dart';
import 'package:mostafa1/model/ShopCategoriesModel/CategoriesModel.dart';
import 'package:mostafa1/model/ShopLoginModel/ShopModel.dart';
import 'package:mostafa1/model/shopHomeModel/homeModel.dart';
import 'package:mostafa1/modules/ShopApp/NoFavoritesScreen/NoFavoritesScreen.dart';
import 'package:mostafa1/modules/ShopApp/Shop_LoginScreen/ShopLoginCubit/ShopCubit.dart';
import 'package:mostafa1/modules/ShopApp/categorites_screen/categories.dart';
import 'package:mostafa1/modules/ShopApp/favorites_screen/favourites.dart';
import 'package:mostafa1/modules/ShopApp/products_screen/products_screen.dart';
import 'package:mostafa1/modules/ShopApp/settings_Screen/settings_screen.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/components/constants.dart';
import 'package:mostafa1/shared/network/endPoint/endPoint.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';
import 'package:mostafa1/shared/network/remote/dioHelper.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit(initialState) : super(initialState);

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget>BottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void ChangeNavBar(index,context) {
    currentIndex = index;
    emit(ChangeShopBottomNavState());
    if(currentIndex==2)
    {
      getNoVaforites(context);
      changeFavorites(context);
      emit(noFavoritesState());
    }
      getProfileData();
  }

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map < int? ,bool?>Favorites={};
    late ChangeFavoritesModel? changeFavoritesModel;
    GetFavoritesModel? favoritesModel ;
    ShopLoginUserModel? profileData;

  void getHomeData() {
    emit(GetHomeDataloadingState());
    DioHelper.GetData(url: Home,token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element)
      {
        Favorites.addAll(
            {
              element.id : element.in_favorites!,
            });
      });
      //print(Favorites.toString());
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      emit(GetHomeDataerrorState(error));
      print(error.toString());
    });
  }
  void getCategories() {
    DioHelper.GetData(url: CategoriesEndPoint).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      emit(GetCategorieserrorState(error));
      print(error.toString());
    });
  }
  void getFavorites()
  {
    DioHelper.GetData(url: favorite ,token: token).then((value)
    {

        favoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(GetFavoritesFromJsonSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetFavoritesFromJsonErrorState());
    });
  }

changeFavorites(int productId)
{
  Favorites[productId] = !Favorites[productId]!;
  print(Favorites[productId]);
  emit(ChangeFavoriteIconState());

  DioHelper.PostData(url: favorite, data:
  {
    'product_id' : productId ,
  },
    token: token,

  )!.then((value)
  {
    changeFavoritesModel =ChangeFavoritesModel.fromJson(value.data);
    print(changeFavoritesModel!.message);
    emit(GetFavoritesSuccessState());
    getFavorites();
    emit(GetFavoritesAfterChangeState());
  }).catchError((error)
  {
    emit(GetFavoritesErrorState());
  });
}

void getNoVaforites(context)
{
     getFavorites();
    if(favoritesModel!.data!.total==0)
    {
      currentIndex=0;
      NavigateAndFinsh(context, NoFavScreen());
      emit(ChangeShopBottomNavState());
    }
}

  void getProfileData() {
    token =CasheHelper.getData(key: 'token');
    emit(GetProfileDataLoadingState());
    DioHelper.GetData(url: Profile,token: token).then((value) {
      profileData = ShopLoginUserModel.fromJson(value.data);
      emit(GetProfileDataSuccessState());
    }).catchError((error) {
      emit(GetProfileDataErrorState());
      print(error.toString());
    });
  }


  void UpdateData({Email,phone,name}) {
    emit(UpdateProfileDataLoadingState());
    DioHelper.PutData(url: Update,token: token,
      data:
      {
        'email':Email,
        'phone':phone,
        'name':name,
      },

    )!.then((value){
      profileData = ShopLoginUserModel.fromJson(value.data);
      emit(UpdateProfileDataSuccessState());
    }).catchError((error) {
      emit(UpdateProfileDataErrorState(error.toString()));
      print(error);
    });
  }
}
