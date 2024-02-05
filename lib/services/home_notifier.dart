import 'package:ecommerencetask/home/home_bloc.dart';
import 'package:ecommerencetask/model/api_messages_response.dart';
import 'package:ecommerencetask/model/home_response.dart';
import 'package:flutter/cupertino.dart';

import 'home_services.dart';
class HomeNotifier extends ChangeNotifier{

  // region Common Variables
  List<HomeResponse> homeResponse = [];
  late HomeServices homeServices;
  HomeState currentState  = HomeState.Loading;
  // endregion

  //region Constructor
  HomeNotifier(){
   init();
  }
  //endregion

  void init(){
    homeServices = HomeServices();
    gethomeproduct();
  }


  //region getproducts
  void gethomeproduct()async{
    // await Future.delayed(Duration.zero);
    try{
      homeResponse.clear();

      //loading
      currentState = HomeState.Loading;
      notifyListeners();

      //Api integration
      homeResponse = await homeServices.getProducts();
      print(homeResponse);

      //success
      currentState = HomeState.Success;
      notifyListeners();
    }on ApiErrorResponseMessage catch(error){
      currentState = HomeState.Failed;
      notifyListeners();
    }catch(exception){
      currentState = HomeState.Failed;
      notifyListeners();
    }
  }
//endregion



}