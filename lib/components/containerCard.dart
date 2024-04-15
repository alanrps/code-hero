import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ContainerCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  ContainerCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: HexColor('#D42026'),
      // elevation: 4.0,
      // margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(value, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}