import 'package:flutter/material.dart';

class QuranDetail extends StatelessWidget {

  final List dataSurah;

  QuranDetail({ this.dataSurah });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Quran Detail'),),
    );
  }
}