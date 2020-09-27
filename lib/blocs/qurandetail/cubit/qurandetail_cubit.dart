import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qurandetail_state.dart';

class QurandetailCubit extends Cubit<QurandetailState> {
  QurandetailCubit() : super(QurandetailInitial());
}
