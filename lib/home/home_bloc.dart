import 'dart:async';

import 'package:ecommerencetask/model/api_messages_response.dart';
import 'package:ecommerencetask/model/home_response.dart';
import 'package:ecommerencetask/model/unauthorised_response.dart';
import 'package:ecommerencetask/services/home_services.dart';
import 'package:flutter/cupertino.dart';
   enum HomeState{Loading,Success,Failed}

class  HomeBloc{
  //region varioable
  late BuildContext context;
   List<HomeResponse> homeResponse = [];
  late HomeServices homeServices;
  //endregion
  //region ctrl
  final homeCtrl = StreamController<HomeState>.broadcast();
  //endregion

HomeBloc(this.context);
//endregion

//region init
void init(){
  homeServices = HomeServices();
  gethomeproduct();
}
//endregion

//region getproducts
void gethomeproduct()async{
  try{
    homeResponse.clear();
    //loading
    homeCtrl.sink.add(HomeState.Loading);
    //Api integration
   homeResponse = await homeServices.getProducts();
   print(homeResponse);
    homeCtrl.sink.add(HomeState.Success);
  }on ApiErrorResponseMessage catch(error){
    //Failed
    homeCtrl.sink.add(HomeState.Failed);
  }catch(exception){
    //Failed
    homeCtrl.sink.add(HomeState.Failed);
  }
}
//endregion


}