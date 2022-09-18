import 'package:flutter/material.dart';
import 'package:xelpmoc/views/fibonacci/user_input.dart';
import 'package:xelpmoc/views/login/login_view.dart';
import 'package:xelpmoc/views/register/register_view.dart';

class AppRouter {
  static Route ? generateRoute(RouteSettings settings){
    switch(settings.name){
      /* case "/":{
        return MaterialPageRoute(builder: (_) => const SplashView());
      } */
      case "/login":{
        return MaterialPageRoute(builder: (_) => const LoginView());
      }
      case "/register":{
        return MaterialPageRoute(builder: (_) => const RegisterView());
      }
      case "/user/input":{
        return MaterialPageRoute(builder: (_) => const UserInput());
      }
      /* case "/forgot":{
        return MaterialPageRoute(builder: (_) => const ForgetPassView());
      }
      case "/new/password":{
        return MaterialPageRoute(builder: (_) => const NewPass());
      } */
    }
    return null;
  }
}