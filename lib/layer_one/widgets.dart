import 'package:flutter/material.dart';

class Widgets {
  final Color? clrBody;
  final Color? clrText;
  final Color? clrTextEnabled;

  Widgets({this.clrBody, this.clrText, this.clrTextEnabled});

  // **************** **************** Scaffold Model **************** **************** //
  Scaffold scaffoldModel(
    BuildContext context, String title,
    {Drawer? drawer, FloatingActionButton? floatingActionButton, List<Widget>? body}
    ) { 
    return Scaffold(
      backgroundColor: clrBody,

      // **************** **************** App Bar
      appBar: AppBar(
        backgroundColor: clrText, 
        toolbarHeight: 80,

        centerTitle: true,
        title: Text(title, style: TextStyle(

          color: clrBody, fontSize: 35, 
          fontWeight: FontWeight.bold
        )),

        actions: [
          IconButton(
            icon: Icon(Icons.account_box_rounded, color: clrBody, size: 35),
            
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
      
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(color: clrBody),
                  
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                      
                          Text( 'Author: |FV - FraVelz - Francisco Vélez|', 

                            style: TextStyle(
                              color: clrText, fontSize: 20, fontWeight: FontWeight.bold
                            ),
                          ),
                          
                          SizedBox(height: 10),
                      
                          Text( 'Version: 1.0 BETA', 

                            style: TextStyle(
                              color: clrText, fontSize: 20, fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ) 
                  );
                },
              );
            },
          ),
        ],

        iconTheme: IconThemeData(
          color: clrBody, 
          size: 35,
        ),
      ),
      
      drawer: drawer, 
      floatingActionButton: floatingActionButton,

      // **************** **************** Body
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            SizedBox(height: 10,),
            ...body!
          ],
        ),
      )
    );
  }
  
  // **************** **************** Drawer Sections **************** **************** //
  List<Widget> createSections(
      String title_, String subtitle_, String trailing_, function_
    ) {
    return [
      ListTile(
        title: Text(title_, style: TextStyle(color: clrText, fontSize: 25)),
        subtitle: Text(subtitle_,  style: TextStyle(color: clrTextEnabled, fontSize: 18)),

        trailing: TextButton(
          onPressed: function_, 
          style: TextButton.styleFrom(backgroundColor: clrTextEnabled, foregroundColor: clrBody),

          child: Text(trailing_), 
        ),
      ),

      Container(
        width: 390, height: 3,
        decoration: BoxDecoration(color: clrText, borderRadius: BorderRadius.circular(3)),
      ),

      SizedBox(height: 30)
    ];
  }

  // **************** **************** Button **************** **************** //
  ButtonStyle defaultButtonStyle(Color backgroundColor, Color foregroundColor) {
    return TextButton.styleFrom(
      backgroundColor: backgroundColor, 
      foregroundColor: foregroundColor,

      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0) ),
      
      textStyle: const TextStyle(
        fontSize: 16.0, 
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // **************** **************** Text Field **************** **************** //
  InputDecoration defaultTextFieldStyle(Color hintColor, Color enabledBorderColor, Color focusedBorderColor) {
    return InputDecoration(
      hintText: 'Ingrese texto aquí', 
      hintStyle: TextStyle(color: hintColor), 

      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: enabledBorderColor), // Borde cuando no está enfocado
      ),
      
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: focusedBorderColor, width: 2.0), // Borde cuando está enfocado
      ),
      
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), 
    );
  }
}

// * Author: FraVelz - Francisco Vélez - FV
