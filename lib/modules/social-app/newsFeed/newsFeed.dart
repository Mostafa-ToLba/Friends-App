
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/model/Social-model/social_postModel.dart';
import 'package:mostafa1/modules/social-app/AddcommenScreen/add_CommentScreen.dart';
import 'package:mostafa1/modules/social-app/Profile/profileScreen.dart';
import 'package:mostafa1/modules/social-app/photoOpen/photoOpenScreen.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/styles/IconBroken.dart';

class NewsFeedScreen extends StatelessWidget {
   NewsFeedScreen();
  @override
int counter=0 ;
  List<Card>?list=[
    /*
    Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Image(image:
          NetworkImage('https://image.freepik.com/free-photo/mindful-pensive-redhead-european-woman-green-jumper-gazes-aside-blank-space-thinks-what-recalls-something_273609-38779.jpg'),
            width: double.infinity,height: 220,fit: BoxFit.cover, ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Column(
                  children: [
                    Text('Communicate With Your Friends',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('And Stay Cool With Social Chat ,',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 17,color: Colors.white,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    ),

     */
    Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(image:
          NetworkImage('https://image.freepik.com/free-photo/world-global-cartography-globalization-earth-international-concept_53876-128043.jpg'),

            width: double.infinity,height: 220,fit: BoxFit.cover, ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  children: [
                    Text('Let\'s always keep the lines of communication open between us.',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 17,color: Colors.white,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    ),
    Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(image:
          NetworkImage('https://image.freepik.com/free-photo/horizontal-shot-happy-diverse-women-giggle-positively-have-cheerful-expressions-stand-closely-each-other-express-positive-emotions-have-friendly-relationships-isolated-blue-wall_273609-49738.jpg'),

            width: double.infinity,height: 220,fit: BoxFit.cover, ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Column(
                  children: [
                    Text(' Share with us your daily routine',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 17,color: Colors.white,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    ),
    Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(image:
          NetworkImage('https://image.freepik.com/free-photo/happy-teenage-girl-with-curly-hair-holds-modern-mobile-phone-takeout-coffee-orders-taxi-via-online-application-types-text-message-wears-yellow-clothing-people-modern-lifestyle-technology_273609-27928.jpg'),
            width: double.infinity,height: 220,fit: BoxFit.cover, ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Column(
                  children: [
                    Text('Communicate With Your Friends ,',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 17,color: Colors.white,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    ),
    Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(image:
          NetworkImage('https://image.freepik.com/free-photo/people-emotions-beauty-lifestyle-concept-cheerful-woman-expresses-happiness-expresses-friendly-attitude-being-polite-talking-with-customer-wears-spectacles-poloneck-feels-very-glad_273609-42883.jpg'),

            width: double.infinity,height: 220,fit: BoxFit.cover, ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Column(
                  children: [
                    Text('Show the world your creative side',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 17,color: Colors.white,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    ),
    Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Image(image:
          NetworkImage('https://image.freepik.com/free-photo/photo-cheerful-delighted-african-american-woman-types-sms-modern-cell-phone-device-enjoys-good-internet-connection_273609-25670.jpg'),

            width: double.infinity,height: 220,fit: BoxFit.cover, ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Column(
                  children: [
                    Text('Stay Cool And Injoy With Social Chat',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 17,color: Colors.white,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    ),
    Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Image(image:
          NetworkImage('https://image.freepik.com/free-photo/close-up-young-handsome-man-isolated_273609-36175.jpg'),

            width: double.infinity,height: 220,fit: BoxFit.cover, ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Column(
                  children: [
                    Text('It is a chance to have a chat about the community issues',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 17,color: Colors.white,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    ),
    Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Image(image:
          NetworkImage('https://image.freepik.com/free-photo/handsome-cheerful-young-sportsman-has-sporty-body-muscular-arms-wears-white-mock-up-t-shirt-has-short-dark-hair-toothy-appealing-smile-stands-purple-wall-blank-copy-space-aside_273609-26661.jpg'),

            width: double.infinity,height: 220,fit: BoxFit.cover, ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Column(
                  children: [
                    Text('Focus on how to be social listen, engage ,and build relationships',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text('',style: TextStyle(fontFamily: 'PoiretOne',fontSize: 17,color: Colors.white,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    ),

  ];
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialCubitStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).socialModel!= null&&SocialCubit.get(context).Posts!.length>0,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  CarouselSlider(items:list , options: CarouselOptions(
                height: 220,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                initialPage: 0,
                autoPlayInterval: Duration(seconds: 10),
                reverse: false,
                enlargeCenterPage: false,
                viewportFraction: 1.0,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                pageSnapping: true,

                  ),),
                  /*
                  Card(
                    elevation: 6,
                    margin: EdgeInsets.all(6),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1584361853901-dd1904bb7987?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80',),
                                radius: 25,
                              ),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Mostafa Tolba',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                        SizedBox(width: 3,),
                                        Icon(Icons.check_circle,color: Colors.blue,size: 18,),
                                        SizedBox(width: 10),
                                        Icon(Icons.push_pin,size: 25,),
                                      ],
                                    ),
                                    Text('October 31,2021 6:40 pm',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13,height: 1.4), ),

                                  ],
                                ),
                              ),
                              SizedBox(width: 25),
                              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
                            ],
                          ),
                          SizedBox(height: 13,),
                          Container(height: 1,color: Colors.grey[300],),
                          SizedBox(height: 13,),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text('Welcome all users this is a pinned post ! Messaging and texting can be much more than ways to communicate.'
                                ' They can also be tools that help you learn and master important skills, Online'
                                ' messaging apps are often used by young people to talk to their friend and peers. Staying'
                                ' connected with your friends is valuable, but online messaging also gives you '
                                'opportunities to develop your social skills in a range of formal and informal contexts.'
                                'so hope you use it in a good way and we will be happy if you shared with us your'
                                ' joyful stories and your ''experiences. ',
                              style: TextStyle(fontSize: 16,height: 1.2,),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(image: NetworkImage('https://image.freepik.com/free-photo/hesitant-puzzled-unshaven-man-shruggs-shoulders-bewilderment-feels-indecisive-has-bristle-trendy-haircut-dressed-blue-stylish-shirt-isolated-white-wall-clueless-male-poses-indoor_273609-16518.jpg'),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            IconBroken.Heart,
                                            size: 22.0,
                                            color: Colors.red,
                                          ),
                                          Text('0'),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          /*
                          Text(
                            '${SocialCubit.get(context).Likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),

                           */
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            IconBroken.Chat,
                                            size: 22.0,
                                            color: Colors.amber,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'comment',
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,color: Colors.grey[350],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: ()
                                  {

                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage('${SocialCubit.get(context).socialModel!.image}',),
                                        radius: 25,
                                      ),
                                      SizedBox(width: 15,),
                                      Text('write a comment ...'),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: ()
                                {


                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      IconBroken.Heart,
                                      size: 22.0,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Like',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ),

                   */
                  ConditionalBuilder(
                    condition: SocialCubit.get(context).socialModel!=null&&SocialCubit.get(context).Posts!.length>0,
                    builder: (BuildContext context)=>ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index)=>BultHomeItem(context,SocialCubit.get(context).Posts![index],index,
                          SocialCubit.get(context).postsId[index],),
                        separatorBuilder: (context,index)=>SizedBox(height: 0,),
                        itemCount: SocialCubit.get(context).Posts!.length),
                    fallback: (context)=>Center(child: CircularProgressIndicator()),

                  ),
                ],
              ),
            );
          },
          fallback:(BuildContext context)=> Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
  Widget BultHomeItem(context, socialPostModel post,index, postsId,  )=>Card(
    elevation: 6,
    margin: EdgeInsets.all(6),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${post.posterImage}',),
                  radius: 25,
                ),
                onTap: ()
                {
                  SocialCubit.get(context).updateProfile(postsId).then((value)
                  {
                    SocialCubit.get(context).getProfilePosts(post.uId);
                  });
                  SocialCubit.get(context).getChatFromPost(postsId).then((value)
                  {
                    NavigateTo(context, ProfileScreen({postsId}, SocialCubit.get(context).chatFromPost!,post.posterName,post.posterImage,post.posterbio!,post.posterPhone!,post.posterCover!,post.uId!));
                  });
                }
              ),
              SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell
                        (
                          child: Text('${post.posterName}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                        onTap: ()
                        {
                          SocialCubit.get(context).updateProfile(postsId).then((value)
                          {
                            SocialCubit.get(context).getProfilePosts(post.uId);
                          });
                           SocialCubit.get(context).getChatFromPost(postsId).then((value)
                           {
                             NavigateTo(context, ProfileScreen({postsId}, SocialCubit.get(context).chatFromPost!,post.posterName,post.posterImage,post.posterbio!,post.posterPhone!,post.posterCover!,post.uId!));
                           });
                         }
                      ),
                      SizedBox(width: 3,),
                      Icon(Icons.check_circle,color: Colors.blue,size: 18,),
                    ],
                  ),
                  Text('${post.dateTime}',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13,height: 1.4), ),

                ],
              ),
              SizedBox(width: 25),
              Expanded(
                child: DropdownButton(
                  icon:Icon(Icons.more_horiz,color:Colors.black),
                  items: [
                    DropdownMenuItem(child: TextButton(onPressed: () {
                      if(post.uId==SocialCubit.get(context).socialModel!.uId)
                        SocialCubit.get(context).removePost(postsId);
                      else
                        {
                          print('Sorry it is not your post');
                          showToast('Sorry it is not your post',Toaststate.Warning,gravity:ToastGravity.CENTER);
                        }
                    },
                    child: Icon(IconBroken.Delete,),),
                      value: 'delete',
                    ),
                  ] ,
                onChanged: (identifyer)
                {
                  if(identifyer=='delete');
                }
                ,),
              )
            ],
          ),
          SizedBox(height: 13,),
          Container(height: 1,color: Colors.grey[300],),
          SizedBox(height: 13,),
          if(post.Text!='')
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('${post.Text}',
              style: TextStyle(fontSize: 16,height: 1.2,),
            ),
          ),
          if(post.postImage!='')
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: ()
              {
                NavigateTo(context, SocialPhotoOpen(post.postImage!));
              },
              /*
              child: Container(
           //     width: double.infinity,
           //     height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(image: NetworkImage('${post.postImage}'),
           //           fit: BoxFit.cover,
                    )
                ),
              ),
               */
              child: Container(
                  child: Image(image: NetworkImage('${post.postImage}'),)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      /*
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 22.0,
                            color: Colors.red,
                          ),
                          Text(SocialCubit.get(context).Lik??''),
                          SizedBox(
                            width: 5.0,
                          ),
                          /*
                          Text(
                            '${SocialCubit.get(context).Likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),

                           */
                        ],
                      ),
                       */
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      /*
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 22.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            ' comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                       */
                    ),
                    onTap: () {
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,color: Colors.grey[350],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: ()
                  {
                   NavigateTo(context, AddCommentScreen(postId: postsId.toString(), ));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${SocialCubit.get(context).socialModel!.image}',),
                        radius: 25,
                      ),
                      SizedBox(width: 15,),
                      Text('Write a comment ...'),
                    ],
                  ),
                ),
              ),
              /*
              InkWell(
                onTap: ()
                {
                  SocialCubit.get(context).postLike(postsId);
                },
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 22.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ),
               */
            ],
          ),
        ],
      ),
    ),

  );
}