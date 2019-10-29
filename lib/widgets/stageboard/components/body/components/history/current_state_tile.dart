import 'package:counter_spell_new/game_model/model.dart';
import 'package:counter_spell_new/game_model/types/counters.dart';
import 'package:counter_spell_new/game_model/types/damage_type.dart';
import 'package:counter_spell_new/models/ui/type_ui.dart';
import 'package:counter_spell_new/structure/damage_types_to_pages.dart';
import 'package:counter_spell_new/structure/pages.dart';
import 'package:counter_spell_new/themes/cs_theme.dart';
import 'package:flutter/material.dart';

import 'package:counter_spell_new/game_model/game_state.dart';


class CurrentStateTile extends StatelessWidget {
  final List<String> names;
  final double tileSize;
  final double coreTileSize;
  final Map<String, Counter> counters;
  final int stateIndex;
  final GameState gameState;
  final CSTheme theme;
  final Map<CSPage,Color> pagesColor;

  const CurrentStateTile(this.gameState, this.stateIndex,{
    @required this.names,
    @required this.tileSize,
    @required this.coreTileSize,
    @required this.theme,
    @required this.counters,
    @required this.pagesColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Material(
        elevation: 4,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(children: <Widget>[
          for(final name in names)
            CurrentStatePlayerTile(
              gameState, 
              stateIndex,
              name: name,
              pagesColor: pagesColor,
              tileSize: tileSize,  
              coreTileSize: coreTileSize,
              counters: counters,
              theme: theme,
            ),
        ]),
      ),
    );

  }
}

class CurrentStatePlayerTile extends StatelessWidget {
  final String name;
  final int stateIndex;
  final GameState gameState;
  final double tileSize;
  final double coreTileSize;
  final CSTheme theme;
  final Map<String, Counter> counters;
  final Map<CSPage,Color> pagesColor;

  const CurrentStatePlayerTile(this.gameState, this.stateIndex, {
    @required this.name,
    @required this.tileSize,
    @required this.coreTileSize,
    @required this.theme,
    @required this.pagesColor,
    @required this.counters,
  });

  @override
  Widget build(BuildContext context) {
    final PlayerState playerState = gameState.players[name].states[stateIndex];
    final double width = coreTileSize;

    return Container(
      height: tileSize,
      width: width,
      alignment: Alignment.center,
      child: SizedBox(
        height: coreTileSize,
        width: width,
        child: Stack(children: <Widget>[
          //for now there is just the life here in the center
          //we'll need an adaptive layout given the enabled pages (commander / counters)
          //and the enabled counters themselves
          Center(
            child: PieceOfInformation(
              damageType: DamageType.life,
              value: playerState.life,
              pagesColor: pagesColor,
              theme: theme,
            ),
          ),
          // for other counters, just sum up to the counters that are present in the map,
          // this way you won't count disabled counters 
        ]),
      ),
    );
  }
}

class PieceOfInformation extends StatelessWidget {
  final DamageType damageType;
  final bool attacking;
  final int value;
  final CSTheme theme;
  final Map<CSPage,Color> pagesColor;

  PieceOfInformation({
    @required this.pagesColor,
    @required this.damageType,
    @required this.value,
    @required this.theme,
    this.attacking,
  }): assert(!(
    damageType == DamageType.commanderDamage 
    && attacking == null
  ));

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    Color color;
    IconData icon;

    if(damageType == DamageType.commanderDamage){
      color = attacking ? pagesColor[CSPage.commanderDamage]: theme.commanderDefence;
      icon = attacking ? CSTypesUI.attackIconOne : CSTypesUI.defenceIconFilled;
    } else {
      color = pagesColor[damageToPage[damageType]];
      icon = CSTypesUI.typeIconsFilled[damageType];
    }

    final littleDarker = themeData.colorScheme.onSurface.withOpacity(0.1); 
    color = Color.alphaBlend(littleDarker, color);

    return Container(
      decoration: BoxDecoration(
        color: littleDarker,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon, 
            color: color,
            size: 15,
          ),
          Text(
            "$value",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}