import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:redfox_music/collaction/bottomNavigation.dart';
import 'package:redfox_music/collaction/sizeBoxes.dart';

class Playear extends StatefulWidget {
  final Map data;
  Playear({Key key, this.data}) : super(key: key);
  @override
  _PlayearState createState() => _PlayearState();
}

class _PlayearState extends State<Playear> {
  static AudioPlayer advancedPlayer = new AudioPlayer();
  AudioCache audioCache = new AudioCache(fixedPlayer: advancedPlayer);
  Duration _duration = new Duration();
  Duration _position = new Duration();

  String start, end;

  IconData icon;
  Function onpresed;
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 80, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.orange,
        inactiveColor: Colors.white,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
            start = _position.inSeconds.round().toString();
            end = (_duration.inSeconds.toDouble() -
                    _position.inSeconds.toDouble())
                .round()
                .toString();
          });
        });
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    advancedPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });
    advancedPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });
  }


  Future<bool> _onBack() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Do You Want to stop the music'),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text('yes'),
                  onPressed: () {
                    advancedPlayer.pause();
                    Navigator.pop(context, true);
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.grey.shade900,
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                "${widget.data["img"]}",
                fit: BoxFit.fitHeight,
              ),
              BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  )),
              ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("${widget.data["img"]}"),
                            fit: BoxFit.cover)),
                  ),
                  Center(
                    child: Text('Now Playing',
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                  Center(
                    child: Image.asset(
                      "${widget.data["img"]}",
                      height: MediaQuery.of(context).size.height / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text("${widget.data["title"]}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0)),
                        Text("${widget.data["name"]}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                          (_position.inSeconds / 60)
                              .toStringAsFixed(2)
                              .toString(),
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                      Expanded(
                        child: slider(),
                      ),
                      Text(
                          ((_duration.inSeconds.toDouble() -
                                      _position.inSeconds.toDouble()) /
                                  60)
                              .toStringAsFixed(2)
                              .toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20.0))
                    ],
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      sizeBox(20, Icons.favorite_border, () {}),
                      sizeBox(40, Icons.skip_previous,
                          () => seekToSecond(_position.inSeconds.toInt() - 10)),
                      sizeBox(40, Icons.play_circle_filled, () {
                        audioCache.play("${widget.data["mp3"]}");
                      }),
                      sizeBox(40, Icons.pause_circle_filled,
                          () => advancedPlayer.pause()),
                      sizeBox(40, Icons.skip_next,
                          () => seekToSecond(_position.inSeconds.toInt() + 10)),
                      sizeBox(20, Icons.shuffle, () {}),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 40.0,
          items: collactionbottonNavigationItem(),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepOrangeAccent,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
