import 'package:counter_spell_new/core.dart';
import 'theme_components/all.dart';


class PanelTheme extends StatelessWidget {
  const PanelTheme();

  static const Widget _overallTheme = const OverallTheme();
  static const Widget _themeColors = const ThemeColors();
  static const Widget _themeRestarter = const ThemeRestarter();

  @override
  Widget build(BuildContext context) {
    final stage = Stage.of(context);
    return SingleChildScrollView(
      physics: stage.panelScrollPhysics(),
      child: CSBloc.of(context).payments.unlocked.build((_,unlocked) => Column(
        children: <Widget>[
          _overallTheme,
          if(!unlocked) ListTile(
            title: const Text("Unlock theme engine"),
            subtitle: const Text("Support the developer"),
            leading: const Icon(McIcons.palette_outline),
            onTap: () => stage.showAlert(const Support(), size: Support.height),
          ),
          _themeColors,
          if(unlocked) _themeRestarter,
        ],
      ),),
    );
  }
}


