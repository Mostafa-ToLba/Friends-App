import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BmiResultScreen extends StatelessWidget {
  int result = 3;
  int age = 3;
  bool isMale = true;
  String story='';
  String state='';

   String mostafa() {

      if(result >= 18.5 && result <= 25) {
        story ='Normal';
      }
        else
          {
             story ='Not Normal';
          }
return story;
      }
  String mahmoud() {

    if(result >= 18.5 && result <= 25) {
      state ='you have normal body, good job!';
    }
    else
    {
      state ='you have higher or lesser than normal body weight, try to exercise more.';
    }
    return state;
  }

  BmiResultScreen({
     this.result=3,
     this.age=3,
     this.isMale=true,
      this.story ='',
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Bmi Result',
        ),
          backgroundColor: Colors.grey[900],
      ),
      body:
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Expanded (
                   child: Container(
                     child: Text(
                       'Your Result',
         style: TextStyle(
                       fontSize: 25,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
         ),
         ),
                   ),
                 ),
               ),
               Expanded (
                 flex: 6,
                 child: Center(
                   child: Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Container(
                    child:
                    Column(
                      children: [
                        Text(
                         ' ${mostafa()}',

                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Gender : ${isMale? 'Male': 'Female'} ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'Result : ${result}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'Age : ${age}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${mahmoud()}',
                                maxLines: 3,
                                style: TextStyle(

                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                       height: 300,
                       width:  300,
                     decoration: BoxDecoration(
                       color: Colors.grey[900],
                     ),
                     ),
                   ),
                 ),
               ),
               Expanded (
                 flex: 1,
                 child: MaterialButton(
                   minWidth: double.infinity,
                     color: Colors.pink[700],
                     child: Text(
                       'Re-Calculate',
                       style: TextStyle(
                           fontSize: 20,
                           color: Colors.white
                       ),
                     ),
                     onPressed:(){

                     Navigator.pop(context );
                     }
                 ),
               ),

             ],
           ),

       );
  }
}
