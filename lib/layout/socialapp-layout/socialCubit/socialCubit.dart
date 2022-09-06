
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/model/Social-model/comment_model.dart';
import 'package:mostafa1/model/Social-model/messageModel.dart';
import 'package:mostafa1/model/Social-model/social-userModel.dart';
import 'package:mostafa1/model/Social-model/social_postModel.dart';
import 'package:mostafa1/modules/social-app/addPost/add_postScreen.dart';
import 'package:mostafa1/modules/social-app/chats/chats.dart';
import 'package:mostafa1/modules/social-app/newsFeed/newsFeed.dart';
import 'package:mostafa1/modules/social-app/settings/settings_screen.dart';
import 'package:mostafa1/modules/social-app/users/users_Screen.dart';
import 'package:mostafa1/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mostafa1/shared/styles/IconBroken.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


class SocialCubit extends Cubit<SocialCubitStates> {
  SocialCubit(SocialCubitStates initialState) : super(initialState);

  static SocialCubit get(context) => BlocProvider.of(context);
  String ProfileImageUrl = '';

  socialUserModel? socialModel = new socialUserModel();

  void getUserDate(uId) {
    print(uId);
    emit(SocialCubitGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print('hhhhhhhhhhhhhhhhhhh ${value.data()}');
      socialModel =
          socialUserModel.fromJson((value.data() as Map<String, dynamic>));
      emit(SocialCubitGetUserDateSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCubitGetUserDataErrorState(error.toString()));
    });
  }

  List<Widget> Screens =
  [
    NewsFeedScreen(),
    ChatsScreen(),
    AddNewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> Titles =
  [
    'Friends',
    'Chats',
    'Post',
    'Users',
    'Profile',
  ];
  int currentIndex = 0;

  ChangeBottomNavItem(int index, context) {
    //if(index==1)
    getAllUsers();

    if (index == 2) {
      emit(SocialNewPostStateNavPar());
    }
    else {
      currentIndex = index;
      emit(ChangeNavBarItemState());
    }
  }

  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialCubitGetProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCubitGetProfileImageErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCubitGetCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCubitGetCoverImageErrorState());
    }
  }


  uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialCubitUploadProfilePicLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}').
    putFile(profileImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        UpdateUserImages(bio: bio, phone: phone,
          name: name, image: value,).then((value) {
          UpdateCommentsInPost2(image: value);
        });
        emit(SocialCubitUploadProfileImageSuccessState());
      }).catchError(() {
        emit(SocialCubitUploadProfileImageErrorState());
      });
    }).catchError(() {
      emit(SocialCubitUploadProfileImageErrorState());
    });
  }

  uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialCubitUploadCoverPicLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}').
    putFile(coverImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        UpdateUserImages(bio: bio, phone: phone,
          name: name, cover: value,);
        emit(SocialCubitUploadCoverImageSuccessState());
      }).catchError(() {
        emit(SocialCubitUploadCoverImageErrorState());
      });
    }).catchError(() {
      emit(SocialCubitUploadCoverImageErrorState());
    });
  }

  Future UpdateUserImages({
    required String phone,
    required String name,
    required String bio,
    String? image,
    String? cover,

  }) async {
    emit(SocialCubitUpdateLoadingState());
    socialUserModel updateModel = socialUserModel
      (
      name: name,
      phone: phone,
      email: socialModel!.email,
      uId: socialModel!.uId,
      image: image ?? socialModel!.image,
      cover: cover ?? socialModel!.cover,
      bio: bio,
    );

    FirebaseFirestore.instance.collection('users').doc(socialModel!.uId).update(
        updateModel.toMap())
        .then((value) {
      updateDataInPosts();
      UpdateCommentsInPost2(name: name, image: image);
      getUserDate(uId);
    }).catchError((error) {
      print(error.toString());
      emit(SocialCubitUpdateImageErrorState());
    });
  }

