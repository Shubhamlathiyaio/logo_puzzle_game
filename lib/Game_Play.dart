import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'Level.dart';

class gameplay extends StatefulWidget {
  int ind;

  gameplay(this.ind);

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
  "WIKIPEDIA"
];

class _gameplayState extends State<gameplay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(all[widget.ind]);
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
  int size=0;

  qna() {
    print('called');
    size=ans[widget.ind].length;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      onPageChanged: (value) {
        widget.ind=value;
        print(widget.ind);
        size=ans[widget.ind].length;
        qna();
        // setState(() {});
      },
      controller:PageController(initialPage: widget.ind),
      itemCount: all.length,
      itemBuilder: (context, index) {
        return (Home.prefs!.getString('${widget.ind}')=='yes') ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 200, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed:() {
                  if(widget.ind>0)
                  {
                    widget.ind-=1;
                    size=ans[widget.ind].length;
                    qna();
                    setState(() {});
                  }
                }, icon: Icon(Icons.keyboard_arrow_left,size: 48,))  ,
                Image.asset(all[widget.ind]),
                IconButton(onPressed: () {
                  if(widget.ind<ans.length-1)
                  {
                    widget.ind+=1;
                    size=ans[widget.ind].length;
                    qna();
                    setState(() {});
                  }
                }, icon: Icon(Icons.keyboard_arrow_right,size: 48,))  ,
              ],
            )),Container(height: 400,color: Colors.green,alignment: Alignment.center,child: Text('${ans[widget.ind]}',style: TextStyle(fontSize: 72)),)
          ],
        ) :Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 200, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed:() {
                  if(widget.ind>0)
                  {
                    widget.ind-=1;
                    size=ans[widget.ind].length;
                    qna();
                    setState(() {});
                  }
                }, icon: Icon(Icons.keyboard_arrow_left,size: 48,))  ,
                Image.asset(all[widget.ind]),
                IconButton(onPressed: () {
                  if(widget.ind<ans.length-1)
                  {
                    widget.ind+=1;
                    size=ans[widget.ind].length;
                    qna();
                    setState(() {});
                  }
                }, icon: Icon(Icons.keyboard_arrow_right,size: 48,))  ,
              ],
            )),
            Container(
              height: 200,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            SizedBox(
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
                    replacement: Container(
                      color: Colors.black,
                    ),
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
                        if (ans[widget.ind].toString() == uans.join(''))
                        {
                          Home.prefs!.setString('${widget.ind}','yes');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(title: Text('Win'),content: Text('You win the level'),actions: [TextButton(onPressed: () => setState(() {
                                widget.ind++;
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                  return gameplay(widget.ind);
                                },)) ;
                              }), child: Text('NEXT'))
                              ],);
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
    ));
  }
}
