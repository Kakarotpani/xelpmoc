import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:xelpmoc/services/network_services.dart';
import 'package:xelpmoc/utils/assets.dart';
import 'package:xelpmoc/utils/custom_buttons.dart';
import 'package:xelpmoc/views/login/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validate(){
    if(formKey.currentState!.validate()){
      loginService(emailController.text,passwordController.text);
    }
  }

  Widget _loginBody(BuildContext context){
    const TextStyle footerTextStyle = TextStyle(color: Colors.black,fontSize: 12);
    const TextStyle linkStyle = TextStyle(color: Colors.blue, decoration: TextDecoration.underline);

    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [   
            Image.asset(splashImage,height: 300),
            const SizedBox(height: 10),

            Container( // ..............Welcome Text
              padding: const EdgeInsets.only(right: 80),  
              child: const Text("Welcome back !!",  
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 34,
                  fontWeight: FontWeight.w300,            
                ),
              ),
            ),

            Container( // ..............Login Text
              padding: const EdgeInsets.only(right: 250),  
              child: const Text("Login",  
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 29, 152, 227),
                  fontSize: 30,
                  fontWeight: FontWeight.w400,            
                ),
              ),
            ),
            const SizedBox(height: 10,),

            Container(  //......... profile svg
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(profileIcon, height: 50)  
            ),

            //............... loginForm
            Container(   
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(8),
              child: SingleChildScrollView(       
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                        labelText: "email",                    
                        icon: Icon(Icons.email, color: Colors.black),
                        ),
                        validator: (value) {  // password VALIDATION
                          if (value!.trim().isEmpty) {
                            return 'email is required';
                          }
                          else if(value.length<3)
                          {
                            return 'email must have atleast 3 ';
                          }
                          else if(!value.contains(RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')))
                          {
                            return 'email should be look like : example@domain.com';
                          }
                            return null;                        
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,                      
                        decoration: const InputDecoration(                        
                          labelText: "password", 
                          icon: Icon(Icons.lock, color: Colors.black),                  
                        ),
                        validator: (value) {  // password VALIDATION
                          if (value!.trim().isEmpty) {
                            return 'Password is required';
                          }
                          else if(value.length<8)
                          {
                            return 'Password must have atleast 8 ';
                            //and atmost 16 characters
                          }
                          else if(value.length>16)
                          {
                            return 'Password must have atmost 16 ';
                          }
                          else if(!value.contains(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')))
                          {
                            return 'Password must contain: atleast one alphabet, \n atleast one number and atleast one special character';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ) 
              ),
            ),

            const SizedBox(height: 24),

            _isLoading ? const Center(child: CircularProgressIndicator()):  
            Container(  //....... login btn 
              padding: const EdgeInsets.only(left: 250),
              child: ElevatedButton(         
                onPressed: validate,
                style: raisedButtonStyle,
                child: const Text(
                  "Sign in",  
                ),
              )
            ),
            const SizedBox(height: 18),
            SizedBox(  //.................. Bottom Section            
              width: 340,
              height: 100,            
              child: ListView(          
                children: [
                  Row(
                    children: [
                      const Text("Forgot Password ?", 
                        style: footerTextStyle
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        child: const Text("reset",                       
                          style: linkStyle,                      
                        ),
                        onTap: () => Navigator.of(context).pushNamed('/forgot') // forgot route
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Text("New user ?",
                        style: footerTextStyle,
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        child: const Text("register",                       
                          style: linkStyle,                      
                        ),
                        onTap: () => Navigator.of(context).pushNamed('/register') //register route
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]    
        ),
      ),
    );
  }

  Future loginService(String email, String password) async {
    Response response = await NetworkServices().loginService(email, password); //call api
    if(response.statusCode == 200){
      setState(() {
        _isLoading = false;
          Navigator.of(context).pushNamedAndRemoveUntil('/user/input', (route) => false);
      });   
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("invalid  credentials  !!"),
            actions: <Widget>[
              ElevatedButton(
                style: addJobButtonStyle,
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pushNamed('/login')
              )
            ],
          );
        }  
      );
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginBody(context)
    );
  }
}