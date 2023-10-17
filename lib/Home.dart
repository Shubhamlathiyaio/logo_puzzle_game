
import 'package:flutter/material.dart';
import 'package:logo_puzzle_game/Level.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static SharedPreferences ?prefs;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prafer();
  }
  prafer()
  async {
    Home.prefs = await SharedPreferences.getInstance();
    // for(int i=0;i<all.length;i++) Home.prefs?.setString('$i', 'yes')??'';
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
      body: Center(child: InkWell(onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return level();
        },));
      },child: Container(color: Colors.blue,alignment: Alignment.center,child: Text('Play',style: TextStyle(fontSize: 72)),),)),
    );
  }
}
