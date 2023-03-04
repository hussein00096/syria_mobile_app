import 'package:mysql_client/mysql_client.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uuid/uuid.dart';
Future<bool> migrateData() async { 
  
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    // No internet connectivity
   
    return false;
    }
  // Establish a connection to the MySQL database.


final conn = await MySQLConnection.createConnection(
  host: "192.168.30.254",
  port: 3306,
  userName: "root",
  password: "root123",
  databaseName: "app", // optional
);

// actually connect to database
await conn.connect();


print('object');
  final databasePath = await getDatabasesPath();

  final List<Map<String, dynamic>> data =
      await openDatabase(path.join(databasePath, '_databaseh.db')).then(
    (db) => db.query('my_table'),
  );
print(data);
print(conn);
  // Insert the retrieved data into the MySQL database.
 try {

for (final row in data) {
  final uuidv4 = Uuid().v4();
  print(uuidv4);
  await conn.execute(
  'INSERT INTO my_table (id, cardId, fatherName, motherName, nafatherID, naMatherID, noFamily, place, foods, beds, cleaning, other, notes, phoneno) '
  'VALUES (:id, :cardId, :fatherName, :motherName, :nafatherID, :naMatherID, :noFamily, :place, :foods, :beds, :cleaning, :other, :notes, :phoneno)',
  {
    'id': uuidv4,
    'cardId': row['cardId'],
    'fatherName': row['fatherName'],
    'motherName': row['motherName'],
    'nafatherID': row['nafatherID'],
    'naMatherID': row['naMatherID'],
    'noFamily': row['noFamily'],
    'place': row['place'],
    'foods': row['foods'],
    'beds': row['beds'],
    'cleaning': row['cleaning'],
    'other': row['other'],
    'notes': row['notes'],
    'phoneno': row['number']
  }
);

}


  // final conn = await MySqlConnection.connect(ConnectionSettings(
  //   host: '192.168.30.254',
  //   port: 3306,
  //   user: 'root',
  //   password:'root123' ,
  //   db: 'app',
  // ));
//   for (final row in data) {
//     await conn(
// 'INSERT INTO my_table (cardId, fatherName, motherName, nafatherID, naMatherID, noFamily, place, foods, beds, cleaning, other, notes, phoneno) '
//       'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
//       [
//         row['cardId'],
//         row['fatherName'],
//         row['motherName'],
//         row['nafatherID'],
//         row['naMatherID'],
//         row['noFamily'],
//         row['place'],
//         row['foods'],
//         row['beds'],
//         row['cleaning'],
//         row['other'],
//         row['notes'],
//         row['number']

    
//       ],
//     );
//     print(data);
//   }
  // Close the connection to the MySQL database.
 
 

  await openDatabase(path.join(databasePath, '_databaseh.db')).then((db)=>db.delete('my_table'));
  await conn.close();

   return true;
 } catch (e) {
print(e);
  return false;
   
 }
}
