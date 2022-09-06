
abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  final error;

  SocialLoginErrorState(this.error);
}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginChangeSuffixState extends SocialLoginStates {}
