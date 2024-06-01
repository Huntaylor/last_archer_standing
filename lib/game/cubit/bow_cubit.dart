import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:last_archer_standing/game/components/bow_timer_bar_component.dart';

part 'bow_state.dart';
part 'bow_cubit.g.dart';

class BowCubit extends Cubit<BowState> {
  BowCubit() : super(const BowInitialState.initial());

  void setTimer({
    required TimerState timerState,
  }) {
    emit(
      state.asInitial.copyWith(
        timerState: timerState,
      ),
    );
  }
}
