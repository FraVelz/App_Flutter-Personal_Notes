import 'dart:io';

class Tools {
  // Leer el contenido de una carpeta
  List<String> leerCarpeta({required String ruta}) {
    final directory = Directory(ruta);

    if (directory.existsSync()) {
      List<FileSystemEntity> contenido = directory.listSync();
      return contenido.map((e) => e.path).toList();
    }
    
    else { return []; }
  }

  // Crear una carpeta
  void crearCarpeta({required String ruta, required String nombre}) {
    Directory('$ruta/${nombre.replaceAll(' ', '_')}')
        .create(recursive: true)
        .then((Directory directory) {
      // print('Carpeta creada en: ${directory.path}');
    }).catchError((e) {
      // print('Error al crear la carpeta: $e');
    });
  }

  // Eliminar una carpeta
  void eliminarCarpeta({required String ruta}) {
    final directory = Directory(ruta);

    if (directory.existsSync()) {
      directory.delete(recursive: true).then((_) {
        // print('Carpeta eliminada: $ruta');
      }).catchError((e) {
        // print('Error al eliminar la carpeta: $e');
      });
    } else {
      // print('La carpeta no existe: $ruta');
    }
  }

  // Crear un archivo
  void crearArchivo({required String ruta, required String nombre, String contenido = ''}) {
    final file = File('$ruta/${nombre.replaceAll(' ', '_')}');

    file.writeAsString(contenido).then((_) {
      // print('Archivo creado en: ${file.path}');
    }).catchError((e) {
      // print('Error al crear el archivo: $e');
    });
  }

  // Eliminar un archivo
  void eliminarArchivo({required String ruta}) {
    final file = File(ruta);

    if (file.existsSync()) {
      file.delete().then((_) {
        // print('Archivo eliminado: $ruta');
      }).catchError((e) {
        // print('Error al eliminar el archivo: $e');
      });
    } else {
      // print('El archivo no existe: $ruta');
    }
  }

  // Leer un archivo
  Future<String?> leerArchivo({required String ruta}) async {
    final file = File(ruta);

    if (file.existsSync()) {
      try {
        String contenido = await file.readAsString();
        // print('Contenido del archivo: $contenido');
        return contenido;
      } catch (e) {
        // print('Error al leer el archivo: $e');
      }
    } else {
      // print('El archivo no existe: $ruta');
    }
    return null;
  }

  // Escribir en un archivo
  void escribirArchivo({required String ruta, required String contenido}) {
    final file = File(ruta);

    file.writeAsString(contenido, mode: FileMode.write).then((_) {
      // print('Contenido escrito en el archivo: $ruta');
    }).catchError((e) {
      // print('Error al escribir en el archivo: $e');
    });
  }
}
// * Author: FraVelz - Francisco Vélez - FV
