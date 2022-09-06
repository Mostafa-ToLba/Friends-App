
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/modules/CounterApp/counter_with_bloc/bloc/cubit.dart';
import 'package:mostafa1/modules/CounterApp/counter_with_bloc/bloc/states.dart';


class Counter extends StatelessWidget {
     Counter({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) => CounterCubit(InitialState),
        child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context, state) {},
          builder: (context, state) => Scaffold(
            backgroundColor: Colors.white,
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
                        CounterCubit.get(context).Minus();
                        print('${CounterCubit.get(context).Count}');
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                        '${CounterCubit.get(context).Count}',
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w900,
                        )
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
                        CounterCubit.get(context).Plus();
                        print('${CounterCubit.get(context).Count}');
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }