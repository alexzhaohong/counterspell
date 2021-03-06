import 'model_advanced.dart';
import 'package:counter_spell_new/core.dart';


class PlayerStatScreen extends StatelessWidget {

  final PlayerStatsAdvanced stat;

  const PlayerStatScreen(this.stat);

  static const height = 500.0; 

  @override
  Widget build(BuildContext context) {
    return HeaderedAlertCustom(
      ListTile(
        title: Text("${stat.name}'s stats"),
        trailing: Text("(${stat.games} games)"),
        leading: const Icon(Icons.person_outline),
      ),
      titleSize: 56.0 + AlertDrag.height,
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Section([
          ListTile(
            title: const Text("Win rate"),
            trailing: Text("${(stat.winRate * 100).toStringAsFixed(0)}%"),
            leading: const Icon(McIcons.trophy),
          ),
          SubSection([
            SectionTitle("Per commander"),
            for(final entry in stat.perCommanderWinRates.entries)
              CardTile(stat.commandersUsed[entry.key], 
                callback: (_){},
                autoClose: false,
                trailing: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text("${(entry.value * 100).toStringAsFixed(0)}%"),
                  Text("(${stat.perCommanderWins[entry.key]} over ${stat.perCommanderGames[entry.key]})"),
                ],),
              ),
          ]),
          CSWidgets.height10
        ]),
      ],),
    );
  }
}