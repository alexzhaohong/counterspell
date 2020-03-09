import 'package:counter_spell_new/core.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'components/all.dart';

class CacheAlert extends StatelessWidget {

  const CacheAlert();
  static const double height = 450;

  @override
  Widget build(BuildContext context) {
    final bloc = CSBloc.of(context);
    final stage = Stage.of(context);

    return HeaderedAlert("Manage Cache",
      child: Column(children: <Widget>[
        Section(<Widget>[
          const SectionTitle("Commander Images"),
          ListTile(
            title: const Text("Clear cache"),
            subtitle: const Text("This will delete all the cached image files you used for the players' backgrounds"),
            leading: CSWidgets.deleteIcon,
            onTap: (){
              final cacheManager = DefaultCacheManager();
              cacheManager.emptyCache();
            },
          ),
        ]),
        Section(<Widget>[
          const SectionTitle("Commander cards suggestions"),
          const ListTile(
            title: Text("Every time you select a card as your commander, you will find it promped as an auto-suggestion in your next searches for that player. All those cards are stored in your memory as text (independent from the cached images, so they don't use up much space), but you can delete them if you want."),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 10.0),
            child: Row(children: <Widget>[
              Expanded(child: ExtraButton(
                text: "Clear all",
                icon: Icons.delete_forever,
                onTap: (){
                  bloc.game.gameGroup.savedCards.removeAll();
                },
              )),
              Expanded(child: ExtraButton(
                text: "View",
                icon: McIcons.cards_outline,
                onTap: () => stage.showAlert(const SavedCardsCache(), size: SavedCardsCache.height),
              )),
            ].separateWith(CSWidgets.extraButtonsDivider)),
          ),
        ]),
      ]),
    );
  }
}

class SavedCardsCache extends StatelessWidget {
  const SavedCardsCache();
  static const double height = 450.0; 

  @override
  Widget build(BuildContext context) {
    return const RadioHeaderedAlert<bool>(
      initialValue: true, // player by player
      orderedValues: [true, false],
      items: const <bool, RadioHeaderedItem>{
        true: RadioHeaderedItem(
          longTitle: "Players with saved cards",
          title: "Players",
          icon: McIcons.account_multiple_outline,
          child: CachePlayers(),
          alreadyScrollableChild: true,
        ),
        false: RadioHeaderedItem(
          longTitle: "All saved cards", 
          title: "Cards",
          icon: McIcons.cards_outline,
          child: CacheCards(), 
          alreadyScrollableChild: true,
        ),
      },
    );
  }
}
