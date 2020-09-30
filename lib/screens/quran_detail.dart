
import 'package:alquranMobile/models/BasmallahModel.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alquranMobile/utils/Colors.dart';
import 'package:alquranMobile/utils/Helpers.dart';
import 'package:alquranMobile/models/QuranDetailModel.dart';
import 'package:alquranMobile/utils/FontsFamily.dart';
import 'package:alquranMobile/models/QuranListModel.dart';
import 'package:alquranMobile/blocs/qurandetail/cubit/qurandetail_cubit.dart';

class QuranDetail extends StatefulWidget {
  final QuranListModel dataSurah;

  QuranDetail({ this.dataSurah });

  @override
  _QuranDetailState createState() => _QuranDetailState();
}

class _QuranDetailState extends State<QuranDetail> {

  Basmallah basmallah;

  void initState() {
    context.bloc<QurandetailCubit>().getQuranDetail(
      widget.dataSurah.id.toString(), 
      widget.dataSurah.countAyat.toString()
    );
    renderBasmallah();
    super.initState();
  }

  void renderBasmallah() async {
    Basmallah basmallah = await loadBasmallah();
    this.basmallah = basmallah;
  }

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
            '${widget.dataSurah.suratName} ( ${widget.dataSurah.suratText} )',
            style: TextStyle(
              color: ColorBase.black
            ),
          ),
          Text(
            '${widget.dataSurah.suratTerjemahan} - ${widget.dataSurah.countAyat} Ayat',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
      backgroundColor: ColorBase.white,
    ),
      body: BlocConsumer<QurandetailCubit, QurandetailState>(
        listener: (context, state) {
          if (state is ErrorState) {
            Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gagal mendapatkan detail surah'),
                ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: Container(
                color: ColorBase.white,
                child: CircularProgressIndicator()
              ),
            );
          } else if (state is LoadedState) {
            return Container(
              color: ColorBase.white,
              child: RefreshIndicator(
                onRefresh: () => context.bloc<QurandetailCubit>().getQuranDetail(
                  widget.dataSurah.id.toString(), 
                  widget.dataSurah.countAyat.toString()
                ),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: buildBasmallah(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final int itemIndex = index ~/ 2;
                          if (index.isEven) {
                            final quranDetail = state.quranDetail[itemIndex];
                            return buildListTile(quranDetail);
                          } else {
                            return Divider();
                          }
                        },
                        semanticIndexCallback: (Widget widget, int localIndex) {
                          if (localIndex.isEven) {
                            return localIndex ~/ 2;
                          }
                          return null;
                        },
                        childCount: math.max(0, state.quranDetail.length * 2 - 1),
                      )
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildBasmallah() {
    return widget.dataSurah.id == 1 || widget.dataSurah.id == 9 ? null : Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(
            basmallah.ayatArab,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontsFamily.lpmq,
              fontSize: 30
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget buildListTile(QuranDetailModel quranDetail) {
    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      borderOnForeground: false,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          height: 45,
          margin: EdgeInsets.only(right: 0.0),
          width: 45,
          decoration: BoxDecoration(
            border: Border.all(color: ColorBase.separator, width: 2.0),
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(
          quranDetail.ayaNumber.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
            color: ColorBase.grey
            ),
          )),
        ),
        title: Text(
          quranDetail.ayaText, 
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: FontsFamily.lpmq,
            fontSize: 27.0,
            height: 2.1
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            Helper.removeHTMLTag(quranDetail.translationAyaText),
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: ColorBase.grey,
              height: 2,
            ),
          )
        ),
      ),
    );
  }
}