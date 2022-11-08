import 'dart:io';
import 'package:deneb_v2/models/planet_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import "dart:io";

class PlanetHelper {
  PlanetHelper._privateConstructor();
  static final PlanetHelper instance = PlanetHelper._privateConstructor();

  static Database? _database;
  //Metodo asincrono que regresa un Future de tipo Database, si la base de datos no ha sido creada llama al metodo _init..., primera vez que se corre se genera luego ya no
  Future<Database> get database async => _database ??= await _initDatase();

  Future<Database> _initDatase() async {
    //specify a location in your phone to store the data base
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //directorio donde se guardan los archivos
    String path = join(documentsDirectory.path, 'denebv2.db');
    //si no existe openDatabase crea la base de datos
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        //single ' tres veces para escribir en multilinea
        '''
      CREATE TABLE planets (
        id INTEGER PRIMARY KEY,
        name TEXT,
        image TEXT,
        description TEXT,
        type TEXT,
        nature TEXT,
        size TEXT,
        distance TEXT
      )
      
      ''');
  }

  Future<List<Planet>> getPlanets() async {
    Database db = await instance.database;
    var planetquery = await db.query('planets', orderBy: 'name');

    //si no es empty ? (entonces)... has esto :(else) si no se cumple regresame la lista vacia
    //Ternalia dicen
    List<Planet> planetList = planetquery.isNotEmpty
        ? planetquery.map((e) => Planet.fromMap(e)).toList()
        : [];
    return planetList;
  }

  Future<int> addPlanet(Planet planet) async {
    //esperar hasta la conección
    Database db = await instance.database;
    return await db.insert('planets', planet.toMap());
  }

  Future<int> updatePlanet(Planet planet) async {
    Database db = await instance.database;
    return await db.update('planets', planet.toMap(),
        where: 'id = ?', whereArgs: [planet.id]);
  }
}
