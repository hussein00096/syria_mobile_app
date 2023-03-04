import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static const _databaseName = '_databaseh.db';
  static const _databaseVersion = 1;

  static const table = 'my_table';
  static const columnId = '_id';
  static const columnCardNo = 'cardId';
  static const columnFatherName = 'fatherName';
  static const columnMotherName = 'motherName';
  static const columnPlace = 'place';
  static const columnNaFidf = 'nafatherID';
  static const columnNaMid = 'naMatherID';
  static const columnNofamily = 'noFamily';
  static const columnNumber = 'number';
  static const columnFood = 'foods';
  static const columnCleaning = 'cleaning';
  static const columnBed = 'beds';
  static const columnOthers = 'other';
  static const columnNotes = 'notes';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnCardNo TEXT NOT NULL,
        $columnFatherName TEXT NOT NULL,
        $columnMotherName TEXT NOT NULL,
        $columnPlace TEXT NOT NULL,
        $columnNaFidf TEXT NOT NULL,
        $columnNaMid TEXT NOT NULL,
        $columnNofamily TEXT NOT NULL,
        $columnNumber TEXT NOT NULL,
        $columnFood INTEGER NOT NULL,
        $columnCleaning INTEGER NOT NULL,
        $columnBed INTEGER NOT NULL,
        $columnOthers INTEGER NOT NULL,
        $columnNotes TEXT NOT NULL
      )
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await database;
   final  data= await db.insert(table, row);
    print(data);
    return data;
  }
}
