import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hackathon2/Appoitment/appointment.dart';
import 'package:hackathon2/Blogs%20and%20post/blogs.dart';
import 'package:hackathon2/Blogs%20and%20post/post.dart';
import 'package:hackathon2/Doctor/Login1%20and%20signup1/Firstscreen/appointment.dart';
import 'package:hackathon2/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index = 0;
  void tapped(int index1) {
    setState(() {
      index = index1;
    });
  }

  Future read() async {
    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(uid1)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values;
      values = snapshot.value;

      values.forEach((key, value) {
        //
        FirebaseDatabase.instance
            .reference()
            .child("Users")
            .child(uid1)
            .child("username")
            .once()
            .then((DataSnapshot s) {
          globalname = s.value;
        });
      });
      values.forEach((key, value) {
        //
        FirebaseDatabase.instance
            .reference()
            .child("Users")
            .child(uid1)
            .child("image")
            .once()
            .then((DataSnapshot s) {
          globalimage = s.value;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widget1 = [
      Blogs(),
      Post(),
      Appointment3(),
      /*Profile()*/
    ];

    return Scaffold(
      body: widget1.elementAt(index),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF222222),
        ),
        child: BottomNavigationBar(
            showSelectedLabels: true,
            unselectedItemColor: Colors.white70,
            showUnselectedLabels: true,
            elevation: 18,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.white,
            currentIndex: index,
            onTap: tapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), title: Text("Add")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline), title: Text("Appointment")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text("Profile"))
            ]),
      ),
    );
  }
}