import 'package:flutter/material.dart';

import 'package:alquranMobile/utils/Colors.dart';
import 'package:alquranMobile/components/Appbar.dart';
import 'package:alquranMobile/constants/Dictionary.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Dictionary.about,
      ),
      body: Container(
        color: ColorBase.white,
        child: Center(
          child: Container(
            child: Text('About')
          )
        )
      ),
    );
  }
}