import 'dart:math';

import 'package:counter_spell_new/models/game/types/counters.dart';

import '../model.dart';

class PACounter extends PlayerAction {
  final int increment;
  final int minVal;
  final int maxVal;
  final Counter counter;

  const PACounter(
    this.increment, 
    this.counter,
    {
      int minVal = PlayerState.kMinValue, 
      int maxVal = PlayerState.kMaxValue,
    }
  ):  minVal = minVal ?? PlayerState.kMinValue,
      maxVal = maxVal ?? PlayerState.kMaxValue;

  @override
  PlayerState apply(PlayerState state) => state.incrementCounter(
    counter, 
    increment,
    minValue: minVal,
    maxValue: maxVal,
  );

  @override
  PlayerAction normalizeOn(PlayerState state) {
    final int current  = state.counters[this.counter.longName] ?? 0;
    final int clamped = this.increment.clamp(
      (max(this.minVal, counter.minValue)) - current,
      (min(this.maxVal, counter.maxValue)) - current,
    );

    if(clamped == 0) 
      return PANull.instance;

    return PACounter(
      clamped,
      this.counter,
      minVal: this.minVal,
      maxVal: this.maxVal,
    );
  }
}