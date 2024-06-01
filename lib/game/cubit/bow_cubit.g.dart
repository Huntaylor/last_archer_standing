// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bow_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BowInitialStateCWProxy {
  BowInitialState timerState(TimerState timerState);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BowInitialState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BowInitialState(...).copyWith(id: 12, name: "My name")
  /// ````
  BowInitialState call({
    TimerState? timerState,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBowInitialState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBowInitialState.copyWith.fieldName(...)`
class _$BowInitialStateCWProxyImpl implements _$BowInitialStateCWProxy {
  const _$BowInitialStateCWProxyImpl(this._value);

  final BowInitialState _value;

  @override
  BowInitialState timerState(TimerState timerState) =>
      this(timerState: timerState);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BowInitialState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BowInitialState(...).copyWith(id: 12, name: "My name")
  /// ````
  BowInitialState call({
    Object? timerState = const $CopyWithPlaceholder(),
  }) {
    return BowInitialState(
      timerState:
          timerState == const $CopyWithPlaceholder() || timerState == null
              ? _value.timerState
              // ignore: cast_nullable_to_non_nullable
              : timerState as TimerState,
    );
  }
}

extension $BowInitialStateCopyWith on BowInitialState {
  /// Returns a callable class that can be used as follows: `instanceOfBowInitialState.copyWith(...)` or like so:`instanceOfBowInitialState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BowInitialStateCWProxy get copyWith => _$BowInitialStateCWProxyImpl(this);
}
