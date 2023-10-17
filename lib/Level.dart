import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_puzzle_game/Game_Play.dart';

import 'Home.dart';

class level extends StatefulWidget {
  const level({super.key});

  @override
  State<level> createState() => _levelState();
}

List all = [];

class _levelState extends State<level> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initImages();
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('asset/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      all = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title:Text('LEVEL'),actions: [
        Column(
          children: [
            Text('Pints',style: TextStyle(fontSize: 24)),
            Text('${Home.prefs!.getInt('point')??0}',style: TextStyle(fontSize: 28),)
          ],
        )
      ],),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: all.length,
        itemBuilder: (context, index) {
          return InkWell(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return gameplay(index);
            },));
          },child: (Home.prefs!.getString('$index')=='yes') ? Container(padding: EdgeInsets.fromLTRB(0, 50,75,0),decoration: BoxDecoration(image: DecorationImage(image: AssetImage(all[index]))),child: Image.asset('asset/Other/t.png'),): Image.asset(all[index]) ,);
        },
      ),
    );
  }
}
