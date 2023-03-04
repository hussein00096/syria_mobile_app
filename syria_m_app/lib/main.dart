// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:syria_m_app/widght/buttom.dart';

import 'constant/constant.dart';
import 'data/mysql.dart';
import 'data/sqldata.dart';
import 'widght/checkbox.dart';
import 'widght/felids.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //  late Timer _timer;
  // bool _showButton = false;
  //  @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }
  DatabaseHelper _databaseHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  final cardnocontroller = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final placeController = TextEditingController();
  final naFidfController = TextEditingController();
  final naMidController = TextEditingController();
  final nofamilyController = TextEditingController();
  final numberController = TextEditingController();
  final notesController = TextEditingController();

  bool food = false;
  bool others = false;
  bool bed = false;
  bool cleaning = false;
  bool _isTablet = false;

  @override
  Widget build(BuildContext context) {
    _isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final hight = MediaQuery.of(context).size.height;
    final wight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        
        toolbarHeight: 0.1 * hight,
        title: _isTablet
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onLongPress: _onLogoPressed,
                    child: Image.asset(
                      'images/logo.png',
                      height: _isTablet ? 130 : 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "استمارة المستفيدين من حشد الاغاثة",
                    style: _isTablet ? mytittleTextStyle : myTextStylemobile,
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                        'images/logo.png',
                        height: _isTablet ? 60 : 40,
                      ),
                    SizedBox(width: 10),
                    Text(
                      "استمارة المستفيدين من حشد الاغاثة",
                      style: _isTablet ? mytittleTextStyle : myTextStylemobile,
                    ),
                  ],
                ),
              ),
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.all(_isTablet ? 50 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("المعلومات", style: mytittleTextStyle),
                SizedBox(
                  height: 20,
                ),

                Form(
                  key: _formKey,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: _isTablet ? 2.5 : 3,
                      shrinkWrap: true,
                      crossAxisCount: _isTablet ? 2 : 1,
                      mainAxisSpacing: _isTablet ? 0 : 0,
                      crossAxisSpacing: _isTablet ? 48 : 2,
                      children: [
                        felds(
                            text: 'رقم البطاقة',
                            textEditingController: cardnocontroller),
                        felds(
                            text: 'اسم الاب',
                            textEditingController: fatherNameController),
                        felds(
                            text: 'الوطني للأب',
                            textEditingController: naFidfController),
                        felds(
                            text: 'اسم الأم',
                            textEditingController: motherNameController),
                        felds(
                            text: 'الوطني للأم',
                            textEditingController: naMidController),
                        felds(
                            text: 'عدد الافراد',
                            textEditingController: nofamilyController),
                        felds(
                            text: "السكن",
                            textEditingController: placeController),
                        felds(
                            text: 'رقم الهاتف',
                            textEditingController: numberController),
                      ],
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      CheckboxRow(
                        text: "غذائيه",
                        checkvalue: food,
                        onChanged: (value) {
                          setState(() {
                            food = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: _isTablet ? 280 : 30,
                      ),
                      CheckboxRow(
                          text: "حرامات",
                          checkvalue: cleaning,
                          onChanged: (value) {
                            setState(() {
                              cleaning = value;
                            });
                          }),
                    ],
                  ),
                ),

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      CheckboxRow(
                          text: "  فرش",
                          checkvalue: bed,
                          onChanged: (value) {
                            setState(() {
                              bed = value;
                            });
                          }),
                      SizedBox(
                        width: _isTablet ? 280 : 30,
                      ),
                      CheckboxRow(
                          text: "حاجات اخرى",
                          checkvalue: others,
                          onChanged: (value) {
                            setState(() {
                              others = value;
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الملاحظات",
                        style: mytittleTextStyle,
                      ),
                      SizedBox(
                        height: 144,
                        width: 690,
                        child: TextFormField(
                          maxLines: 4,
                          controller: notesController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Buttom(
                    text: 'حفظ الاستمارة',
                    function: _submitForm,
                    successMessage: "تم حفظ الاستمارة",
                    errorMessage: "خطأ لم تتم عملية الحفظ",
                    pop: false,),
                //                 ElevatedButton(
                //                   style: ElevatedButton.styleFrom(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(6),
                //   ),
                // ),
                //                   onPressed: () {
                //                     _submitForm();
                //                     // Show a snackbar to confirm submission
                //                     ScaffoldMessenger.of(context).showSnackBar(
                //                       SnackBar(
                //                         content: Text('تم الإرسال بنجاح'),
                //                         duration: Duration(seconds: 2),
                //                       ),
                //                     );

                //                     cardnocontroller.clear();
                //                     fatherNameController.clear();
                //                     motherNameController.clear();
                //                     placeController.clear();
                //                     naFidfController.clear();
                //                     naMidController.clear();
                //                     nofamilyController.clear();
                //                     numberController.clear();
                //                     notesController.clear();
                //                     setState(() {
                //                       food = false;
                //                       others = false;
                //                       bed = false;
                //                       cleaning = false;
                //                     });
                //                   },
                //                   child: Text(
                //                     'ارسل المعلومات',
                //                     style: TextStyle(fontSize: _isTablet ? 24 : 16),
                //                   ),
                //                 ),
                
                //                 ElevatedButton(
                //         child: Text("رفع حميع المعلومات"),
                //         onPressed: () {
                //           // Call the migrateData function when the button is pressed
                //         },
                //         style: ElevatedButton.styleFrom(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(6),
                //       ),

                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _submitForm() async {
    try {
      Map<String, dynamic> row = {
        DatabaseHelper.columnCardNo: cardnocontroller.text,
        DatabaseHelper.columnFatherName: fatherNameController.text,
        DatabaseHelper.columnMotherName: motherNameController.text,
        DatabaseHelper.columnPlace: placeController.text,
        DatabaseHelper.columnNaFidf: naFidfController.text,
        DatabaseHelper.columnNaMid: naMidController.text,
        DatabaseHelper.columnNofamily: nofamilyController.text,
        DatabaseHelper.columnNumber: numberController.text,
        DatabaseHelper.columnFood: food ? 1 : 0,
        DatabaseHelper.columnCleaning: cleaning ? 1 : 0,
        DatabaseHelper.columnBed: bed ? 1 : 0,
        DatabaseHelper.columnOthers: others ? 1 : 0,
        DatabaseHelper.columnNotes: notesController.text,
      };

      int id = await _databaseHelper.insert(row);
      cardnocontroller.clear();
      fatherNameController.clear();
      motherNameController.clear();
      placeController.clear();
      naFidfController.clear();
      naMidController.clear();
      nofamilyController.clear();
      numberController.clear();
      notesController.clear();
      setState(() {
        food = false;
        others = false;
        bed = false;
        cleaning = false;
      });

      print('Inserted row id: $id');
      return true;
    } catch (e) {
      return false;
    }
  }

//   void _submitForm() async {
//     final cardId = cardnocontroller.text;
//     final fatherName = fatherNameController.text;
//     final motherName = motherNameController.text;
//     final nafatherID = naFidfController.text;
//     final naMatherID = naMidController.text;
//     final noFamily = nofamilyController.text;
//     final place = placeController.text;
//     final number = numberController.text;
//     final foods = food ? 'نعم' : 'لا';
//     final beds = bed ? 'نعم' : 'لا';
//     final cleanthang = cleaning ? 'نعم' : 'لا';
//     final other = others ? 'نعم' : 'لا';

//     final databasePath = await getDatabasesPath();
//     // Insert the data into the database
//     final database = openDatabase(
//       // Set the path to the database. Note: Using the `join` function from the
//       // `path` package is best practice to ensure the path is correctly
//       // constructed for each platform.

//       path.join(databasePath, 'syriadbhh.db'),
//       // When the database is first created, create a table to store data.
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE my_table(id INTEGER PRIMARY KEY, cardId TEXT, fatherName TEXT, motherName TEXT, nafatherID TEXT, naMatherID TEXT, noFamily TEXT, place TEXT, number TEXT, foods TEXT, beds TEXT, cleaning TEXT, other TEXT)',
//         );
//       },
//       // Set the version. This executes the onCreate function and provides a
//       // path to perform database upgrades and downgrades.
//       version: 1,
//     );

//     await database.then((db) {
//       db.insert(
//         'my_table',
//         {
//           'cardId': cardId,
//           'fatherName': fatherName,
//           'motherName': motherName,
//           'nafatherID': nafatherID,
//           'naMatherID': naMatherID,
//           'noFamily': noFamily,
//           'place': place,
//           'number': number,
//           'foods': foods,
//           'beds': beds,
//           'cleaning': cleanthang,
//           'other': other,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     });
//     final List<Map<String, dynamic>> data =
//       await openDatabase(path.join(databasePath, 'syriadbhh.db')).then(
//     (db) => db.query('my_table'),
//   );
// print(data);

//   }
// }
//  void _startTimer() {
//     _timer = Timer(Duration(seconds: 5), () {
//       setState(() {
//         _showButton = true;
//       });
//     });
//   }

//   void _stopTimer() {
//     _timer.cancel();
//     setState(() {
//       _showButton = false;
//     });
//   }

//   void _showDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Upload all information?'),
//         content: Text('Do you want to upload all information?'),
//         actions: <Widget>[
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//                Buttom(
//                     text: "رفع جميع المعلومات",
//                     function: migrateData,
//                     successMessage: "تم رفع حميع المعلومات ",
//                     errorMessage: "خطا لم تتم عمليه رفع المعلومات");
//               Navigator.pop(context);
//             },
//             child: Text('Upload'),
//           ),
//         ],
//       ),
//     ).then((value) {
//       // Restart the timer after the dialog is closed
//       _startTimer();
//     });
//   }
 final int holdTime = 5;
  bool isLogoPressed = false;

  Future<void> _onLogoPressed() async {
    setState(() {
      isLogoPressed = true;
    });

    await Future.delayed(Duration(seconds: holdTime));

    if (isLogoPressed) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text("رفع جميع المعلومات"),
              content: Text("هل تريد رفع جميع المعلومات؟"),
              actions: [
                TextButton(
                  child: Text("لا"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              
                
                  
                    
                    Buttom(
                    text: "نعم",
                    function: migrateData,
                    successMessage: "تم رفع جميع المعلومات بنجاح",
                    errorMessage: "خطا لم تتم عمليه رفع المعلومات",
                    pop: true,),
                    
                
              
                
              ],
            ),
          );
        },
      );
    }

    setState(() {
      isLogoPressed = false;
    });
  }
}
