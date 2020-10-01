import 'package:alquranMobile/utils/Colors.dart';
import 'package:flutter/material.dart';

import 'package:alquranMobile/constants/Dictionary.dart';

class BottomSheetItem {
  final Text title;
  final Icon icon;
  final Function onPress;

  BottomSheetItem({
    this.title,
    this.icon,
    this.onPress
  });
}

List<BottomSheetItem> bottomSheetLists = [
  BottomSheetItem(
    title: Text(Dictionary.playSurah),
    icon: Icon(Icons.play_arrow, color: ColorBase.black),
    onPress: () {}
  ),
  BottomSheetItem(
    title: Text(Dictionary.showTafsir),
    icon: Icon(Icons.book, color: ColorBase.black),
    onPress: () {}
  ),
  BottomSheetItem(
    title: Text(Dictionary.copyAyat),
    icon: Icon(Icons.content_copy, color: ColorBase.black),
    onPress: () {}
  ),
  BottomSheetItem(
    title: Text(Dictionary.shareAyat),
    icon: Icon(Icons.share, color: ColorBase.black),
    onPress: () {}
  )
];