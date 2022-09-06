import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mostafa1/modules/BmiCalculatorApp/bmi_result_screen/bmi_result_screen.dart';


class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
   bool isMale=true ;
   double height = 120.0;
   int weight=30;
   int age =20;
   int s=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Center(
          child: Text(
            'BMI CALULATOR'
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded (
            child: Padding(
              padding: const EdgeInsets.only(right: 10 ,left: 10,
              bottom: 20.0 , top: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                       setState(() {
                         isMale = true;
                       });
                      },
                      child: Container(
                        decoration:BoxDecoration(
                             color: isMale? Colors.blue : Colors.white10,
                          borderRadius: BorderRadius.circular(15)
                        ) ,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children:  [
                            Image(
                                height: 50,
                                width: 50,
                                image: AssetImage(
                              'images/male.png'
                            )

                            ),
                              Text(
                                'Male',
                                style:TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,

                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                           setState(() {
                             isMale=false;
                           });
                      },
                      child: Container(
                        decoration:BoxDecoration(
                            color: isMale ? Colors.white10 :Colors.blue,
                            borderRadius: BorderRadius.circular(15)
                        ) ,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children:  [
                            Image(
                              width: 50,
                                height: 50,
                                image: AssetImage(
                              'images/female.png'
                            )),
                              Text(
                                'Female',
                                style:TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded (
            child:
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10 ,bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HEIGHT',
                        style :TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,

                        children: [
                          Text(
                            '${height.round()}',
                            style :TextStyle(
                              fontSize: 35.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'cm',
                            style :TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                          value: height,
                          min: 80.0,
                          max: 220,
                          onChanged: (value){
                            setState(() {
                              height=value;
                            });
                          }),
                    ],
                  ),
                ),
              ),
          ),
          Expanded (
            child :Padding(
              padding: const EdgeInsets.only(left:10,right: 10,bottom: 20,),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white10,

                          borderRadius: BorderRadius.circular(15)

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style :TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${weight}',
                            style :TextStyle(
                              fontSize: 35.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {

                                  });
                                  weight--;
                                },
                                mini: true,
                                child : Icon(
                                  Icons.remove,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    weight++;
                                  });
                                },
                                mini: true,
                                child : Icon(
                                  Icons.add,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white10,

                          borderRadius: BorderRadius.circular(15)

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style :TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${age}',
                            style :TextStyle(
                              fontSize: 35.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                  onPressed: (){
                                    setState(() {
                                      age--;
                                    });
                                  },
                                mini: true,
                                  child : Icon(
                                    Icons.remove,
                                  ),
                                  ),
                              SizedBox(
                                width: 7,
                              ),
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    age++;
                                  });
                                },
                                mini: true,
                                child : Icon(
                                  Icons.add,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration:   BoxDecoration(
                color: Colors.pink[700],
                borderRadius: BorderRadiusDirectional.vertical(bottom: Radius.circular(35))
            ),
            width: double.infinity,
            height: 55.0,
            child: MaterialButton(
                child: Text(
                    'CALCULATE',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
                onPressed: (){
    double result = weight / pow(height/100,2);
    print(result.round());

    Navigator.push(context, MaterialPageRoute(
    builder:(context)=>BmiResultScreen(isMale:isMale ,
    age: age,
    result:result.round(),),

    ),
    );
    }
    ),
          ),
        ],
      ),
    );
  }
}
