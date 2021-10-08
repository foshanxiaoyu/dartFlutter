import 'package:cov19/constants.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 App Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: HomeScreen(),
      // home: const MyHomePage(  title: '风生水起靠自己', ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  homepage
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
import 'dart:math';
import 'package:cov19/constants.dart';
import 'package:cov19/screens/two_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final lst = List.generate(5, (_) => nextNumber(min: 4, max: 10));

  // String clipvalue = (Random().nextInt(32) * 10).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("科温难停久"),
        ),
        body: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
          margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "欢迎光临",
                    style: TextStyle(fontSize: 50),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => TwoPage()));
                      },
                      child: Text(
                        "下一页",
                        style: TextStyle(fontSize: 30),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}

/// AppDrawer
class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final lst = List.generate(5, (_) => nextNumber(min: 4, max: 10));
  String clipvalue = (Random().nextInt(32) * 10).toString();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("管晓青"),
            accountEmail: const Text("foshangxqing@gmail.com"),
            // currentAccountPictureSize: const Size.square(72.0),
            currentAccountPicture: CircleAvatar(
              // radius: 76.0,
              child: Image.network(
                'https://foshanxiaoyu.github.io/dog.png',
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("首  页"),
            onTap: () {
              print("HOME页面");
              // Navigator.pushReplacementNamed(context, RoutesManages.home);
            },
            trailing: Chip(
                label: Text(
              clipvalue,
              style: TextStyle(color: Colors.red),
            )), // trailing：尾随 clip: 夹子 chip 芯片 相入的意思
          ),
          ListTile(
            leading: Icon(Icons.portrait),
            title: Text("肖  像"),
            onTap: () {
              // Navigator.pushReplacementNamed(context, RoutesManages.portrait);
              print("XIAOXIAN页面");
            },
            trailing: Chip(
                label: Text(
              '$lst',
              style: TextStyle(color: Colors.red),
            )),
          ),
          ListTile(
            leading: Icon(Icons.stairs),
            title: Text("楼  梯"),
            onTap: () {
              print("楼梯页面");
              // Navigator.pushReplacementNamed(context, RoutesManages.stairs);
            },
          ),
        ],
      ),
    );
  }
}

/// 1. max nextInt(max)
/// 2. Random().nextInt(max)=>0...max
/// 3. min+random_int ... max
int nextNumber({required int min, required int max}) =>
    min + Random().nextInt(max - min + 1);

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  twopage
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 import 'package:cov19/screens/datai_page.dart';
import 'package:flutter/material.dart';

class TwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //定义列表widget的list
    List<Widget> list = <Widget>[];

    //Demo数据定义
    var data = [
      {"id": 1, "title": "测试数据AAA", "subtitle": "ASDFASDFASDF"},
      {"id": 2, "title": "测试数据bbb", "subtitle": "ASDFASDFASDF"},
      {"id": 3, "title": "测试数据ccc", "subtitle": "ASDFASDFASDF"},
      {"id": 4, "title": "测试数据eee", "subtitle": "ASDFASDFASDF"},
    ];

    //根据Demo数据，构造列表ListTile组件list

    for (var item in data) {
      print(item["title"]);

      list.add(ListTile(
        title: Text(item["title"].toString(), style: TextStyle(fontSize: 18.0)),
        subtitle: Text(item["subtitle"].toString()),
        leading: Icon(Icons.fastfood, color: Colors.orange),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DataiPage(
                        item: item,
                      )));
        },
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("列表演示"),
      ),
      body: Column(
        children: [
          firstContainer(),
          SizedBox(
            height: 10,
          ),
          Text("逃跑计划"),
          SizedBox(
            height: 10,
          ),
          // Expanded(
          //   child:
          twoContainer(list),
          // )
        ],
      ),
    );
  }

  Container twoContainer(List<Widget> list) {
    return Container(
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
        height: 120,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          // physics: ScrollPhysics(), // 物理流动，不明白也看不出效果
          children: list,
          controller: ScrollController(), // 容器内Scroll
        ));
  }

  Container firstContainer() {
    return Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.orange,
        ),
        margin: EdgeInsets.all(4.0),
        //child:// Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                '这是第二页的第一个容器',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'two page \n', style: TextStyle(fontSize: 12)),
                    TextSpan(text: '这下好了 ', style: TextStyle(fontSize: 8)),
                  ])),
                )
              ],
            )
          ],
        ));
  }
}

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  dataipage
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 import 'package:flutter/material.dart';

class DataiPage extends StatelessWidget {
  const DataiPage({Key? key, required Map<String, Object> this.item})
      : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
    print(item);
    return Scaffold(
        appBar: AppBar(),
        body: new Column(
          children: <Widget>[
            Text("我是Detail页面"),
            Text("id:${item['id']}"),
            Text("id:${item['title']}"),
            Text("id:${item['subtitle']}")
          ],
        ));
  }
}


  
