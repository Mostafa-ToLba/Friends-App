
import 'package:mostafa1/model/Social-model/social-userModel.dart';

class socialPostModel{
   String? name;
   String? uId;
   String? image;
   String? dateTime;
   String? Text;
   String? postImage;
   String? posterName;
   String? posterImage;
   String? posterbio;
   String? posterPhone;
   String? posterCover;
   socialUserModel?UsersChatt;


  socialPostModel({ this.UsersChatt, this.name, this.uId, this.image, this.Text, this.dateTime, this.postImage,this.posterbio,this.posterPhone,
     this.posterName, this.posterImage,this.posterCover,});

  socialPostModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    Text=json['Text'];
    postImage=json['postImage'];
    dateTime=json['dateTime'];
    uId=json['uId'];
    image=json['image'];
    posterName=json['posterName'];
    posterImage=json['posterImage'];
    posterbio=json['posterbio'];
    posterPhone=json['posterPhone'];
    posterCover=json['posterCover'];
    UsersChatt=json['UsersChatt'];

  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'Text':Text,
      'postImage':postImage,
      'dateTime':dateTime,
      'uId':uId,
      'image':image,
      'posterName':posterName,
      'posterImage':posterImage,
      'posterbio':posterbio,
      'posterPhone':posterPhone,
      'posterCover':posterCover,
      'UsersChatt':UsersChatt

    };
  }

}



