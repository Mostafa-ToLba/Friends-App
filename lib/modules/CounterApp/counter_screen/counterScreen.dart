
import 'package:flutter/material.dart';
class CounterScreen extends StatefulWidget {
   CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  var counter = 1;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Counter App'
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.green,
                child: Text(
                  'Minus',
          style : TextStyle(
            fontSize: 20.0,


        )

                ),
                onPressed: (){
                setState(() {

                });
                counter--;
                print('$counter');
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '$counter',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            MaterialButton(
                color: Colors.green,
                child: Text(
                    'Plus',
                    style : TextStyle(
                      fontSize: 20.0,


                    )

                ),
                onPressed: (){
                  setState(() {

                  });
                  counter++;
                  print('$counter');
                }),
          ],
        ),
      ),
    );
  }
}
