import 'package:counter_spell_new/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:stage_board/stage_board.dart';


class CounterSelector extends StatelessWidget {
  const CounterSelector();
  static const height = 400.0;
  @override
  Widget build(BuildContext context) {
    final bloc = CSBloc.of(context);
    final counterSet = bloc.game.gameAction.counterSet;

    return SingleChildScrollView(
      physics: StageBoard.of(context).scrollPhysics(),
      child: counterSet.build((context, current)
        => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for(final counter in counterSet.list)
              RadioListTile<String>(
                groupValue: current.longName,
                value: counter.longName,
                onChanged: (name) => counterSet.choose(
                  counterSet.list.indexWhere((c) => c.longName == name),
                ),
                title: Text(counter.longName),
                secondary: Icon(counter.icon),
              ),
          ],
        ),
      ),
    );
  }
}