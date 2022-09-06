
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mostafa1/modules/NewsApp/webView/webView.dart';
import 'package:mostafa1/shared/Bloc_todoApp/bloc.dart';
import 'package:mostafa1/shared/components/constants.dart';

Widget defultButton ({

  @required Color? backGround ,
  @required double? width,
  var function,
  @required String text='' ,
  @required height,


}) => Container(

  height: height,
  color: backGround,
  width: width,
  child: MaterialButton( onPressed: function,
    child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 17.0,
          color: Colors.white,
        )
    ),
  ),
);


   Widget defultformfield ({

   TextEditingController? controle ,
     var onfieldsubmite ,
     var validate ,
     var onchange ,
     var ontap ,
     TextInputType? keyboard ,
     String? label ,
     IconData? prefix ,
     IconData? suffix ,
     bool isPassword= false,
     var suffixPressed ,
     var textStyle,
     var contentPadding ,
}) =>

TextFormField(

controller: controle,

onFieldSubmitted:onfieldsubmite,
onTap:ontap,
validator: validate,
onChanged: onchange,
keyboardType: keyboard,
  obscureText: isPassword,
style: textStyle,

decoration:  InputDecoration(
contentPadding: contentPadding,
    prefixIcon: Icon(
      prefix,
      color: Colors.grey,
    ),
    suffixIcon: suffix !=null? IconButton (
      onPressed: suffixPressed,
      icon: Icon(
          suffix,
        color: Colors.grey,
      ),
    ) : null ,


label: Text(
    label!,
  style: textStyle,
),


border:OutlineInputBorder()
),

);
 Widget buildTaskItem(Map model,context)=> Dismissible(
   key: Key(model['id'].toString()),
   onDismissed: (direction){
     AppCubit.get(context).DeleteDatabase(id: model['id']);
   },
   child: Padding(
     padding: const EdgeInsets.all(20.0),
     child: Row(
       children: [
         CircleAvatar(
           backgroundColor: Colors.purple,
           radius: 37,
           child: Text(
               '${model['time']}',
             style: TextStyle(
               color: Colors.white,
             ),

           ),
         ),
         SizedBox(
           width: 20,
         ),
         Expanded(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 '${model['title']}',
                 style : TextStyle(
                   fontSize: 20,
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                 ),


               ),
               SizedBox(
                 height: 1.4,
               ),
               Text(
                 '${model['date']}',
                 style : TextStyle(
                   fontSize: 16,
                   color: Colors.grey,
                 ),


               ),
             ],
           ),
         ),
         IconButton(onPressed: ()
         {

         AppCubit.get(context).UpdateDatabase(
           status: 'done',
           id: model['id']
         );
         },
             icon: Icon(
           Icons.check_box,
               color: Colors.white,
         )),
         SizedBox(
           width: 1,
         ),
         IconButton(onPressed: ()
         {
           AppCubit.get(context).UpdateDatabase(
               status: 'archive',
               id:model['id'],
           );
         },
             icon: Icon(
               Icons.archive,
               color: Colors.white,
             )),
       ],
     ),
   ),

 );

 Widget ConditionalTaskBilder({List<Map>?tasks}) => ConditionalBuilder(
   condition: tasks!.length > 0 ,
   builder: (context) => ListView.separated(

       itemBuilder: (context,index) =>  buildTaskItem(tasks[index],context),
       separatorBuilder: (context,index)=> Container(
         height: .1,
         color: Colors.white,
       ),
       itemCount: tasks.length),
   fallback: (context) => Center(
     child: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Expanded(
             flex: 3,
               child: Icon(Icons.archive,color: Colors.white,size: 300,)),
           Expanded (
             child: Text(
               'No Tasks Yet, Please Add Some Tasks',
               style: TextStyle(
                 color: Colors.grey,
                 fontSize: 16,
               ),
             ),
           ),

         ],
       ),
     ),
   ),

 );

 Widget BuildNewsItem(article,context) => InkWell(
   onTap: ()
   {
     NavigateTo(context, WebViewScreen(article['url']));
   },
   child: Padding(
     padding: const EdgeInsets.all(18.0),
     child: Row(
       children:
       [
         Container(
           height: 120,
           width: 120,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             image: article['urlToImage'] != null ? DecorationImage(
                 fit:BoxFit.cover ,
                 image: NetworkImage('${article['urlToImage']}'))
                 :const DecorationImage(
                 fit:BoxFit.cover ,
                 image: NetworkImage('https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg'),
             )
           ),
         ),
         const SizedBox(
           width: 20,
         ),
         Expanded(
           child: Container(
             height: 120,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
               children: [
                 Expanded(
                   child: Text(
                     '${article['title']}',
                     style: Theme.of(context).textTheme.bodyText1,
                     maxLines: 4,
                     overflow: TextOverflow.ellipsis,
                   ),
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 Text(
                   '${article['publishedAt']}',
                   style: const TextStyle(
                     color: Colors.grey,
                   ),
                 ),
               ],
             ),
           ),
         ),


       ],
     ),
   ),
 );

 Widget BuildNewsListWithCondtionalBilder(list,context,{isSearch=false})=>ConditionalBuilder(

   condition: list.length > 0,
   builder:(context)=>ListView.separated(
       physics: BouncingScrollPhysics(),
       itemBuilder: (context,index)=> BuildNewsItem(list[index],context),
       separatorBuilder:(context,index) =>ItemSebareted(context),
       itemCount: list.length) ,
   fallback: (context)=>isSearch? Container():Center(child: CircularProgressIndicator()) ,

 );

 Widget ItemSebareted(context) => Padding(
   padding: const EdgeInsets.all(10.0),
   child: Container(
     height: .5,
     color: AppCubit.get(context).isDark ? Colors.grey:Colors.black,

   ),
 );

   void NavigateTo(context,Widget) => Navigator.push(context, MaterialPageRoute(
builder:(context) => Widget,
  ),);


dynamic NavigateAndFinsh(context,dynamic)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
  builder:(context) => dynamic,
), (route) => false);




void showToast(String message,Toaststate state,{@required ToastGravity? gravity,}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToasteColor(state),
    textColor: Colors.white,
    fontSize: 20.0
);

enum Toaststate {Success,Error,Warning}

Color chooseToasteColor(Toaststate state)
{
  Color color ;
  switch(state) {
    case Toaststate.Success:
      color= Colors.green;
      break;
    case Toaststate.Error:
      color= Colors.red;
      break;
    case Toaststate.Warning:
      color= Colors.amber;
      break;

  }
  return color;
}
