
abstract class SocialRegisterCubitStates {}

class SocialRegisterCubitInitialState extends SocialRegisterCubitStates {}

class SocialRegisterCubitSuccessState extends SocialRegisterCubitStates {}

class SocialRegisterCubitErrorState extends SocialRegisterCubitStates {
  final error;
  SocialRegisterCubitErrorState(this.error);
}
class SocialRegisterCubitLoadingState extends SocialRegisterCubitStates {}

class SocialRegisterCubitChangeSuffixState extends SocialRegisterCubitStates {}

class SocialCreateUserSuccessState extends SocialRegisterCubitStates {}

class SocialCreateUserErrorState extends SocialRegisterCubitStates {
  final error;
  SocialCreateUserErrorState(this.error);
}