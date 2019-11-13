import 'package:counter_spell_new/core.dart';
import 'theme_components/all.dart';


class PanelTheme extends StatelessWidget {
  const PanelTheme();

  @override
  Widget build(BuildContext context) {
    final stage = Stage.of(context);
    return SingleChildScrollView(
      physics: stage.panelScrollPhysics(),
      child: Column(
        children: <Widget>[
          const OverallTheme(),
          const ThemeColors(),
          ListTile(
            title: const Text("Reset to default"),
            leading: const Icon(McIcons.restore),
            onTap: (){
              if(stage.themeController.light.value){
                stage.themeController.lightPrimary.set(CSStage.primary);
                stage.themeController.lightPrimaryPerPage.set(defaultPageColorsLight);
              } else {
                stage.themeController.darkPrimariesPerPage.value[stage.themeController.darkStyle.value]
                  = defaultPageColorsDark;
                stage.themeController.darkPrimariesPerPage.refresh();
                stage.themeController.darkPrimaries.value[stage.themeController.darkStyle.value]
                  = CSStage.primary;
                stage.themeController.darkPrimaries.refresh();
              }
            },
          ),
        ],
      ),
    );
  }
}
