import 'package:alquranMobile/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alquranMobile/utils/FontsFamily.dart';
import 'package:alquranMobile/screens/quran_list.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: ColorBase.white));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Quran Mobile',
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        fontFamily: FontsFamily.roboto
      ),
      home: QuranListPage(),
    );
  }
}
