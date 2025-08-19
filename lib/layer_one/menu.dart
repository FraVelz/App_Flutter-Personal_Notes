import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:personal_notes/layer_one/tools.dart';
import 'package:personal_notes/layer_one/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  // ************** ************** Variables y Funciones ************** ************** //
  List<Widget> dynamicDrawerSections = [];
  List<Widget> body = [];

  Color clrBody = Color.fromARGB(255, 0, 20, 20);
  Color clrText = Color.fromARGB(255, 0, 226, 226);
  Color clrTextEnabled = Color.fromARGB(255, 0, 154, 168);

  String path = ''; String subpath = '';
  Tools tools = Tools();

  final Widgets widgets = Widgets(
    clrBody: Color.fromARGB(255, 0, 20, 20),
    clrText: Color.fromARGB(255, 0, 226, 226),
    clrTextEnabled: Color.fromARGB(255, 0, 154, 168),
  );

  Future<String> updateText() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? path_ = prefs.getString('path');

    if (path_ != null) {
      path = path_;
      dynamicDrawerSections.clear();

      for (String item in tools.leerCarpeta(ruta: path)) {
        dynamicDrawerSections.add(
          Column(
            children: [
              ...widgets.createSections(
                item.replaceAll(path, '').replaceAll('/', ''), 'Subtitle', 'Go', () {
                  Navigator.of(context).pop();

                  setState(() {
                    subpath = item;

                    body.add(
                      ListTile(
                        title: Text('Subpath: $subpath', style: TextStyle(color: clrText)),
                      ),
                    );
                    // print('Subpath: $subpath');
                  });
                }
              ),
            ],
          )
        );
        // print(item);
      }
    } else { path = ''; }

    return path.isEmpty ? 'Ruta no seleccionada :(' : path;
  }

  @override
  Widget build(BuildContext context) {
    return widgets.scaffoldModel(
      context,
      'Main Menus',
      body: body,

      // **************** **************** Drawer **************** **************** //
      drawer: Drawer(
        surfaceTintColor: clrBody,

        child: Container(
          color: clrBody,
          height:MediaQuery.of(context).size.height,
          
          child: SingleChildScrollView(
            child: Column(
              children: [
                
                SizedBox(height: 50),
                
                Text( 'FV Notes', style: TextStyle(
                  color: clrText, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                      
                SizedBox(height: 20),
                ...dynamicDrawerSections,
                SizedBox(height: 20),
                
                Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        String? selectedPath = await FilePicker.platform.getDirectoryPath();
                      
                        if (selectedPath != null) {
                          path = selectedPath;
                      
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('path', path);
                      
                          setState(() {}); // Actualiza el estado del Drawer
                        }
                      },
                      
                      style: widgets.defaultButtonStyle(clrText, clrBody),
                      child: Text('Path'),
                    ),
                      
                    FutureBuilder<String>(
                      future: updateText(), // Llama a la función asíncrona
                      
                      builder:
                          (BuildContext context, AsyncSnapshot<String> snapshot) {
                        
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Muestra un indicador de carga
                        
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}',
                              style: TextStyle(color: clrText));
                        
                        } else {
                          return Text(
                            snapshot.data ?? 'Ruta no seleccionada :(',
                            style: TextStyle(color: clrText),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // ************** ************** Floating Action Button ************** ************** //
floatingActionButton: FloatingActionButton(
  backgroundColor: clrText,
  onPressed: () {
    TextEditingController textController1 = TextEditingController();
    TextEditingController textController2 = TextEditingController();
    String selectedOption = 'Tema'; // Valor predeterminado

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: clrBody,
              title: Text(
                'Selecciona una opción',
                style: TextStyle(color: clrText),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botones para seleccionar Tema o Subtema
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedOption == 'Tema' ? clrText : clrBody,
                          foregroundColor: selectedOption == 'Tema' ? clrBody : clrText,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedOption = 'Tema';
                          });
                        },
                        child: Text('Tema'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedOption == 'Subtema' ? clrText : clrBody,
                          foregroundColor: selectedOption == 'Subtema' ? clrBody : clrText,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedOption = 'Subtema';
                          });
                        },
                        child: Text('Subtema'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Campos de texto dinámicos según la opción seleccionada
                  if (selectedOption == 'Tema') ...[
                    TextField(
                      controller: textController1,
                      maxLength: 12,
                      decoration: InputDecoration(
                        hintText: 'Texto (máx. 12 caracteres)',
                        hintStyle: TextStyle(color: clrTextEnabled),
                        counterStyle: TextStyle(color: clrTextEnabled),
                      ),
                      style: TextStyle(color: clrText),
                    ),
                    TextField(
                      controller: textController2,
                      maxLength: 30,
                      decoration: InputDecoration(
                        hintText: 'Texto (máx. 30 caracteres)',
                        hintStyle: TextStyle(color: clrTextEnabled),
                        counterStyle: TextStyle(color: clrTextEnabled),
                      ),
                      style: TextStyle(color: clrText),
                    ),
                  ] else if (selectedOption == 'Subtema') ...[
                    TextField(
                      controller: textController1,
                      maxLength: 20,
                      decoration: InputDecoration(
                        hintText: 'Texto (máx. 20 caracteres)',
                        hintStyle: TextStyle(color: clrTextEnabled),
                        counterStyle: TextStyle(color: clrTextEnabled),
                      ),
                      style: TextStyle(color: clrText),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (selectedOption == 'Tema') {
                      // print('Seleccionaste Tema');
                      // print('Texto 1: ${textController1.text}');
                      // print('Texto 2: ${textController2.text}');

                      tools.crearCarpeta(
                        ruta: path, nombre: textController1.text,
                      );
                      subpath = '$path/${textController1.text}';

                      tools.crearArchivo(
                        ruta: subpath, nombre: 'description.txt',
                        contenido: textController2.text,
                      );

                      setState(() {
                        body.add(
                          ListTile(
                            title: Text(
                              'Tema: ${textController1.text}',
                              style: TextStyle(color: clrText),
                            ),
                          ),
                        );
                      });
                    } else if (selectedOption == 'Subtema') {
                      // print('Seleccionaste Subtema');
                      // print('Texto: ${textController1.text}');
                      tools.crearArchivo(
                        ruta: subpath, nombre: textController1.text,
                        contenido: '',
                      );

                      setState(() {
                        body.add(
                          ListTile(
                            title: Text(
                              'Subtema: ${textController1.text}',
                              style: TextStyle(color: clrText),
                            ),
                          ),
                        );
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  style: widgets.defaultButtonStyle(clrText, clrBody),
                  child: Text('Guardar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: widgets.defaultButtonStyle(clrText, clrBody),
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  },
  child: Icon(Icons.add, color: clrBody),
) ,
    );
  }
}

// * Author: FraVelz - Francisco Vélez - FV
