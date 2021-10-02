import 'package:path/path.dart';
import 'dart:async';
// import 'package:sqflite/sql.dart';
import 'package:sqflite/sqflite.dart';

class dbStudentManager {
  Database? _database;
  String TbName = 'student';
  String sqlstr =
      "CREATE TABLE student(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,course,TEXT)";

  // Future<Database> get database async {
  //   // ignore: unnecessary_null_comparison
  //   if (_database != null) {
  //     return _database;
  //   }
  //   _database = await initDB();
  //   return _database;
  // }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "sst.db"),
        version: 1, onCreate: (Database _database, int version) async {
      await _database.execute(sqlstr);
    });
  }

  Future openDb() async {
    // ignore: unnecessary_null_comparison
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "sst.db"),
          version: 1, onCreate: (Database db, int version) async {
        onCreate:
        (_database, version) async {
          await _database.execute(sqlstr);
          print(_database);
        };
      });
    } else {
      print("没有创建数据库... ");
    } // 如果 数据库为空的操作
  }

// 具体操作数据库方法 增，删，改，查

  Future<int> insertStudent(Student student) async {
    await openDb();
    return await _database!.insert('student', student.toMap());
  } // insert

  Future<List<Student>> getStudentList(Student student) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('student');
    return List.generate(maps.length, (index) {
      //generate:产生
      return Student(
        id: maps[index]['id'],
        name: maps[index]['name'],
        course: maps[index]['course'],
      );
    });
  } // query

  Future<int> updateStudent(Student student) async {
    await openDb();
    return await _database!.update('student', student.toMap(),
        where: 'id = ?', whereArgs: [student.id]);
  } // update

  Future<int> deleteStudent(int id) async {
    await openDb();
    return await _database!.delete('student', where: 'id = ?', whereArgs: [id]);
  } // delete

}

// class dbStudentManager 包装封口

class Student {
  int? id;
  String? name;
  String? course;

  Student({this.name, this.course, this.id});

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'name': this.name, 'course': this.course};
  } //toMap 方法

} // class Student 包装封口

class NoteModel {
  int? id;
  String? title;
  String? body;
  DateTime? creation_date;

  NoteModel({this.id, this.title, this.body, this.creation_date});

  Map<String, dynamic> toMap() {
    return ({
      'id': id,
      'title': title,
      'body': body,
      'creation_date': creation_date
    });
  }
}
