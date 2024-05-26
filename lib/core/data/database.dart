import 'package:exercitatio/module/treinos/data/model/treino_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'treino_database.db');
    return openDatabase(
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            DROP TABLE IF EXISTS Config
          ''');

          await _onCreate(db, newVersion);
        }
      },
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future<void> limparBancoDeDados() async {
    final db = await database;
    await db.delete('treino');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE treino (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        descricao TEXT,
        repeticoes TEXT,
        series TEXT,
        peso TEXT,
        diaSemana TEXT,
        imagem TEXT
      )
    ''');
  }

  Future<void> inserirTreino(TreinoModel treino) async {
    final db = await database;
    await db.insert(
      'treino',
      treino.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TreinoModel>> listarTreinos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('treino');

    return List.generate(maps.length, (i) {
      return TreinoModel.fromMap(maps[i]);
    });
  }

  Future<void> deletarTreino(int id) async {
    final db = await database;
    await db.delete(
      'treino',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TreinoModel>> listarTreinosPorDia(String diaSemana) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'treino',
      where: 'diaSemana = ?',
      whereArgs: [diaSemana],
    );

    return List.generate(maps.length, (i) {
      return TreinoModel.fromMap(maps[i]);
    });
  }

  Future<void> atualizarTreino(TreinoModel treino) async {
    final db = await database;
    await db.update(
      'treino',
      treino.toMap(),
      where: 'id = ?',
      whereArgs: [treino.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
