import 'package:flutter/material.dart';
import 'package:alquranMobile/components/Appbar.dart';
import 'package:alquranMobile/constants/Dictionary.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Dictionary.settings,
      ),
      body: Center(child: Text('Settings')),
    );
  }
}