import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:redfox_music/page/playear.dart';
import 'package:redfox_music/collaction/bottomNavigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];
  Future<List> _loadJsoData() async {
    var jsonText = await rootBundle.loadString('assets/data.json');

    data = json.decode(jsonText);
    return data;
  }

  int _selectedIndex = 0;
@override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }
  static const TextStyle optionStyle =
      TextStyle(fontSize: 80, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          title: Text('redfoxe music'),
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){},
            )
          ],
        ),
        backgroundColor: Colors.grey.shade900,
        body: Container(
          child: FutureBuilder(
            future: _loadJsoData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Center(
                          child: Text(
                        data[index]['jenre'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                      Container(
                        height: 200.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: data[index]['list'].length,
                          itemBuilder: (BuildContext context, int index2) {
                            return Container(
                              width: 170,
                              margin: EdgeInsets.all(0.0),
                              child: FlatButton(
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        data[index]['list'][index2]['img'],
                                        width: double.infinity,
                                        height: 165.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        data[index]['list'][index2]['title'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 3),
                                      ),
                                      Text(
                                        data[index]['list'][index2]['name'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Playear(
                                          data: data[index]['list'][index2]),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 40.0,
          items: collactionbottonNavigationItem(),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
