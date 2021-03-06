import 'package:counter_spell_new/core.dart';

class ThemePResetter extends StatelessWidget {

  const ThemePResetter();

  @override
  Widget build(BuildContext context) {
    final bloc = CSBloc.of(context);
    final themer = bloc.themer;
    final StageData<CSPage,SettingsPage> stage = Stage.of(context);
    final themeController = stage.themeController;

    return BlocVar.build6(
      themer.savedSchemes,
      themeController.primaryColor,
      themeController.accentColor,
      themeController.primaryColorsMap,
      themeController.light,
      themeController.darkStyle,
      builder: (
        _, 
        Map<String,CSColorScheme> savedSchemes, 
        Color primary,
        Color accent, 
        Map<CSPage,Color> perPage,
        bool light,
        DarkStyle darkStyle,
      ){
        
        final derivedScheme = CSColorScheme("",
          primary: primary,
          accent: accent,
          perPage: perPage,
          light: light,
          darkStyle: darkStyle,
        );
        
        final bool saved = [
          ...savedSchemes.values, 
          ...CSColorScheme.defaults.values,
        ].any((scheme)=>scheme.equivalentTo(derivedScheme));

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(children: <Widget>[

            Expanded(child: ListTile(
              title: Text("Load"),
              leading: Icon(McIcons.file_outline),
              onTap: () => stage.showAlert(
                const PresetsAlert(),
                size: PresetsAlert.height,
              ),
            ),),

            Expanded(child: ListTile(
              title: Text(saved ? "Saved" : "Save"),
              leading: Icon(saved ? Icons.check : McIcons.content_save_outline),
              onTap: saved ? null : () => stage.showAlert(
                InsertAlert(
                  onConfirm: (name){
                    if(CSColorScheme.defaults.keys.contains(name)) return false;
                    if(savedSchemes.containsKey(name)){
                      stage.showAlert(
                        ConfirmAlert(
                          warningText: '"$name" is already used',
                          confirmText: "Overwrite $name",
                          confirmIcon: McIcons.content_save_edit,
                          action: (){
                            themer.savedSchemes.value[name] = derivedScheme.renamed(name);
                            themer.savedSchemes.refresh();
                          },
                        ),
                        size: ConfirmAlert.height,
                      );
                      return false;
                    }
                    themer.savedSchemes.value[name] = derivedScheme.renamed(name);
                    themer.savedSchemes.refresh();
                    return true;
                  },
                  checkErrors: (name){
                    if(name == null || name == "") return "Insert name";
                    if(CSColorScheme.defaults.keys.contains(name)) return "Avoid default names";
                    return null;
                  },
                  labelText: "Save color scheme with name",
                ), 
                size: InsertAlert.height,
              ),
            ),),
          ],),
        );

      }
    );
  }
}

