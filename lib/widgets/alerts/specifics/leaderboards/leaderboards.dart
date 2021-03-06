import 'package:counter_spell_new/core.dart';
import 'components/all.dart';

enum _LeadType {
  games,
  players,
  commanders,
  settings,
}

class Leaderboards extends StatelessWidget {
  
  const Leaderboards();
  
  static const double height = 650.0;

  @override
  Widget build(BuildContext context) {
    return RadioHeaderedAlert<_LeadType>(
      initialValue: _LeadType.games,
      orderedValues: [_LeadType.commanders, _LeadType.games, _LeadType.players, _LeadType.settings],
      items: items,
      animatedSwitch: false,
    );
  }
  

  static const Map<_LeadType,RadioHeaderedItem> items = const <_LeadType,RadioHeaderedItem>{

    _LeadType.commanders: RadioHeaderedItem(
      longTitle: "Commanders' stats",
      title: "Commanders",
      icon: CSIcons.damageIconFilled,
      unselectedIcon: CSIcons.damageIconOutlined,
      child: CommandersLeaderboards(),
      alreadyScrollableChild: true,
      extraOffset: CommanderStatWidget.height - AlertTitle.height,
    ),

    _LeadType.games: RadioHeaderedItem(
      longTitle: "Past games",
      title: "Games",
      icon: Icons.history,
      child: PastGamesList(),
      alreadyScrollableChild: true,
      extraOffset: PastGameTile.height - AlertTitle.height,
    ),

    _LeadType.players: RadioHeaderedItem(
      longTitle: "Players' stats",
      title: "Players",
      icon: Icons.person,
      unselectedIcon: Icons.person_outline,
      child: PlayerStatsList(),
      alreadyScrollableChild: true,
      extraOffset: PlayerStatTile.height - AlertTitle.height,
    ),

    _LeadType.settings: RadioHeaderedItem(
      longTitle: "Leaderboards info",
      title: "Info",
      icon: Icons.info,
      unselectedIcon: Icons.info_outline,
      child: LeaderboardsSettings(),
    ),
  };

}