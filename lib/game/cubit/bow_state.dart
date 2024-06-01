part of 'bow_cubit.dart';

sealed class BowState extends Equatable {
  const BowState();

  bool get isInitial => this is BowInitialState;

  BowInitialState get asInitial => this as BowInitialState;

  @override
  List<Object> get props => [];
}

@autoequal
@CopyWith()
final class BowInitialState extends BowState {
  const BowInitialState({
    required this.timerState,
  });

  const BowInitialState.initial() : timerState = TimerState.initial;

  final TimerState timerState;
}
