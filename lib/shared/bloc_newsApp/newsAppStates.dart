
  abstract class NewsCubitStates {}

   class IinitialState extends NewsCubitStates {}

  class ChangeNavBarState extends NewsCubitStates {}

  class GetTechnologySuccessState extends NewsCubitStates {}

  class GetTechnologyErrorState extends NewsCubitStates {
  final error;

  GetTechnologyErrorState(this.error);}

  class TechnologyLoadingState extends NewsCubitStates {}


  class GetSportsSuccessState extends NewsCubitStates {}

  class GetSportsErrorState extends NewsCubitStates {
    final error;

    GetSportsErrorState(this.error);}

  class SportsLoadingState extends NewsCubitStates {}


  class GetEntertainmentSuccessState extends NewsCubitStates {}

  class GetEntertainmentErrorState extends NewsCubitStates {
    final error;

    GetEntertainmentErrorState(this.error);}

  class EntertainmentLoadingState extends NewsCubitStates {}



  class GetSearchSuccessState extends NewsCubitStates {}

  class GetSearchErrorState extends NewsCubitStates {
    final error;

    GetSearchErrorState(this.error);}

  class SearchLoadingState extends NewsCubitStates {}


