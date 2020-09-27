import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quranlist_state.dart';

class QuranlistCubit extends Cubit<QuranlistState> {
  QuranlistCubit() : super(QuranlistInitial());
}
