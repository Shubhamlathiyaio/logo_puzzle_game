import 'dart:math';

import 'package:flutter/material.dart';

import 'Home.dart';
import 'Level.dart';

// ignore: must_be_immutable, camel_case_types
class gameplay extends StatefulWidget {
  int ind;

  gameplay(this.ind, {super.key});

  @override
  State<gameplay> createState() => _gameplayState();
}

List ans = [
  "ADIDAS",
  "AMAZON",
  "APPLE",
  "FACEBOOK",
  "HONDA",
  "LACOSTE",
  "MCDONALDS",
  "MERCEDES",
  "NIKE",
  "PIZZAHUT",
  "SHELL",
  "STARBUCKS",
  "TOYOTA",
  "VISA",
  "VOLKSWAGEN",
  "WIKIPEDIA",
  "TIKMARK"
];

// ignore: camel_case_types
class _gameplayState extends State<gameplay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qna();
  }

  List uans = [];
  List abcd = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  List q = [];
  List pos = [];
  List<bool> b = List.filled(14, true);
  int size = 0;
  int v = 0;
  PageController? controller;

  qna() {
    controller = PageController(initialPage: widget.ind);
    size = ans[widget.ind].length;
    uans = List.filled(size, '');
    abcd.shuffle();
    pos = List.filled(size, null);
    q = ans[widget.ind].toString().split('');
    for (int i = 0; i < 14 - size;) {
      if (!q.contains(abcd[i])) {
        q.add(abcd[i]);
        i++;
      } else {
        abcd.shuffle();
      }
    }
    b = List.filled(14, true);
    uans = List.filled(size, '');
    pos = List.filled(size, null);
  }

  @override
  Widget build(BuildContext context) {
    List<bool> B = List.filled(3, false);
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('logo ${widget.ind}/${ans.length}'),
            actions: [
              Column(
                children: [
                  Text('Pints', style: TextStyle(fontSize: 24)),
                  InkWell(
                    onTap: () => setState(() {
                      Home.prefs!.setInt(
                          'point', (Home.prefs!.getInt('point') ?? 0) + 10);
                    }),
                    child: Text(
                      '${Home.prefs!.getInt('point') ?? 0}',
                      style: TextStyle(fontSize: 28),
                    ),
                  )
                ],
              )
            ],
          ),
          body: PageView.builder(
            onPageChanged: (value) {
              widget.ind = value;
              qna();
              setState(() {});
            },
            controller: controller,
            itemCount: all.length,
            itemBuilder: (context, index) {
              return (Home.prefs!.getString('${widget.ind}') == 'yes')
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (widget.ind > 0) {
                                        controller?.previousPage(
                                            duration: Duration(microseconds: 1),
                                            curve: Curves.bounceIn);
                                        widget.ind--;
                                        qna();
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_left,
                                      size: 48,
                                    )),
                                Image.asset(all[widget.ind]),
                                IconButton(
                                    onPressed: () {
                                      if (widget.ind < ans.length - 1) {
                                        controller?.nextPage(
                                            duration: Duration(
                                              microseconds: 1,
                                            ),
                                            curve: Curves.bounceIn);
                                        widget.ind++;
                                        qna();
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 48,
                                    )),
                              ],
                            )),
                        Container(
                          height: 200,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: Text('${ans[widget.ind]}',
                              style: TextStyle(fontSize: 72)),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (widget.ind > 0) {
                                        widget.ind -= 1;
                                        size = ans[widget.ind].length;
                                        qna();
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_left,
                                      size: 48,
                                      color: widget.ind == 0
                                          ? Colors.transparent
                                          : null,
                                    )),
                                Image.asset(all[widget.ind]),
                                IconButton(
                                    onPressed: () {
                                      if (widget.ind < ans.length - 1) {
                                        widget.ind += 1;
                                        size = ans[widget.ind].length;
                                        qna();
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 48,
                                      color: widget.ind == ans.length - 1
                                          ? Colors.transparent
                                          : null,
                                    )),
                              ],
                            )),
                        Container(
                          height: 150,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: size,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount: uans.length,
                            itemBuilder: (context, ind) {
                              return InkWell(
                                onTap: () {
                                  if (!(uans[ind] == '')) {
                                    b[pos[ind]] = true;
                                    uans[ind] = '';
                                    pos[ind] = null;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  color: Colors.grey,
                                  alignment: Alignment.center,
                                  child: Text('${uans[ind]}',
                                      style: TextStyle(fontSize: 24)),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 55,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: InkWell(
                                      onTap: () {
                                        int temp =
                                            Home.prefs!.getInt('point') ?? 0;
                                        B[0] =
                                            (b.contains(true) && (temp >= 10));
                                        int cnt = 0;
                                        for (int i = 0; i < uans.length; i++)
                                          if (uans.contains('')) cnt++;
                                        B[1] = (cnt > 1 && (temp >= 20));
                                        B[2]=(temp >= 30);
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                backgroundColor: Colors.black,
                                                title: Text('Hint',
                                                    style: TextStyle(
                                                        fontSize: 36,
                                                        color: Colors.white)),
                                                content: Container(
                                                  height: 300,
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          if (B[0]) {
                                                            int r;
                                                            while (true) {r = Random().nextInt(size);if (!pos.contains(r)) break;}
                                                            int i;
                                                            for (i = 0; i < 14; i++) {
                                                              if (ans[widget.ind][r] == q[i]) {
                                                                b[i] = false;
                                                                uans[r] = q[i];
                                                                pos[r] = i;
                                                                Home.prefs!.setInt('point', temp - 10);
                                                                break;
                                                              }
                                                            }
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Card(
                                                          child: ListTile(
                                                            enabled: B[0],
                                                            title: Text(
                                                                'One letter hint',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                )),
                                                            trailing: Text('10',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        24)),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          print(B[1]);
                                                          if (B[1]) {
                                                            int r;
                                                            int i;
                                                            while (true) {r = Random().nextInt(size);if (!pos.contains(r)) break;}
                                                            for (i = 0; i < 14; i++) {
                                                              if (ans[widget.ind][r] == q[i]) {
                                                                b[i] = false;
                                                                uans[r] = q[i];
                                                                pos[r] = i;
                                                                break;
                                                              }
                                                            }
                                                            while (true) {r = Random().nextInt(size);if (!pos.contains(r)) break;}
                                                            for (i = 0; i < 14; i++) {
                                                              if (ans[widget.ind][r] == q[i]) {
                                                                b[i] = false;
                                                                uans[r] = q[i];
                                                                pos[r] = i;
                                                                Home.prefs!.setInt('point', temp - 20);
                                                                break;
                                                              }
                                                            }
                                                          }
                                                          Navigator.pop(context);
                                                          setState(() {});
                                                        },
                                                        child: Card(
                                                        child: ListTile(
                                                          enabled: B[1],
                                                          title: Text(
                                                              'Two letter hint',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              )),
                                                          trailing: Text('20',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      24)),
                                                        ),
                                                      ),),
                                                      InkWell(
                                                        onTap: () {
                                                          if (B[2]) {
                                                            b = List.filled(14, true);
                                                            uans = List.filled(size, '');
                                                            pos = List.filled(size, null);
                                                            int r;
                                                            int i;
                                                            for(int j=0;j<uans.length;j++){
                                                              while (true) {
                                                                r = Random().nextInt(size);
                                                                if (!pos
                                                                    .contains(
                                                                        r))
                                                                  break;
                                                              }
                                                              for (i = 0;
                                                                  i < 14;
                                                                  i++) {
                                                                if (ans[widget
                                                                            .ind]
                                                                        [r] ==
                                                                    q[i]) {
                                                                  b[i] = false;
                                                                  uans[r] =
                                                                      q[i];
                                                                  pos[r] = i;
                                                                  Home.prefs!
                                                                      .setInt(
                                                                          'point',
                                                                          temp -
                                                                              30);
                                                                  break;
                                                                }
                                                              }
                                                            }
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Card(
                                                        child: ListTile( enabled: B[2],
                                                          title: Text(
                                                              'Remove extra letters',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              )),
                                                          trailing: Text('30',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      24)),
                                                        ),
                                                      ),),
                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text('CLOSE',
                                                              style: TextStyle(
                                                                  fontSize: 32,
                                                                  color: Colors
                                                                      .white)),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white30,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ));
                                          },
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text('Use hints',
                                            style: TextStyle(
                                                fontSize: 36,
                                                color: Colors.white)),
                                        margin:
                                            EdgeInsets.only(left: 40, right: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        b = List.filled(14, true);
                                        uans = List.filled(size, '');
                                        pos = List.filled(size, null);
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text('X',
                                            style: TextStyle(
                                                fontSize: 36,
                                                color: Colors.white)),
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        for (int i = uans.length - 1;
                                            i >= 0;
                                            i--) {
                                          if (uans[i] != '') {
                                            b[pos[i]] = true;
                                            uans[i] = '';
                                            pos[i] = null;
                                            break;
                                          }
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 20),
                                        alignment: Alignment.center,
                                        child: Text('⬅',
                                            style: TextStyle(
                                                fontSize: 36,
                                                color: Colors.white)),
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    )),
                                Expanded(child: SizedBox())
                              ],
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 200,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 7,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5),
                            itemCount: q.length,
                            itemBuilder: (context, ind) {
                              return Visibility(
                                visible: b[ind],
                                replacement: Container(),
                                child: InkWell(
                                  onTap: () {
                                    if (uans.contains('')) {
                                      for (int i = 0; i < uans.length; i++) {
                                        if (uans[i] == '') {
                                          pos[i] = ind;
                                          uans[i] = q[ind];
                                          b[ind] = false;
                                          break;
                                        }
                                      }
                                      print(uans);
                                      setState(() {});
                                    }
                                    if (ans[widget.ind].toString() ==
                                        uans.join('')) {
                                      Home.prefs!
                                          .setString('${widget.ind}', 'yes');
                                      Home.prefs!.setInt('point', 10);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Win'),
                                            content: Text('You win the level'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => setState(() {
                                                        widget.ind++;
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return gameplay(
                                                                widget.ind);
                                                          },
                                                        ));
                                                      }),
                                                  child: Text('NEXT'))
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    color: Colors.black,
                                    alignment: Alignment.center,
                                    child: Text('${q[ind]}',
                                        style: const TextStyle(
                                            fontSize: 24, color: Colors.white)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
            },
          )),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return level();
          },
        ));
        return true;
      },
    );
  }
}
