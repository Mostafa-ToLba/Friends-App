
class socialCommentModel{
  late String name;
  late String uId;
  late String postId;
  late String image;
  late String dateTime;
  late String Text;
   String? commnetPhoto;

  socialCommentModel(  { this.commnetPhoto, required this.name,required this.uId, required this.image,required this.Text,required this.dateTime,required this.postId});

  socialCommentModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    Text=json['Text'];
    dateTime=json['dateTime'];
    uId=json['uId'];
    image=json['image'];
    postId=json['postId'];
    commnetPhoto=json['commnetPhoto'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'Text':Text,
      'dateTime':dateTime,
      'uId':uId,
      'image':image,
      'postId':postId,
      'commnetPhoto':commnetPhoto,
    };
  }

}