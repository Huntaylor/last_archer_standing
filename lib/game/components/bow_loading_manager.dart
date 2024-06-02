import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:last_archer_standing/game/components/bow_timer_bar_component.dart';
import 'package:last_archer_standing/game/cubit/bow_cubit.dart';
import 'package:last_archer_standing/game/last_archer_standing.dart';
import 'package:logging/logging.dart';

class BowLoadingManager extends PositionComponent
    with
        HasGameRef<LastArcherStandingGame>,
        FlameBlocListenable<BowCubit, BowState> {
  static final Logger _log = Logger('Bow Loading Manager');
  BowLoadingManager({
    required this.timerBar,
    super.position,
    super.scale,
    super.angle,
    super.children,
    super.priority,
  });

  final InteractionTimerBar timerBar;

  late TimerState timerState;
  late double arrowReleaseTime;
  late bool shouldAddBar;

  @override
  bool listenWhen(BowState previousState, BowState newState) {
    _log.info('Previous State: $previousState, New State: $newState');
    final playerState = newState.asInitial;
    timerState = playerState.timerState;
    arrowReleaseTime = 1;
    if (playerState.hasFired) {
      bloc.arrowFired(hasFired: false);
      _log.info('Player has fired: ${playerState.hasFired}');
      bloc.setTimer(timerState: TimerState.inProgress);
      shouldAddBar = true;
    } else if (timerState == TimerState.complete) {
      _log.info('Timer State is completed: $timerState');
      bloc.setTimer(timerState: TimerState.initial);
      shouldAddBar = false;
    }
    return super.listenWhen(previousState, newState);
  }

  @override
  FutureOr<void> onLoad() {
    timerState = TimerState.initial;
    shouldAddBar = false;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (shouldAddBar && !contains(timerBar)) {
      add(
        timerBar..interactionTime = arrowReleaseTime,
      );
    } else if (!shouldAddBar && contains(timerBar)) {
      remove(timerBar);
    }
    super.update(dt);
  }
}
