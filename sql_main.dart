import 'package:flutter/material.dart';
import 'dbmanager1.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbStudentManager dbmanager =
      new dbStudentManager(); // 引入dbStudentManager，新对象dbmanager
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  Student? student;
  // List<Student>? studlist;
  // int? updateIndex;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 14));
    return Scaffold(
      appBar: AppBar(
        title: Text('数据库 演示'),
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 数据输入，获取部分
                TextFormField(
                  decoration: new InputDecoration(label: Text("姓  名:")),
                  controller: _nameController,
                  validator: (val) => val!.isNotEmpty ? null : "登陆名不可为空",
                ),
                TextFormField(
                  decoration: new InputDecoration(label: Text("课  程:")),
                  controller: _courseController,
                  validator: (val) => val!.isNotEmpty ? null : "课程不可为空",
                ),
                ElevatedButton(
                    onPressed: () {
                      _submitStudent(context);
                    },
                    style: style,
                    child: Text(
                      '走 起',
                      textAlign: TextAlign.center,
                    )),
                // 显示数据的部份
                //   FutureBuilder(
                //       future: dbStudentManager.getStudentList(),
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData) {
                //           studlist = snapshot.data as List<Student>?;
                //           return ListView.builder(
                //             shrinkWrap: true,
                //             itemCount: studlist == null ? 0 : studlist!.length,
                //             itemBuilder: (BuildContext context, int index) {
                //               Student st = studlist[index];
                //               return Card(
                //                 child: Row(
                //                   children: <Widget>[
                //                     Padding(
                //                       padding: const EdgeInsets.all(16.0),
                //                       child: Container(
                //                         width: width * 0.50,
                //                         child: Column(
                //                           children: <Widget>[
                //                             Text('ID: ${st.id}'),
                //                             Text('Name: ${st.name}'),
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                     IconButton(
                //                       onPressed: () {
                //                         _nameController.text = st.name!;
                //                         _courseController.text = st.course!;
                //                         student = st;
                //                         updateindex = index;
                //                       },
                //                       icon: Icon(
                //                         Icons.edit,
                //                         color: Colors.blue,
                //                       ),
                //                     ),
                //                     IconButton(
                //                       onPressed: () {
                //                         dbStudentManager.deleteStudent(st.id);
                //                         setState(() {
                //                           studlist!.removeAt(index);
                //                         });
                //                       },
                //                       icon: Icon(
                //                         Icons.delete,
                //                         color: Colors.red,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               );
                //             },
                //           );
                //         }
                //         return CircularProgressIndicator();
                //       },
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _submitStudent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (student == null) {
        Student st = new Student(
            name: _nameController.text, course: _courseController.text);
        dbmanager.insertStudent(st).then((id) => {
              _nameController.clear(),
              _courseController.clear(),
              print(" 记录已经增加到数据库中——》》》》》》DB"),
            });
        // } else {
        //   student.name = _nameController.text;
        //   student.course = _courseController.text;

        //   dbmanager.updateStudent(student).then((id) => {
        //         setState(() {
        //           studlist[updateIndex].name = _nameController.text;
        //           studlist[updateIndex].course = _courseController.text;
        //         }),
        //         _nameController.clear(),
        //         _courseController.clear(),
        //         student = null
        //       });
      } // 第二个判断封口  判断数据表是否为空
    } // 第一个判断封口 当前formkey状态带回
  } // _submitStudent 封口
}
