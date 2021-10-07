import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sql_state/routers/routes.dart';

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
            accountEmail: const Text("foshangxqin@gmail.com"),
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
              Navigator.pushReplacementNamed(context, RoutesManages.home);
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
              Navigator.pushReplacementNamed(context, RoutesManages.portrait);
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
              Navigator.pushReplacementNamed(context, RoutesManages.stairs);
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


============================================================================================================================================================
  main.dart
============================================================================================================================================================
import 'package:flutter/material.dart';
import 'package:sql_state/routers/routes.dart';
import 'package:sql_state/screen/main_page_temp.dart';

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
      routes: RoutesManages.getRoutes(context),
      initialRoute: MainPageTemp.routeName,
      title: '上菜礼物',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.purple.shade200,
      ),
      // home: const Login(),
      // home: const MainPage(),
      home: const MainPageTemp(),
    );
  }
}

============================================================================================================================================================
  main_page_temp.dart
============================================================================================================================================================
import 'package:flutter/material.dart';
import 'package:sql_state/app_drawer.dart';


class MainPageTemp extends StatelessWidget {
  static const String routeName = '/home';
  const MainPageTemp({Key? key}) : super(key: key);
  final String data = '好塞胡塞';

  @override
  Widget build(BuildContext context) {
    print('Bulding MainPage ...');
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text("风生水起"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
        child: Center(
          child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Text(
                "Home",
                style: TextStyle(fontSize: 55.0),
              )),
        ),
      ),
    );
  }
}

