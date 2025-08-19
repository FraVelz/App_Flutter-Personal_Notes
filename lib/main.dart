import 'package:flutter/material.dart';
import 'package:personal_notes/layer_one/menu.dart';
import 'package:personal_notes/layer_one/widgets.dart';

// **************** **************** Run **************** **************** //
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',

    routes: {
      '/': (context) => MainApp(),
      '/menu': (context) => Menu()
    },
  ));
}

// **************** **************** MainApp **************** **************** //
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color clrBody = Color.fromARGB(255, 231, 253, 255);
    Color clrText = Color.fromARGB(255, 1, 158, 161);
    Color clrTextEnabled = Color.fromARGB(255, 0, 79, 86);

    final controller_ = TextEditingController();
    
    final Widgets widgets = Widgets(
      clrBody: clrBody, clrText: clrText, clrTextEnabled: clrTextEnabled,
    );

    return widgets.scaffoldModel(context, 'FV - Welcome', body: [
      SizedBox(height: 250),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29.0),
        
        child: TextField(
          style: TextStyle(color: clrText, fontSize: 18),
          obscureText: true,
          maxLength: 14,
          
          cursorColor: clrText,
          controller: controller_,
          
          decoration: InputDecoration(
            labelText: 'Enter the Password:',
          
            counterStyle: TextStyle(color: clrTextEnabled),
            labelStyle: TextStyle(color: clrTextEnabled),
          
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: clrTextEnabled, width: 1.0), 
            ),
            
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: clrText, width: 2.0),
            ),
          ),
        ),
      ),
      
      TextButton(
        onPressed: () {
          if (controller_.text != 'password123') { //*Correct password

            controller_.clear();
            Navigator.of(context).pushNamed('/menu');

          } else { //*Incorrect password
            showDialog( 
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: clrBody,

                title: Text(
                  'Wrong Password!!', style: TextStyle(color: Colors.redAccent)
                ),

                content: Text(
                '(${controller_.text}) If you don\'t know the password you can\'t log in :(',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close'),
                  ),
                ],
              )
            );
          }
        },

        style: TextButton.styleFrom(
          backgroundColor: clrText,
          foregroundColor: clrBody,

          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(fontSize: 20),

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),
          ),
        ),

        child: Text('Get Into'),
      )
    ],
    );
  }
}

// * Author: FraVelz - Francisco Vélez - FV
