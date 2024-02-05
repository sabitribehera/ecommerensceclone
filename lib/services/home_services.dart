import 'package:ecommerencetask/services/http_services.dart';
import 'package:ecommerencetask/until/app_constants.dart';

import '../model/home_response.dart';

class HomeServices {
  late HttpService httpService;

  HomeServices() {
    httpService = HttpService();
  }

// get product
  Future<List<HomeResponse>> getProducts() async {
    Iterable response;
    response = await httpService.getApiCallListType(AppConstants.url);
    print(response);
    return List<HomeResponse>.from(response.map((model)=> HomeResponse.fromJson(model)));
  }
}
