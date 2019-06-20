import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List collactionbottonNavigationItem(){
  return <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.black38,
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            title: Text(
              'Library',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            title: Text(
              'Playlist',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text(
              'Sething',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ];
}