import 'dart:async';

import 'package:counter_spell_new/core.dart';

import 'package:counter_spell_new/widgets/stageboard/body/history/history_tile.dart';
import 'package:sidereus/reusable_widgets/animated_widgets/animated_list/sid_animated_list.dart';

class CSGameHistory {

  void dispose(){
    stateSubscription.cancel();
  } 

  //========================
  // Values
  final CSGame parent;
  final SidAnimatedListController listController;
  StreamSubscription stateSubscription;
  List<GameHistoryData> data = [];


  ///========================
  /// Constructor
  CSGameHistory(this.parent): 
    listController = SidAnimatedListController()
  {
    /// [CSGameGroup] Must be initialized after [CSGameState]
    stateSubscription = parent.gameState.gameState.behavior.listen(
      (state){
        final int newLen = state.historyLenght;
        final newData = [
          for(int i = 1; i < newLen; ++i)
            GameHistoryData.fromStates(state, i-1 , i,
              types: DamageTypes.fromPages(parent.parent.stageBloc.controller.pagesController.enabledPages.value),
              counterMap: parent.gameAction.currentCounterMap,
            ),
          GameHistoryNull(state, newLen - 1),
        ];

        data = newData;
        //remember to always call insert / remove / refresh from the state bloc
      }
    );
  }




  //========================
  // Actions

  void forward() => this.remember(1);
  void remember(int index) => this.listController.insert(
    index, 
    duration: CSAnimations.fast,
  );

  void back(GameHistoryData outgoingData, DateTime firstTime) => this.forget(1, outgoingData, firstTime);
  void forget(int index, GameHistoryData outgoingData, DateTime firstTime) => listController.remove(
    //0 = nonsense (the first column on the right is the current state)
    //1 = latest game action
    //history data lenght = first game action
    index, 
    ///this builder, and  the parameter [outgoingData] are critically important:
    /// the list is immediately updated but the UI is animated, so when you remove an item
    /// this builder will display it for the duration of the removing animation
    /// while the item is no longer actually in the data list!
    (context, animation) => SizeTransition(
      axisAlignment: -1.0,
      axis: Axis.horizontal,
      sizeFactor: animation,
      child: HistoryTile(
        outgoingData,
        firstTime: firstTime,
        index: index-1,
        counters: parent.gameAction.currentCounterMap,
        tileSize: null,
        defenceColor: parent.parent.themer.defenceColor.value,
        pageColors: parent.parent.stageBloc.controller.themeController.primaryColorsMap.value,
        avoidInteraction: true,
        coreTileSize: CSSizes.minTileSize,
        names: parent.gameGroup.names.value,
        havePartnerB: <String,bool>{for(final entry in parent.gameState.gameState.value.players.entries)
          entry.key: entry.value.havePartnerB,
        },
      )
    ),
    duration: CSAnimations.fast,
  );


}