import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/modules/CounterApp/counter_with_bloc/bloc/states.dart';


class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit(initialState) : super(InitialState());

  int Count =1 ;

  static CounterCubit get (context) => BlocProvider.of(context);
  
  void Minus(){
    Count-- ;
    emit(MinusState()) ;
  }
  void Plus(){
    Count++ ;
    emit(PlusState());
  }

}