//post create

  File? postImage;

  Future getpostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialCubitGetPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCubitGetPostImageErrorState());
    }
  }

  Future uploadPostImageAndCreatePost({
    String? text,
  }) async {
    emit(SocialCubitLoadingUploadPostImage());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}').
    putFile(postImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        CreatePost(
            Text: text!,
            postImage: value,
            posterName: socialModel!.name!,
            posterImage: socialModel!.image!
        );
        emit(SocialCubitUploadPostImageSuccessState());
      }).catchError((error) {
        print(error);
        emit(SocialCubitUploadPostImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCubitUploadPostImageErrorState());
    });
  }

  socialUserModel? chatUserModel;

  Future CreatePost({
    String? dateTime,
    required String Text,
    String? postImage,
    required String posterName,
    required String posterImage,
  }) async {
    emit(SocialCubitLoadingUploadPostImage());
    socialUserModel chatUserModel = socialUserModel(name: socialModel!.name,
        image: socialModel!.image,
        phone: socialModel!.phone,
        uId: socialModel!.uId,
        bio: socialModel!.bio,
        cover: socialModel!.cover,
        email: socialModel!.email
    );
    socialPostModel postModel = socialPostModel(
      name: socialModel!.name!,
      uId: socialModel!.uId!,
      image: socialModel!.image!,
      dateTime: DateFormat.yMMMMd().add_Hms().format(DateTime.now()),
      Text: Text,
      postImage: postImage ?? '',
      posterName: posterName,
      posterImage: posterImage,
      posterbio: socialModel!.bio,
      posterPhone: socialModel!.phone,
      posterCover: socialModel!.cover,
    );

    FirebaseFirestore.instance.collection('posts').add(postModel.toMap())
        .then((value) {
      value.collection('userchats').add(chatUserModel.toMap());
      emit(SocialCubitCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCubitCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialCubitRemovePostImageState());
  }


  Emit() {
    emit(SocialCubitRemovePostImageState());
  }

  List<socialPostModel>?Posts;
  List<String>postsId = [];
  List<int>Likes = [];
  List<socialCommentModel>comments = [];

  getPosts() {
    Posts = [];

    emit(SocialCubitGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          //   Likes.add(value.docs.length);
          postsId.add(element.id);
          Posts!.add(socialPostModel.fromJson(element.data()));
        }).catchError((error) {
          print(error.toString());
          emit(SocialCubitGetPostsErrorState());
        });
        emit(SocialCubitGetPostsSuccessState());
      });
    }).catchError((error) {
      emit(SocialCubitGetPostsErrorState());
    });
  }

  void postLike(String postId) {
    FirebaseFirestore.instance.collection('posts').doc(postId).collection(
        'likes').doc(socialModel!.uId).set(
        {
          'like': true,
        }).then((value) {
      emit(SocialLikePostSuccessState());
      getLikes(postId);
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }


  void CreateComment({
    String? Text,
    String? postId,
    String? commnetPhoto,
  }) {
    emit(SocialCubitLoadingUploadComment());
    socialCommentModel CommentModel = socialCommentModel(
      commnetPhoto: commnetPhoto ?? '',
      name: socialModel!.name!,
      uId: socialModel!.uId!,
      image: socialModel!.image!,
      dateTime: DateFormat.yMMMMd().add_Hms().format(DateTime.now()),
      Text: Text!,
      postId: postId!,
    );
    FirebaseFirestore.instance.collection('posts').doc(postId).collection(
        'comments').add(CommentModel.toMap()).then((value) {
      emit(SocialCubitUploadCommentSuccessState());
      getcomments(postId);
    }).catchError((error) {
      print(error.toString());
      emit(SocialCubitUploadCommentErrorState());
    });
  }

  void getcomments(postId) {
    emit(SocialCubitLoadingGetComment());
    FirebaseFirestore.instance.collection('posts')
        .doc(postId).collection('comments').orderBy('dateTime')
        .snapshots().listen((event) {
      comments = [];
      event.docs.forEach((element) {
        comments.add(socialCommentModel.fromJson(element.data()));
      });
      emit(SocialCubitGetCommentSuccessState());
    });
  }

  List<socialUserModel>Users = [];

  void getAllUsers() {
    Users = [];
    emit(SocialCubitGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != socialModel!.uId)
          Users.add(socialUserModel.fromJson(element.data()));
      });
    }).then((value) {
      emit(SocialCubitGetAllUsersSuccessState());
    }).catchError((error) {
      emit(SocialCubitGetAllUsersErrorState());
    });
  }

  void SendMessage({
    required String recieverId,
    required String text,
    required String chatImage,

  }) {
    MessageModel messageModel = MessageModel(
      dateTime: DateTime.now().toString(),
      text: text,
      RecieverId: recieverId,
      SenderId: socialModel!.uId,
      chatImage: chatImage,
      dateOfMessage: DateFormat.jm().format(DateTime.now()),
    );

    //sender chat
    FirebaseFirestore.instance.collection('users')
        .doc(socialModel!.uId).collection('chats')
        .doc(recieverId).collection('messages')
        .add(messageModel.toMap()).then((value) {
      emit(SocialCubitSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialCubitSendMessageErrorState());
    });

    //reciever chat
    FirebaseFirestore.instance.collection('users')
        .doc(recieverId).collection('chats')
        .doc(socialModel!.uId).collection('messages')
        .add(messageModel.toMap()).then((value) {
      emit(SocialCubitSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialCubitSendMessageErrorState());
    });
  }

  List<MessageModel>Messages = [];

  void getMessage({String? recieverId}) {
    FirebaseFirestore.instance.collection('users')
        .doc(socialModel!.uId).collection('chats')
        .doc(recieverId).collection('messages')
        .orderBy('dateTime',descending: true)
        .snapshots().listen((event) {
      Messages = [];
      event.docs.forEach((element) {
        Messages.add(MessageModel.fromJson(element.data()));
        emit(SocialCubitRecieveMessageSuccessState());
      });
    });
  }

  File? chatImage;

  Future getChatImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,);
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(SocialCubitGetChatImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCubitGetChatImageErrorState());
    }
  }

  uploadChatImageAndSendMessage({
    required String recieverId,
    required String text,
    String? playerIds,
  }) {

    emit(SocialCubitUploadChatImagesLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('chatImages/${Uri
        .file(chatImage!.path)
        .pathSegments
        .last}').
    putFile(chatImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        SendMessage(recieverId: recieverId, text: text,
          chatImage: value,
        );
        SendNotificationToSomeOne(content: 'sent an image',
            playerIds: [playerIds],
            heading: socialModel!.name);
        emit(SocialCubitUploadChatImagesSuccessState());
      }).catchError((error) {
        emit(SocialCubitUploadChatImagesErrorState());
      });
    }).catchError((error) {
      emit(SocialCubitUploadChatImagesErrorState());
    });
    chatImage = null;
  }

  /*
  void getLikes(postId)
  {
    emit(SocialCubitLoadingGetComment());
    FirebaseFirestore.instance.collection('posts')
        .doc(postId).collection('likes')
        .snapshots().listen((event) {
     // Likes = [];
      event.docs.forEach((element) {
        Likes.add(event.docs.length);
      });
    });
  }

   */
  List<socialUserModel>?chatss;

  Future getPosts2() async {
    Posts = [];
    FirebaseFirestore.instance.collection('posts').orderBy(
        'dateTime', descending: true ).snapshots().listen((event) {
      postsId = [];
      Likes = [];
      Posts = [];
      event.docs.forEach((element)
      {
        postsId.add(element.id);
        Posts!.add(socialPostModel.fromJson(element.data()));
      });
    });
  }

  Future signOut() async
  {
    FirebaseAuth.instance.signOut().then((value) {
      emit(SocialCubitSignOutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCubitSignOutErrorState());
    });
  }

  Future removePost(uid) async {
    FirebaseFirestore.instance.collection('posts').doc(uid).delete().then((
        value) {
      emit(SocialCubitRemovePostSuccessState());
    }).catchError((error) {
      emit(SocialCubitRemovePostErrorState());
    });
  }

  void updateDataInPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection('users').doc(
            element.data()['uId']).get().then((value) {
          FirebaseFirestore.instance.collection('posts').doc(element.id).update(
              {

                'posterName': value.data()!['name'],
                'posterImage': value.data()!['image'],

              });
          emit(SocialCubitUpdateDataInPostsState());
        });
      });
    });
  }

  void UpdateCommentsInPost2({name, image}) {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] == socialModel!.uId) {
          element.reference.collection('comments').get().then((value) {
            value.docs.forEach((element) {
              element.reference.update(
                  {
                    'name': name,
                    'image': image,
                  });
            });
          });
        }
      });
      emit(SocialCubitUpdateDataInCommetnsState());
    });
  }

  String? Like;

  getLike(postId) {
    FirebaseFirestore.instance.collection('posts').doc(postId).get().then((
        value) {
      value.reference.collection('likes').get().then((value) {
        value.docs.length.toString();
        return Like = value.docs.length.toString();
      }).catchError((error) {
        print(error.toString());
        emit(getLikeErrorState());
      });
    });
  }

  List<socialPostModel> profilrPosts = [];


  Future getProfilePosts(uid) async {
    //  profilrPosts = [];
    FirebaseFirestore.instance.collection('posts').orderBy(
        'dateTime', descending: true)
        .snapshots().listen((event) {
      profilrPosts = [];
      event.docs.forEach((element) {
        if (element.data()['uId'] == uid) {
          profilrPosts.add(socialPostModel.fromJson(element.data()));
        }
      });
      emit(SocialCubitgetProfilePosrsState());
    });
  }

  File? commentImage;

  Future getCommentImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,);
    if (pickedFile != null) {
      commentImage = File(pickedFile.path);
      emit(SocialCubitGetCommentImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCubitGetCommentImageErrorState());
    }
  }

  uploadCommentImageAndCreateComment({postId, Text}) {
    firebase_storage.FirebaseStorage.instance.ref().child('commentImage/${Uri
        .file(commentImage!.path)
        .pathSegments
        .last}').
    putFile(commentImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        CreateComment(commnetPhoto: value, postId: postId, Text: Text);
        emit(SocialCubitUploadCommentImagesSuccessState());
      }).catchError((error) {
        emit(SocialCubitUploadCommentImagesErrorState());
      });
    }).catchError((error) {
      emit(SocialCubitUploadCommentImagesErrorState());
    });
    commentImage = null;
  }

  /*
   late socialUserModel userpostModel;
   Future getUsersPosts(postId)  async {
    emit(getUsersFromPostsLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance.collection('posts').doc(postId).get().then((value)
          {
              if (value.data()!['uId']==element.id)
              {
                userpostModel = socialUserModel.fromJson(element.data());
              }
          });
        });
      }).then((value) {
        emit(getUsersFromPostsSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(getUsersFromPostsErrorState());
      });
    }

     */
  socialUserModel? chatFromPost;

  Future getChatFromPost(postId) async {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection('posts').doc(postId).get().then((
            value) {
          if (element.id == value.data()!['uId']) {
            chatFromPost = socialUserModel(name: value.data()!['name'],
              email: value.data()!['email'],
              image: value.data()!['posterImage'],
              phone: value.data()!['posterPhone'],
              uId: value.data()!['uId'],
              cover: value.data()!['posterCover'],
              bio: value.data()!['posterbio'],
              osUserID: element.data()['osUserID'],
            );
            emit(getUsersFromPostsSuccessState());
          }
        }).then((value)
        {
          emit(getUsersFromPostsSuccessState());
        });
      });
    }).catchError((error) {
      print(error.toString());
      emit(getUsersFromPostsErrorState());
    });
  }

  String? Lik;

  getLikes(id) {
    Lik = '';
    FirebaseFirestore.instance.collection('posts').doc(id).get().then((value) {
      value.reference.collection('likes').get().then((value) {
        Lik = value.docs.length.toString();
        emit(getLikeSuccessState());
      });
    });
  }

  socialUserModel? searchModel;

  search(String onSubmit) {
    emit(socialSearchLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['name'] == onSubmit)
          searchModel = socialUserModel.fromJson(element.data());
        emit(socialSearchuccessState());
      });
      emit(socialSearchuccessState());
    });
  }

