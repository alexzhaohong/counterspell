import 'package:counter_spell_new/core.dart';
import 'package:counter_spell_new/widgets/arena/arena_route.dart';


class PanelGameExtras extends StatelessWidget {

  const PanelGameExtras();

  @override
  Widget build(BuildContext context) {
    final bloc = CSBloc.of(context);
    final stage = Stage.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(child: ExtraButton(
            icon: McIcons.dice_multiple,
            text: "Random",
            onTap: () => stage.showAlert(DiceThrower(), size: DiceThrower.height),
            forceExternalSize: true,
          ),),
          Expanded(child: bloc.payments.unlocked.build((_, unlocked) => ExtraButton(
            icon: McIcons.license,
            text: "Leaderboards",
            onTap: () {
              if(unlocked){
                stage.showAlert(const Leaderboards(), size: Leaderboards.height);
              } else {
                stage.showAlert(const Support(), size: Support.height);
              }
            },
            forceExternalSize: true,
          ),),),
          Expanded(child: ExtraButton(
            icon: CSIcons.simpleViewIcon,
            iconSize: CSIcons.ideal_counterspell_size,
            iconPadding: CSIcons.ideal_counterspell_padding,
            text: "Arena Mode",
            onTap: () => showArena(context: context, bloc: bloc),
            forceExternalSize: true,
          ),),
        ].separateWith(CSWidgets.extraButtonsDivider),
      ),
    );


  }
}


