
 abstract class SocialCubitStates {}

 class SocialCubitInitialState extends SocialCubitStates {}

 class SocialCubitGetUserDataLoadingState extends SocialCubitStates {}

 class SocialCubitGetUserDateSuccessState extends SocialCubitStates {}

 class SocialCubitGetUserDataErrorState extends SocialCubitStates {
  SocialCubitGetUserDataErrorState(String error);
}

 class ChangeNavBarItemState extends SocialCubitStates {}

 class SocialNewPostStateNavPar extends SocialCubitStates {}

 class SocialCubitGetProfileImageSuccessState extends SocialCubitStates {}

 class SocialCubitGetProfileImageErrorState extends SocialCubitStates {}


 class SocialCubitGetCoverImageSuccessState extends SocialCubitStates {}

 class SocialCubitGetCoverImageErrorState extends SocialCubitStates {}


 class SocialCubitUploadProfileImageSuccessState extends SocialCubitStates {}
 class SocialCubitUploadProfileImageErrorState extends SocialCubitStates {}

 class SocialCubitUploadCoverImageSuccessState extends SocialCubitStates {}
 class SocialCubitUploadCoverImageErrorState extends SocialCubitStates {}

 class SocialCubitUpdateImageErrorState extends SocialCubitStates {}

 class SocialCubitUpdateLoadingState extends SocialCubitStates {}

 class SocialCubitUploadProfilePicLoadingState extends SocialCubitStates {}
 class SocialCubitUploadCoverPicLoadingState extends SocialCubitStates {}

 //creat post states
 class SocialCubitLoadingUploadPostImage extends SocialCubitStates {}
 class SocialCubitUploadPostImageSuccessState extends SocialCubitStates {}
 class SocialCubitUploadPostImageErrorState extends SocialCubitStates {}
//get post image fronm gallery
 class SocialCubitGetPostImageSuccessState extends SocialCubitStates {}
 class SocialCubitGetPostImageErrorState extends SocialCubitStates {}
 //createpost states
 class SocialCubitCreatePostLoadingState extends SocialCubitStates {}
 class SocialCubitCreatePostSuccessState extends SocialCubitStates {}
 class SocialCubitCreatePostErrorState extends SocialCubitStates {}
 //remove x post image icon
 class SocialCubitRemovePostImageState extends SocialCubitStates {}

 // get posts

 class SocialCubitGetPostsLoadingState extends SocialCubitStates {}
 class SocialCubitGetPostsSuccessState extends SocialCubitStates {}
 class SocialCubitGetPostsErrorState extends SocialCubitStates {}
 //make like
 class  SocialLikePostSuccessState extends SocialCubitStates {}
 class  SocialLikePostErrorState extends SocialCubitStates {}

 //create comment
 class SocialCubitLoadingUploadComment extends SocialCubitStates {}
 class SocialCubitUploadCommentSuccessState extends SocialCubitStates {}
 class SocialCubitUploadCommentErrorState extends SocialCubitStates {}

 //getComments
 class SocialCubitLoadingGetComment extends SocialCubitStates {}
 class SocialCubitGetCommentSuccessState extends SocialCubitStates {}
 class SocialCubitGetCommentErrorState extends SocialCubitStates {}

 //getallusers in chat

 class SocialCubitGetAllUsersLoadingState extends SocialCubitStates {}
 class SocialCubitGetAllUsersSuccessState extends SocialCubitStates {}
 class SocialCubitGetAllUsersErrorState extends SocialCubitStates {}


 //chats
 class SocialCubitSendMessageSuccessState extends SocialCubitStates {}
 class SocialCubitSendMessageErrorState extends SocialCubitStates {}
 class SocialCubitRecieveMessageErrorState extends SocialCubitStates {}
 class SocialCubitRecieveMessageSuccessState extends SocialCubitStates {}

 //chatImage picked File
 class SocialCubitGetChatImageSuccessState extends SocialCubitStates {}
 class SocialCubitGetChatImageErrorState extends SocialCubitStates {}

 //upload chat images
 class SocialCubitUploadChatImagesLoadingState extends SocialCubitStates {}
 class SocialCubitUploadChatImagesSuccessState extends SocialCubitStates {}
 class SocialCubitUploadChatImagesErrorState extends SocialCubitStates {}

 // sign out
 class SocialCubitSignOutSuccessState extends SocialCubitStates {}
 class SocialCubitSignOutErrorState extends SocialCubitStates {}

 // remove post
 class SocialCubitRemovePostSuccessState extends SocialCubitStates {}
 class SocialCubitRemovePostErrorState extends SocialCubitStates {}

 //updateDataInPosts

 class SocialCubitUpdateDataInPostsState extends SocialCubitStates {}

 //updateDateInComments
 class SocialCubitUpdateDataInCommetnsState extends SocialCubitStates {}

 //get profleposts

 class SocialCubitgetProfilePosrsState extends SocialCubitStates {}

 //getcommentPhoto

 class SocialCubitGetCommentImageSuccessState extends SocialCubitStates {}
 class SocialCubitGetCommentImageErrorState extends SocialCubitStates {}

 class SocialCubitUploadCommentImagesSuccessState extends SocialCubitStates {}
 class SocialCubitUploadCommentImagesErrorState extends SocialCubitStates {}

 //getUsersFromPosts
 class getUsersFromPostsSuccessState extends SocialCubitStates {}
 class getUsersFromPostsErrorState extends SocialCubitStates {}
 class getUsersFromPostsLoadingState extends SocialCubitStates {}

 //getLike
 class getLikeSuccessState extends SocialCubitStates {}
 class getLikeErrorState extends SocialCubitStates {}
 //Socialsearch
 class socialSearchuccessState extends SocialCubitStates {}
 class socialSearchLoadingState extends SocialCubitStates {}

 //pushNotification
 class pushNotificationHandler extends SocialCubitStates {}
 class pushNotificationToSomeone extends SocialCubitStates {}
 class usersaddtoList extends SocialCubitStates {}
 class getCommenterOsUserID extends SocialCubitStates {}
 class getCommenterOsUserIDErrorState extends SocialCubitStates {}


 class updateProfileState extends SocialCubitStates {}
 //getcommentnumb
 class getCommentNumerStete extends SocialCubitStates {}

 class ChangeChatButtonStete extends SocialCubitStates {}

 //getNotify
 class getNotiftyState extends SocialCubitStates {}


 class getNotiftyError extends SocialCubitStates {}