import 'package:alquranMobile/blocs/qurandetail/cubit/qurandetail_cubit.dart';
import 'package:alquranMobile/models/QuranDetailModel.dart';
import 'package:alquranMobile/utils/FontsFamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alquranMobile/utils/Colors.dart';
import 'package:alquranMobile/models/QuranListModel.dart';
import 'package:html/parser.dart';

class QuranDetail extends StatefulWidget {

  final QuranListModel dataSurah;

  QuranDetail({ this.dataSurah });

  @override
  _QuranDetailState createState() => _QuranDetailState();
}

class _QuranDetailState extends State<QuranDetail> {

  @override
  void initState() {
    context.bloc<QurandetailCubit>().getQuranDetail(
      widget.dataSurah.id.toString(), 
      widget.dataSurah.countAyat.toString()
    );
    super.initState();
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
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedState) {
            return Container(
              color: ColorBase.white,
              child: RefreshIndicator(
                onRefresh: () => context.bloc<QurandetailCubit>().getQuranDetail(
                  widget.dataSurah.id.toString(), 
                  widget.dataSurah.countAyat.toString()
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: 1, 
                  ),
                  itemCount: state.quranDetail.length,
                  itemBuilder: (context, index) {
                    final quranDetail = state.quranDetail[index];
                    return buildListTile(quranDetail);
                  }
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

  Widget buildListTile(QuranDetailModel quranDetail) {
    
    String removeHTMLTag(String text) {
      final document = parse(text);
      final String parsedString = parse(document.body.text).documentElement.text;

      return parsedString;
    }

    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      borderOnForeground: false,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          height: 45,
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
            fontSize: 27.0
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            removeHTMLTag(quranDetail.translationAyaText),
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