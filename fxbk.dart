import 'package:flutter/material.dart';
import 'db/dbhelper.dart';
import 'models/car.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '洗车项目',
      theme: ThemeData(
        primarySwatch: Colors.blue, // blue,orange
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
  final dbHelper = DatabaseHelper.instance;

  List<Car> cars = [];
  List<Car> carsByName = [];

  //controllers used in insert operation UI
  TextEditingController nameController = TextEditingController();
  TextEditingController milesController = TextEditingController();

  //controllers used in update operation UI
  TextEditingController idUpdateController = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController milesUpdateController = TextEditingController();

  //controllers used in delete operation UI
  TextEditingController idDeleteController = TextEditingController();

  //controllers used in query operation UI
  TextEditingController queryController = TextEditingController();

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );

    // _scaffoldKey.currentState!.showSnackBar(SnackBar(
    //   //  showSnackBar 用 ScaffoldMessenger.showSnackBar 替代
    //   content: Text(message),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          bottom: TabBar(
            tabs: const [
              Tab(
                text: "增加",
              ),
              Tab(
                text: "查看",
              ),
              Tab(
                text: "查找",
              ),
              Tab(
                text: "更新",
              ),
              Tab(
                text: "删除",
              ),
            ],
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('洗车项目'),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '汽车牌照号',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: milesController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '洗车价格',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    // RaisedButton( 用 ElevatedButton 代替
                    child: Text('增加洗车号牌'),
                    onPressed: () {
                      String name = nameController.text;
                      int miles = int.parse(milesController.text);
                      _insert(name, miles);
                      nameController.text = '';
                      milesController.text = '';
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: cars.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == cars.length) {
                    return ElevatedButton(
                      child: Text('刷  新'),
                      onPressed: () {
                        setState(() {
                          _queryAll();
                        });
                      },
                    );
                  }
                  return Container(
                    height: 110,
                    // child:   // Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '系统内编号：${cars[index].id}\n车牌号码： ${cars[index].name}\n价 格： ${cars[index].miles}  元',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    // ),
                  );
                },
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: queryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '汽车牌号',
                      ),
                      onChanged: (text) {
                        if (text.length >= 2) {
                          setState(() {
                            _query(text);
                          });
                        } else {
                          setState(() {
                            carsByName.clear();
                          });
                        }
                      },
                    ),
                    height: 100,
                  ),
                  Expanded(
                    child: Container(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: carsByName.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            margin: EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                '[${carsByName[index].id}]--${carsByName[index].name} --洗车报价 ${carsByName[index].miles}元',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: idUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '系统内编号',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: nameUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '汽车牌照号码',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: milesUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '价格',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      '确 定',
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: () {
                      int id = int.parse(idUpdateController.text);
                      String name = nameUpdateController.text;
                      int miles = int.parse(milesUpdateController.text);
                      _update(id, name, miles);
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: idDeleteController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '系统内部编号：',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('删除'),
                    onPressed: () {
                      int id = int.parse(idDeleteController.text);
                      _delete(id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insert(name, miles) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnMiles: miles
    };
    Car car = Car.fromMap(row);
    final id = await dbHelper.insert(car);
    _showMessageInScaffold('增加的编号: $id'); // 50 行代码替换
    // ScaffoldMessenger.of(context).showSnackBar(// 20211010 add
    //     const SnackBar(
    //   content: Text('系统内编号 has been shown.'),
    // ));
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    cars.clear();
    allRows.forEach((row) => cars.add(Car.fromMap(row)));
    _showMessageInScaffold('查 找');
    setState(() {});
  }

  void _query(name) async {
    final allRows = await dbHelper.queryRows(name);
    carsByName.clear();
    allRows.forEach((row) => carsByName.add(Car.fromMap(row)));
  }

  void _update(id, name, miles) async {
    // row to update
    Car car = Car(id, name, miles);
    final rowsAffected = await dbHelper.update(car);
    _showMessageInScaffold('更新 $rowsAffected 这一数据');
  }

  void _delete(id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    _showMessageInScaffold('删除 $rowsDeleted 数据: 这一数据编号 $id');
  }
}

=======================================================================================================================================================
  models.dart
=======================================================================================================================================================
  import 'package:fxbk/db/dbhelper.dart';

class Car {
  int? id;
  String? name;
  int? miles;

  Car(this.id, this.name, this.miles);

  Car.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    miles = map['miles'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnMiles: miles,
    };
  }
}

=======================================================================================================================================================
  db_impl.dart
=======================================================================================================================================================
  import 'package:fxbk/models/car.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "cardb.db";
  static final _databaseVersion = 1;

  static final table = 'cars_table';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnMiles = 'miles';

  // 制造单例  类
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // 仅单个应用程序范围内的数据库引用
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // 首次访问时， 懒加载  实例化数据库

    _database = await _initDatabase();
    return _database;
  }

  //  opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //   create  database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnMiles INTEGER NOT NULL
          )
          ''');
  }

  // impl methods:

  // insert: Inserts a row

  Future<int> insert(Car car) async {
    Database? db = await instance.database;
    return await db!.insert(table, {'name': car.name, 'miles': car.miles});
  }

  // query: All of the rows are returned as a list of maps

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  // QueryRows:   query方法加参数

  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database? db = await instance.database;
    return await db!.query(table, where: "$columnName LIKE '%$name%'");
  }

  // 所有的 增删改查(insert, query, update, delete) 用统计行的方法统计记录数

  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // 用 id 值在数据表中定位 update(sql)

  Future<int> update(Car car) async {
    Database? db = await instance.database;
    int id = car.toMap()['id'];
    return await db!
        .update(table, car.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  //  用 id 值在数据表中定位 delete(sql)

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}

  
  
