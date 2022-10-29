import 'package:audiojet/constants.dart';
import 'package:flutter/material.dart';

class TabWindow extends StatefulWidget {
  const TabWindow({super.key});

  @override
  State<TabWindow> createState() => _TabWindowState();
}

class _TabWindowState extends State<TabWindow> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[_selectedIndex],
      bottomNavigationBar: _CustomNavbarWidget(
        callBack: _onItemTapped,
      ),
    );
  }
}

//bottomNavigationBar
class _CustomNavbarWidget extends StatefulWidget {
  Function(int) callBack;
  _CustomNavbarWidget({Key? key, required this.callBack}) : super(key: key);

  @override
  State<_CustomNavbarWidget> createState() => _CustomNavbarWidgetState();
}

class _CustomNavbarWidgetState extends State<_CustomNavbarWidget> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        backgroundColor: Colors.deepPurple.shade800,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            _index = value;
          });

          widget.callBack(value);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.music_note_outlined),
              activeIcon: Icon(Icons.music_note),
              label: "Songs"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: "Favorites"),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play_outlined),
              activeIcon: Icon(Icons.playlist_play),
              label: "PlayList"),
        ]);
  }
}
