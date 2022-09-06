  
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostafa1/modules/ShopApp/Shop_LoginScreen/shop_LoginScreen/LoginScreen.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel
  {
    final String? Image;
    final String? Title;
    final String? Body;

  BoardingModel({@required this.Image,  this.Title, @required this.Body});

  }

class OnboardingScreen extends StatefulWidget {
     OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  void Onsubmitt()
  {
    CasheHelper.SaveData(key: 'onBoarding', value: true)!.
    then((value)
    {
      if(value == true )
        NavigateAndFinsh(context,ShopLoginScreen());
    }
    );
  }

 void submitt()
  {
    CasheHelper.SaveData(key: 'onBoarding', value: true)!.
    then((value)
    {
      if(value == true )
        NavigateTo(context,ShopLoginScreen());
    }
    );
  }

  bool isLast=false;
    List <BoardingModel> Boarding =
     [
       BoardingModel(
         Image: 'Assets/images/1234.jpg',
         Body: 'Welcome To The World Of Little Shop',
         Title: 'Little Shop',
       ),
       BoardingModel(
         Image: 'Assets/images/shop7.jpg',
         Body: 'Stay Up-to-Date With The Best Deals And Offers ',
         Title: 'Little Shop',
       ),
       BoardingModel(
         Image: 'Assets/images/shop6.jpg',
         Body: 'Would You Like To Start Your Beauty Journey With Little Shop?',
         Title: 'Little Shop',
       ),
     ];

    var boardController =PageController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: ()
            {
              Onsubmitt();

            }, child: Text(
              'SKIP',
                  style: TextStyle(
                    fontSize: 18,
                  ),
            ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children:
            [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index)
                  {
                    if(index==Boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });

                    }else
                      setState(() {
                        isLast=false;
                      });

                  },
                  controller: boardController,
                  itemBuilder: (context,index)=>buildBoardingItem(Boarding[index]),
                  physics: BouncingScrollPhysics(),
                  itemCount: Boarding.length,
                ),
                ),
              Row(
                children: [
                 SmoothPageIndicator(controller: boardController,
                     effect:ExpandingDotsEffect(
                       dotColor: Colors.grey,
                       activeDotColor: Colors.purple,
                       expansionFactor: 5,
                       dotHeight: 12,
                     ),

                     count: 3),
                  Spacer(),
                  FloatingActionButton(

                    onPressed: ()
                  {
                   if(isLast)
                   {
                     submitt();
                   }else
                     {
                       boardController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.decelerate);
                     }
                  },
                    child: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),)
                ],

              ),

            ],
          ),
        ),
      );
    }
}


  Widget buildBoardingItem( BoardingModel Model )=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image:AssetImage(
          '${Model.Image}',
        ),),
      ),
      Text(
        '${Model.Title}',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${Model.Body}',
        style: TextStyle(
          fontSize: 22,

        ),
      ),
      SizedBox(
        height: 40,
      ),
    ],
  );
