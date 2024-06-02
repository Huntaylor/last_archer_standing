import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:last_archer_standing/game/components/bow_timer_bar_component.dart';
import 'package:logging/logging.dart';

part 'bow_state.dart';
part 'bow_cubit.g.dart';

class BowCubit extends Cubit<BowState> {
  static final Logger _log = Logger('Bow Cubit');
  BowCubit()
      : super(
          const BowInitialState.initial(),
        );

  void arrowFired({required bool hasFired}) {
    _log.info('Arrow Fired Called');
    emit(
      state.asInitial.copyWith(
        hasFired: hasFired,
      ),
    );
  }

  void setTimer({
    required TimerState timerState,
  }) {
    _log.info('Set Timer Called');
    emit(
      state.asInitial.copyWith(
        timerState: timerState,
      ),
    );
  }
}
