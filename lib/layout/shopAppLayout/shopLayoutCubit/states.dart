
 abstract class ShopLayoutStates {}

 class ShopLayoutInitialState extends ShopLayoutStates {}
 class ChangeShopBottomNavState extends ShopLayoutStates {}

 class GetHomeDataSuccessState extends ShopLayoutStates {}
 class GetHomeDataerrorState extends ShopLayoutStates {
 final dynamic error;
  GetHomeDataerrorState(this.error);}
 class GetHomeDataloadingState extends ShopLayoutStates {}

 class GetCategoriesSuccessState extends ShopLayoutStates {}
 class GetCategorieserrorState extends ShopLayoutStates {
   final dynamic error;
   GetCategorieserrorState(this.error);}


 class GetFavoritesSuccessState extends ShopLayoutStates {}
 class GetFavoritesErrorState extends ShopLayoutStates {}

 class ChangeFavoriteIconState extends ShopLayoutStates {}

 class GetFavoritesFromJsonSuccessState extends ShopLayoutStates {}
 class GetFavoritesFromJsonErrorState extends ShopLayoutStates {}


 class GetFavoritesAfterChangeState extends ShopLayoutStates {}
 class noFavoritesState extends ShopLayoutStates {}

 class GetProfileDataSuccessState extends ShopLayoutStates {}
 class GetProfileDataErrorState extends ShopLayoutStates {}
 class GetProfileDataLoadingState extends ShopLayoutStates {}

 class UpdateProfileDataSuccessState extends ShopLayoutStates {}
 class UpdateProfileDataErrorState extends ShopLayoutStates {
 final String error ;
  UpdateProfileDataErrorState(this.error);
}
 class UpdateProfileDataLoadingState extends ShopLayoutStates {}


