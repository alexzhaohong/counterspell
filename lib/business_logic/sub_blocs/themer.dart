import 'package:counter_spell_new/core.dart';

class CSThemer {

  void dispose(){
    defenceColor.dispose();
    savedSchemes.dispose();
  }

  //================================
  // Values
  final CSBloc parent;
  final PersistentVar<Color> defenceColor;
  final PersistentVar<Map<String,CSColorScheme>> savedSchemes;


  //================================
  // Constructor
  CSThemer(this.parent): 
    defenceColor = PersistentVar<Color>(
      key: "bloc_themer_blocvar_defenceColor",
      initVal: CSColors.blue,
      toJson: (color) => color.value,
      fromJson: (json) => Color(json),
    ),
    savedSchemes = PersistentVar<Map<String,CSColorScheme>>(
      key: "bloc_themer_blocvar_savedSchemes",
      initVal: <String,CSColorScheme>{
        // for(final e in CSColorScheme.defaults.entries)
        //   e.key: e.value,
      },
      toJson: (map) => <String,dynamic>{for(final e in map.entries)
        e.key : e.value.toJson,
      },
      fromJson: (json) => <String,CSColorScheme>{for(final e in (json as Map).entries)
        e.key as String : CSColorScheme.fromJson(e.value),
      },
    );


  static Color getHistoryChipColor({
    @required DamageType type,
    @required bool attack,
    @required Color defenceColor,
    @required Map<CSPage,Color> pageColors,
  }){
    if(type == DamageType.commanderDamage){
      return attack ? pageColors[CSPage.commanderDamage] : defenceColor;
    } else {
      return pageColors[CSPages.fromDamage(type)];
    }
  }

  static IconData getHistoryChangeIcon({
    @required Color defenceColor,
    @required DamageType type,
    @required bool attack,
    @required Counter counter,
  }){
    if(type == DamageType.commanderDamage){
      return attack ? CSIcons.attackIconOne : CSIcons.defenceIconFilled;
    } else if (type == DamageType.counters){
      return counter.icon;
    } else {
      return CSIcons.typeIconsFilled[type];
    }
  }

}
