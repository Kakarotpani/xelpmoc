import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xelpmoc/services/network_services.dart';
import 'package:xelpmoc/utils/assets.dart';
import 'package:xelpmoc/utils/custom_buttons.dart';

final TextEditingController num1Controller = TextEditingController();
final TextEditingController num2Controller = TextEditingController();

class UserInput extends StatefulWidget {
  const UserInput({Key? key}) : super(key: key);

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget seriesStyle(String label){
    return Text(
      label,
      style: TextStyle(
        color: Colors.red[400],
        fontSize: 20,
        fontWeight: FontWeight.w600
      ),
    );
  }

  void validate(){
    if(formKey.currentState!.validate()){
      fibonacciService(
        num1Controller.text,
        num2Controller.text
      );
    }
  }

  Future fibonacciService(String num1, String num2) async {
    
    Map<String,dynamic> body = {
      "num1" : num1,
      "num2" : num2,
    };
    Response response = await NetworkServices().getService("api/fibonacci", body);
    if (response.statusCode == 200){
      dynamic responseData = json.decode(response.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                seriesStyle('Series 1'),
                Text(responseData['result1'].toString()),
                const Divider(thickness: 2, color: Colors.green,),
                 seriesStyle('Series 2'),
                Text(responseData['result2'].toString()),
              ]
            ),
            actions: <Widget>[
              ElevatedButton(
                style: addJobButtonStyle,
                child: const Text("cancel"),
                onPressed: () => Navigator.pop(context)
              )
            ],
          );
        }  
      );
    } 
  }

  Widget _body(BuildContext context){
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [   
            Image.asset(xelpImage,height: 240),

            Container(
              padding: const EdgeInsets.only(right: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Fibonacci Series",  
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 34,
                      fontWeight: FontWeight.w300,            
                    ),
                  ),
                  Text("Input",  
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 48, 219, 162),
                      fontSize: 32,
                      fontWeight: FontWeight.w400,            
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(30),
              child: Form(
                key: formKey,
                child: Column (
                  children: [
                    TextFormField(
                      controller: num1Controller,                      
                      decoration: const InputDecoration(                        
                        labelText: "Number 1",                  
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'At least 1 digit required';
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: num2Controller,                      
                      decoration: const InputDecoration(                        
                        labelText: "Number 2",                 
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'At least 1 digit required';
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(    
                          onPressed: validate,
                          style: raisedButtonStyle,
                          child: const Text(
                            "get series", 
                          ),
                        )
                      ],
                    )
                  ],
                )
              ),
            ),
          ]    
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }
}
