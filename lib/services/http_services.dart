import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:ecommerencetask/model/home_response.dart';
import 'package:http/http.dart' as http;

import '../model/api_messages_response.dart';
import '../model/unauthorised_response.dart';

class HttpService {
  // region get Api Call
  Future<Map<String, dynamic>> getApiCall(String apiUrl, {String token = ""}) async {
    Map<String, dynamic> jsonResponse;

    // http header
    var header = {"content-type": "application/json", "authorization": "Bearer $token"};
    //  Request Body
    // var body = json.encode(param);
    //  parsed Url
    var url = Uri.parse(apiUrl);
    print(url);
    //  Timeout duration
    var duration = const Duration(seconds: 300);

    try {
      //  Execute Http get
      var response = await http.get(url, headers: header).timeout(duration);

      // region check if response is null
      if (response.body.isEmpty) {
        throw Exception("$apiUrl returned empty response.");
      }
      // endregion

      // decode json
      jsonResponse = json.decode(response.body.toString());

      // Region - Handle None Http 401
      if (response.statusCode == 401) {
        throw UnAuthorisedResponse.fromJson(jsonResponse);
      }
      // endregion

      // Region - Handle None Http 200
      if (response.statusCode != 200) {
        throw Exception("Oops error occurred, please try again in few minutes. Error Code:  ${response.statusCode} Details: ${response.body}.");
      }
      // endregion

      //#region Region - Handle Http 200 api error
      // var isStatusOk = jsonResponse["status"] == "OK";
      // if (!isStatusOk) {
      //   throw ApiErrorResponseMessage.fromJson(json.decode(response.body));
      // }
      // endregion

      // handle socket exception
      return jsonResponse;
    }
    on SocketException catch (exception) {
      throw ApiErrorResponseMessage(errorMessage: "No Internet Connection.", status: "No Internet");
    } on TimeoutException catch (exception) {
      throw ApiErrorResponseMessage(errorMessage: "Time out please try again.", status: "Timeout");
    } catch(exception){
      throw ApiErrorResponseMessage(errorMessage: "Something went wrong", status: "Timeout");
    }


  }
// endregion


  // region get Api Call
  Future<Iterable> getApiCallListType(String apiUrl, {String token = ""}) async {
    Iterable jsonResponse;

    // http header
    var header = {"content-type": "application/json", "authorization": "Bearer $token"};
    //  Request Body
    // var body = json.encode(param);
    //  parsed Url
    var url = Uri.parse(apiUrl);
    print(url);
    //  Timeout duration
    var duration = const Duration(seconds: 300);

    try {
      //  Execute Http get
      var response = await http.get(url, headers: header).timeout(duration);

      // region check if response is null
      if (response.body.isEmpty) {
        throw Exception("$apiUrl returned empty response.");
      }
      // endregion

      // decode json
      jsonResponse = json.decode(response.body.toString());

      // Region - Handle None Http 401
      if (response.statusCode == 401) {
        throw ApiErrorResponseMessage(errorMessage: "Unauthorised", status: "No Internet");
      }
      // endregion

      // Region - Handle None Http 200
      if (response.statusCode != 200) {
        throw Exception("Oops error occurred, please try again in few minutes. Error Code:  ${response.statusCode} Details: ${response.body}.");
      }
      // endregion

      //#region Region - Handle Http 200 api error
      // var isStatusOk = jsonResponse["status"] == "OK";
      // if (!isStatusOk) {
      //   throw ApiErrorResponseMessage.fromJson(json.decode(response.body));
      // }
      // endregion

      // handle socket exception
      return jsonResponse;
    }
    on SocketException catch (exception) {
      throw ApiErrorResponseMessage(errorMessage: "No Internet Connection.", status: "No Internet");
    } on TimeoutException catch (exception) {
      throw ApiErrorResponseMessage(errorMessage: "Time out please try again.", status: "Timeout");
    } catch(exception){
      throw ApiErrorResponseMessage(errorMessage: "Something went wrong", status: "Timeout");
    }


  }
// endregion
}
