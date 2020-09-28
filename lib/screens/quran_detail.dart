import 'package:alquranMobile/utils/Colors.dart';
import 'package:flutter/material.dart';

import 'package:alquranMobile/models/QuranListModel.dart';

class QuranDetail extends StatelessWidget {

  final QuranListModel dataSurah;

  QuranDetail({ this.dataSurah });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      bottom: PreferredSize(
        child: Container(
          color: ColorBase.separator,
          height: 1.0,
        ),
      preferredSize: Size.fromHeight(1)
      ),
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${dataSurah.suratName} ( ${dataSurah.suratText} )',
            style: TextStyle(
              color: ColorBase.black
            ),
          ),
          Text(
            '${dataSurah.suratTerjemahan} - ${dataSurah.countAyat} Ayat',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
      backgroundColor: ColorBase.white,
    ),
      body: Center(child: Text(dataSurah.suratName)),
    );
  }
}