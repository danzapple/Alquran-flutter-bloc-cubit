import 'package:dio/dio.dart';
import 'package:alquranMobile/models/QuranListModel.dart';

class QuranListRepository {
  var dio = Dio();

  Future<List<QuranListModel>?> getQuranList() async {
    String url = 'https://quran.kemenag.go.id/index.php/api/v1/surat';

    try {
      Response response = await dio.get(url);
      return response.data['data'].map<QuranListModel>((json) => QuranListModel.fromJson(json)).toList();
    } catch (e) {
      throw e;
    }
  }

}