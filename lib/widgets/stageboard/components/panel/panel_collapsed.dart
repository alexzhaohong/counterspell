import 'package:counter_spell_new/blocs/bloc.dart';
import 'package:counter_spell_new/blocs/sub_blocs/themer.dart';
import 'package:counter_spell_new/themes/cs_theme.dart';
import 'package:counter_spell_new/themes/material_community_icons.dart';
import 'package:counter_spell_new/themes/my_durations.dart';
import 'package:counter_spell_new/widgets/constants.dart';
import 'package:counter_spell_new/widgets/resources/playgroup/playgroup.dart';
import 'package:counter_spell_new/widgets/stageboard/components/panel/delayer.dart';
import 'package:counter_spell_new/widgets/simple_view/simple_group_route.dart';
import 'package:flutter/material.dart';
import 'package:sidereus/sidereus.dart';

class CSPanelCollapsed extends StatelessWidget {
  const CSPanelCollapsed({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final CSBloc bloc = CSBloc.of(context);
    final gameStateBloc = bloc.game.gameState;
    final stageBoard = StageBoard.of(context);
    return bloc.themer.themeSet.build((context, theme){
      

      final Widget backButton = gameStateBloc.gameState.build( (context, state)
        => _panelButton(gameStateBloc.backable, Icons.undo, gameStateBloc.back),
      );

      final Widget forwardButton = gameStateBloc.futureActions.build( (context, futures)
        => _panelButton(gameStateBloc.forwardable, Icons.redo, gameStateBloc.forward),
      );

      final simpleDisplayer = gameStateBloc.gameState.build( (context, state){
        final bool active = [2,3,4].contains(state.players.length);
        return AnimatedOpacity(
          duration: MyDurations.fast,
          opacity: active ? 1.0 : 0.35,
          child: InkResponse(
            child: Container(
              height: CSConstants.barSize,
              width: CSConstants.barSize,
              child: Icon(
                Icons.import_contacts,
                size: 22.0,
              ),
            ),
            onTap: active ? ()=> showSimpleGroup(context: context, bloc: bloc) : null,
          )
        ); 
      });
      final groupDisplayer = gameStateBloc.gameState.build( (context, state){
        final bool active = true;
        return AnimatedOpacity(
          duration: MyDurations.fast,
          opacity: active ? 1.0 : 0.35,
          child: InkResponse(
            child: Container(
              height: CSConstants.barSize,
              width: CSConstants.barSize,
              child: Icon(
                McIcons.account_multiple_outline,
              ),
            ),
            onTap: active ? () => stageBoard.showAlert(
              PlayGroupAlert(),
              dimension: (bloc.game.gameGroup.names.value.length + 1).clamp(2, 6.5) * 56.0 + 32.0
            ) : null,
          )
        ); 
      });

      final Widget backForward = Row(children: <Widget>[
        simpleDisplayer,
        const Spacer(),
        backButton, 
        forwardButton,
        const Spacer(),
        groupDisplayer,
      ]);

      /// missing: restarter

      return Material(
        type: MaterialType.transparency,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              height: CSConstants.barSize,
              child: backForward
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              height: CSConstants.barSize,
              child: _DelayerPanel(theme: theme, bloc: bloc,),
            ),
          ]
        )
      );
    });
  }

  static Widget _panelButton(bool active, IconData icon, VoidCallback action)
    => AnimatedOpacity(
      duration: MyDurations.fast,
      opacity: active ? 1.0 : 0.35,
      child: InkResponse(
        child: Container(
          height: CSConstants.barSize,
          width: CSConstants.barSize * 1.3,
          child: Icon(
            icon,
            size: 20.0,
          ),
        ),
        onTap: active ? action : null,
      )
    );
}


class _DelayerPanel extends StatelessWidget {
  _DelayerPanel({
    @required this.theme,
    @required this.bloc,
  });
  final CSBloc bloc;
  final CSTheme theme;

  @override
  Widget build(BuildContext context) {
    final actionBloc = bloc.game.gameAction;
    final scroller = bloc.scroller;
    final themeData = theme.data;
    final canvas = themeData.colorScheme.surface;
    final canvasContrast = themeData.colorScheme.onSurface;
    final stageBoard = StageBoard.of(context);
    final page = stageBoard.pagesController.page;
    final pageThemes = stageBoard.pagesController.pageThemes;
    
    return BlocVar.build4(
      scroller.isScrolling,
      scroller.intValue,
      bloc.settings.confirmDelay,
      actionBloc.isCasting,
      distinct: true,
      builder: (
        BuildContext context, 
        bool scrolling,
        int increment,
        Duration confirmDelay,
        bool casting,
      ){
        final accentColor = Color.alphaBlend(
          CSThemer.getScreenColor(
            theme: theme,
            page: page,
            pageThemes: pageThemes,
            casting: casting,
            open: false,
          ).withOpacity(0.8), 
          canvas,
        );
        return AnimatedOpacity(
          duration: MyDurations.veryFast,
          curve: Curves.decelerate,
          opacity: scrolling ? 1.0 : 0.0,
          child: IgnorePointer(
            ignoring: scrolling ? false : true,
            child: Delayer(
              half: false,
              message: increment >= 0 ? '+ $increment' : '- ${- increment}',

              delayerController: scroller.delayerController,
              animationListener: scroller.delayerAnimationListener,
              onManualCancel: scrolling ? scroller.cancel : null,
              onManualConfirm: scrolling ? scroller.forceComplete : null,

              primaryColor: canvas,
              onPrimaryColor: canvasContrast,
              accentColor: accentColor,
              onAccentColor: themeData.colorScheme.onPrimary,
              style: themeData.primaryTextTheme.body1,

              height: CSConstants.barSize,
              duration: confirmDelay,
              circleOffset: 44, //Floating Action Button
            ),
          ),
        );
      }
    );  
  }
}