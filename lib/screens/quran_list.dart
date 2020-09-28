import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alquranMobile/repositories/QuranListRepository.dart';
import 'package:alquranMobile/blocs/quranlist/cubit/quranlist_cubit.dart';

class QuranListPage extends StatefulWidget {
  @override
  _QuranListPageState createState() => _QuranListPageState();
}

class _QuranListPageState extends State<QuranListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranlistCubit(
        repository: QuranListRepository()
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contoh App'),
        ),
        body: BlocBuilder<QuranlistCubit, QuranlistState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorState) {
              return Center(
                child: Icon(Icons.close),
              );
            } else if (state is LoadedState) {
              final movies = state.quranList;

              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(movies[index].suratName),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}