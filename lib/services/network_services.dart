import 'package:http/http.dart';
import 'package:xelpmoc/config/routes/api_routes.dart';
import 'dart:convert';
import 'package:xelpmoc/services/secure_storage.dart';

class NetworkServices{

  final String baseUrl = 'http://10.0.2.2:8000/';
  //final String baseUrl = 'https://dashgirija.pythonanywhere.com/';

  Future loginService(String email, String password) async {
    Response response = await post(Uri.parse(baseUrl+apiRoutes['login_api'].toString()), body: {"email": email,"password": password});  
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body);
      UserSecureStorage.setAccessToken(responseBody['access_token'].toString());  
      UserSecureStorage.setRefreshToken(responseBody['refresh_token'].toString());
      print(responseBody.toString());
    }
    else{
      dynamic responseBody = "Login Failed !!";
      print(responseBody);      
    }
    return response;
  }

  // Register Service
  Future registerService(Map<String,dynamic> body) async {
    String isFreelancer = (body['userType'] == "freelancer") ? "true" : "false";
    String isClient = (body['userType'] == "client") ? "true": "false";
    Map<String,dynamic> bodySend = body;
    print(bodySend);

    Response response = await post(Uri.parse(baseUrl+apiRoutes['register_api'].toString()), body: bodySend);
    if (response.statusCode == 200){
      final responseBody = jsonDecode(response.body);
      print(responseBody.toString());
    }
    else{
      dynamic responseBody = "Couldn't register !!";
      print("isFreelancer "+ isFreelancer);
      print("isClient "+ isClient);
    }
    return response;
  }

  // Post Service
  Future postService(String api, Map<String,dynamic> body) async{
    final apiSend = api.toString();
    Map<String,dynamic> bodySend = body;
    String? accessToken = await UserSecureStorage.getAccessToken();                      

    Response response = await post(Uri.parse(baseUrl+apiSend), headers: {"Authorization" : "Bearer $accessToken"}, body: bodySend);
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body).toString();
      return response;
    }
    else if(response.statusCode == 401){
      await newAccessToken(); 
    }
    else{
      dynamic responseBody = "No data not 200, not 400";
      return response;
    }
  }

  // Get Service
  Future getService(String api, Map<String,dynamic> body) async{
    String? accessToken = await UserSecureStorage.getAccessToken();
/*     Map<String,String> headerSend = {    
      "Authorization" : "Bearer $accessToken"
    }; */
    final uri = Uri.http('10.0.2.2:8000', api, body);
    Response response = await get(uri);
    if(response.statusCode == 200){
      return response;
    }
    else if(response.statusCode == 401){ // token expired
      dynamic accessResponse = await newAccessToken(); // ask for new token
      if (accessResponse.statusCode == 200){
        await getService(api, body); // recursive call
      }
    }
    else{
      return response;
    }
  }

  // New Access Token Service
  Future newAccessToken() async{
    String? refreshToken = await UserSecureStorage.getRefreshToken();

    Response response =  await post(Uri.parse(baseUrl+apiRoutes['refresh_token_api'].toString()), body: {"refresh": refreshToken});
    if (response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      UserSecureStorage.setAccessToken(responseBody['access'].toString()); //set new access token
      return response;
  }

 // forget password
  Future forgetService(Map<String,dynamic> body) async{
    const apiSend = 'api/password_reset/';
    Map<String,dynamic> bodySend = body;
    String? accessToken = await UserSecureStorage.getAccessToken();                      

    Response response = await post(Uri.parse(baseUrl+apiSend), body: bodySend);
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body).toString();
      return response;
    }
    else{
      dynamic responseBody = "No data not 200, not 400";
      print(responseBody);
      return response;
    }
  }

 // forget password
  Future newPassService(Map<String,dynamic> body) async{
    const apiSend = 'api/password_reset/confirm/';
    Map<String,dynamic> bodySend = body;
    print("BODY : $body");
    String? accessToken = await UserSecureStorage.getAccessToken();                      

    Response response = await post(Uri.parse(baseUrl+apiSend), body: bodySend);
    print("send url : "+baseUrl+apiSend);
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body).toString();
      return response;
    }
    else{
      dynamic responseBody = "No data not 200, not 400";
      print(responseBody);
      return response;
    }
  }
  }
}