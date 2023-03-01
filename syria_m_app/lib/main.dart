import 'package:flutter/material.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

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
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'images/logo.png',
              height: _isTablet ? 60 : 40,
            ),
            SizedBox(width: 10),
            Text(
              "استمارة المستفيدين من حشد الاغاثة",
              style: myTextStyle,
            ),
          ],
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
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Form(
                    key: _formKey,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: GridView.count(
                        childAspectRatio: _isTablet ? 1.5 : 1,
                        shrinkWrap: true,
                        crossAxisCount: _isTablet ? 3 : 1,
                        mainAxisSpacing: _isTablet ? 0 : 0,
                        crossAxisSpacing: _isTablet ? 48 : 20,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'رقم البطاقة',
                                style: myTextStyle,
                              ),
                              numberfeld(cardnocontroller),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'اسم الاب',
                                style: myTextStyle,
                              ),
                              namefeld(fatherNameController),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الوطني للأب',
                                style: myTextStyle,
                              ),
                              numberfeld(naFidfController)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'اسم الأم',
                                style: myTextStyle,
                              ),
                              namefeld(motherNameController),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الوطني للأم',
                                style: myTextStyle,
                              ),
                             numberfeld(naMidController),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'عدد الافراد',
                                style: myTextStyle,
                              ),
                              
                              numberfeld(nofamilyController)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "السكن",
                                style: myTextStyle,
                              ),
                              namefeld(placeController),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'رقم الهاتف',
                                style: myTextStyle,
                              ),
                              numberfeld(numberController),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: checkrow('غدائية', food, 'حرامات', cleaning),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: checkrow('  فرش', bed, "حاجات اخرى", others),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الملاحظات",
                          style: myTextStyle,
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
                  ElevatedButton(
                    onPressed: () {
                      
                        _submitForm();
                        // Show a snackbar to confirm submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم الإرسال بنجاح'),
                            duration: Duration(seconds: 2),
                          ),
                        );

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
                      
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: _isTablet ? 24 : 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField namefeld(TextEditingController namedControler) {
    return TextFormField(
                              controller: namedControler,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                              ),
                            );
  }

  TextFormField numberfeld(TextEditingController textediter) {
    return TextFormField(
                              controller: textediter,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            );
  }

  Row checkrow(String text1, bool check, String text2, bool check2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        checkbox(check),
        Text(
          text1,
          style: myTextStyle,
        ),
        SizedBox(
          width: _isTablet ? 220 : 20,
        ),
        checkbox(check2),
        Text(
          text2,
          style: myTextStyle,
        ),
      ],
    );
  }

  Checkbox checkbox(bool isChecked) {
    return Checkbox(
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }

  void _submitForm() async {
    final cardId = cardnocontroller.text;
    final fatherName = fatherNameController.text;
    final motherName = motherNameController.text;
    final nafatherID = naFidfController.text;
    final naMatherID = naMidController.text;
    final noFamily = nofamilyController.text;
    final place = placeController.text;
    final number = numberController.text;
    final foods = food ? 'نعم' : 'لا';
    final beds = bed ? 'نعم' : 'لا';
    final cleanthang = cleaning ? 'نعم' : 'لا';
    final other = others ? 'نعم' : 'لا';

    final databasePath = await getDatabasesPath();
    // Insert the data into the database
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.

      path.join(databasePath, 'syria.db'),
      // When the database is first created, create a table to store data.
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_table(id INTEGER PRIMARY KEY, cardId TEXT, fatherName TEXT, motherName TEXT, nafatherID TEXT, naMatherID TEXT, noFamily TEXT, place TEXT, number TEXT, foods TEXT, beds TEXT, cleaning TEXT, other TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    await database.then((db) {
      db.insert(
        'my_table',
        {
          'cardId': cardId,
          'fatherName': fatherName,
          'motherName': motherName,
          'nafatherID': nafatherID,
          'naMatherID': naMatherID,
          'noFamily': noFamily,
          'place': place,
          'number': number,
          'foods': foods,
          'beds': beds,
          'cleaning': cleanthang,
          'other': other,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }
}

const myTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Color(0xFF000000),
);
