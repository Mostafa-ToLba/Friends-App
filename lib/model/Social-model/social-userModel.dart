
 class socialUserModel{

    String? email;
    String? name;
    String? phone;
    String? uId;
    String? image;
    String? cover;
    String? bio;
    String? osUserID;



   socialUserModel({ this.email,this.osUserID, this.phone, this.name, this.uId, this.image, this.cover, this.bio,});

   socialUserModel.fromJson(Map<String,dynamic>json)
   {
     name=json['name'];
     phone=json['phone'];
     uId=json['uId'];
     image=json['image'];
     cover=json['cover'];
     bio=json['bio'];
     email=json['email'];
     osUserID=json['osUserID'];

   }

   Map<String,dynamic>toMap()
   {
     return {
       'name':name,
       'email':email,
       'phone':phone,
       'uId':uId,
       'image':image,
       'cover':cover,
       'bio':bio,
       'osUserID':osUserID,

     };
   }

 }
