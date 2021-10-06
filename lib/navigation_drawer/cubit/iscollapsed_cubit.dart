import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'iscollapsed_state.dart';

class IscollapsedCubit extends Cubit<bool> {
  IscollapsedCubit() : super(true);

  void toggle() => emit(!state);
}