//oneSignalPushNotification
  getNotification(subtitle, content, data) {
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      subtitle = notification.payload.subtitle;
      content = notification.payload.body;
      data = notification.payload.additionalData['data'];
      emit(pushNotificationHandler());
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('Notification Opened');
    });
  }

  SendNotificationToSomeOne({content, playerIds, heading}) {
    OneSignal.shared.postNotification(OSCreateNotification(
      additionalData: {
        'data': 'this is our data',
      },
      subtitle: 'MyChat',
      androidSmallIcon: '${IconBroken.Message}',
      playerIds: playerIds,
      content: content,
      heading: heading,
    ));
    emit(pushNotificationToSomeone());
  }

  Future getNotify() async{
    OneSignal.shared.getPermissionSubscriptionState().then((state) {
      DocumentReference ref = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      ref.update({
        'osUserID': '${state.subscriptionStatus.userId}',
      });
      emit(getNotiftyState());
    });
    emit(getNotiftyState());
  }

  //for Sending Notifcation To everyone
  postNotificationToEveryOne({content, heading}) {
    OneSignal.shared.postNotification(OSCreateNotification(
      additionalData: {
        'data': 'this is our data',
      },
      subtitle: 'MyChat',
      androidSmallIcon: '${IconBroken.Message}',
      playerIds: usersNotify,
      content: content,
      heading: heading,
    ));
    emit(pushNotificationToSomeone());
  }

  //for Sending Notifcation To everyone
  List<String>? usersNotify = [];

  sendToeveryOne() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        usersNotify!.add(element.data()['osUserID']);
      });
      emit(usersaddtoList());
    }).catchError((error) {
      print(error.toString());
    });
  }

  String? commenterOsUserID = '';

  Future getCommentUser(postId) async {
    FirebaseFirestore.instance.collection('posts').doc(postId).get().then((
        value) {
      FirebaseFirestore.instance.collection('users')
          .doc(value.data()!['uId'])
          .get()
          .then((value) {
        commenterOsUserID = value.data()!['osUserID'];
      });
      emit(getCommenterOsUserID());
    }).catchError((error) {
      print(error.toString());
      emit(getCommenterOsUserIDErrorState());
    });
  }

  Future updateProfile(posterId) async {
    FirebaseFirestore.instance.collection('posts').doc(posterId).get().then((
        value) {
      FirebaseFirestore.instance.collection('users')
          .doc(value.data()!['uId'])
          .get()
          .then((value2) {
        FirebaseFirestore.instance.collection('posts').doc(posterId).update(
            {
              'posterCover': value2.data()!['cover'],
              'posterImage': value2.data()!['image'],
              'posterName': value2.data()!['name'],
              'name': value2.data()!['name'],
              'posterPhone': value2.data()!['phone'],
              'posterbio': value2.data()!['bio'],
            });
        emit(updateProfileState());
      }).then((value)
      {
        emit(updateProfileState());
      });
    });
  }

  List<String> commentNumber = [];

  getNumberOfComments() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          commentNumber.add(value.docs.length.toString());
          emit(getCommentNumerStete());
        });
      });
    });
  }


   getStreamMessage({String? recieverId}) {
    FirebaseFirestore.instance.collection('users')
        .doc(socialModel!.uId).collection('chats')
        .doc(recieverId).collection('messages')
        .orderBy('dateTime',descending: false)
        .snapshots().listen((event) {
   //   Messages = [];
      event.docs.forEach((element) {
        Messages.add(MessageModel.fromJson(element.data()));
        emit(SocialCubitRecieveMessageSuccessState());
      });
    });
  }

  changeChatSendButton(String message)
  {
    if(message.isEmpty)
      return 1;
    emit(ChangeChatButtonStete());
    if(message.isNotEmpty)
      return 2;
    emit(ChangeChatButtonStete());
  }

}
