import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'mypainter.dart';


class Sabiha extends StatefulWidget {
  @override
  _SabihaScreenState createState() => _SabihaScreenState();
}

class _SabihaScreenState extends State<Sabiha> {
  double percentage =0;
  int _counter = 0;
  int index= 0;
  double x;

  final data= [ 'سبحـان اللّـه','الحمد للّه', 'اللَه اكبر','لا اله الا اللَه وحده لا شريك له,له الملك وله الحمد,وهو علي كل شئ قدير'
  ];

  saveCount() async {
    SharedPreferences count = await SharedPreferences.getInstance();
    int savecount = count.getInt('counter');
    setState(() {
      _counter=savecount;
    });
  }

  saveIndex() async {
    SharedPreferences s_index = await SharedPreferences.getInstance();
    int saveindex = s_index.getInt('index');
    setState(() {
      index=saveindex;
    });
  }

  savePercentage() async {
    SharedPreferences s_percentage = await SharedPreferences.getInstance();
    double savepercentage = s_percentage.getDouble('percentage');
    setState(() {
      percentage = savepercentage;
    });
  }

  refresh() async {
    SharedPreferences count = await SharedPreferences.getInstance();
    SharedPreferences s_index = await SharedPreferences.getInstance();
    SharedPreferences s_percentage = await SharedPreferences.getInstance();
    setState(() {
      percentage = 0;
      s_percentage.setDouble('percentage', percentage);
      _counter=0;
      count.setInt('counter', _counter);
      index=0;
      s_index.setInt('index', index);
    });
  }

  @override
  void initState() {
    saveCount();
    saveIndex();
    savePercentage();
    super.initState();

  }

   _incrementCounter() async {
    SharedPreferences count = await SharedPreferences.getInstance();
    SharedPreferences s_index = await SharedPreferences.getInstance();
    SharedPreferences s_percentage = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      count.setInt('counter', _counter);
      percentage +=10;
      s_percentage.setDouble('percentage', percentage);

    });

    if(_counter==33){
      index++;
      s_index.setInt('index', index);
      Vibration.vibrate(duration: 200);
    }
    if(_counter==66){
      index++;
      s_index.setInt('index', index);
      Vibration.vibrate(duration: 200);
    }
    if(_counter==99){
      index++;
      s_index.setInt('index', index);
      Vibration.vibrate(duration: 200);

    }
    if(_counter==100){
      Vibration.vibrate(duration: 200);
      //refresh all value
      refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            //container for background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:AssetImage("assets/images/sbha.jpg"), ),
              ),
            ),
            //Positioned have iconButton for refresh all value
            Positioned(
              right: 10.0,
              top: 25.0,
              child: IconButton(
                icon: Icon(Icons.refresh,color: Colors.brown,size: 30,),
                iconSize: 25.0,
                onPressed: () {
                  refresh();
                },
              ),

            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //padding the OutlineButton that have text
                Padding(
                  padding: const EdgeInsets.only(top: 150,left: 8.0,right: 8.0),
                  child: Center(
                      child: OutlineButton(
                        onPressed: (){},
                        child: Padding(
                          padding:  EdgeInsets.all(10),
                          child: Text(data[index],textAlign: TextAlign.center,style: TextStyle(fontSize: 30,color: Colors.brown[700],fontWeight: FontWeight.w700)),
                        ),
                         highlightedBorderColor: Colors.brown,
                        borderSide: BorderSide(
                            width: 3,
                            color: Colors.brown[600]),

                        shape:  RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(10)),
                      )
                  ),
                ),
               //container keep that  circle and the button  counted  value
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  width:  MediaQuery.of(context).size.width/2,
                  child: new CustomPaint(
                    foregroundPainter: new MyPainter(
                        lineColor: Colors.brown[600],
                        completeColor: Color(0xFFBA8559),
                        completePercent: percentage,
                        width: 12.0
                    ),
                    child: new Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: new RaisedButton(
                          color: Colors.brown[700],
                          splashColor: Colors.brown[400],
                          shape: new CircleBorder(),
                          child: new Text('$_counter',style: TextStyle(
                              color: Color(0xFFC6AD91),fontSize: 35.0,
                              fontFamily: "number"
                          ),),
                          onPressed: (){
                            _incrementCounter();

                          }),
                    ),
                  ),
                ),

              ],
            ),

          ]
      ),
    );
  }
}
