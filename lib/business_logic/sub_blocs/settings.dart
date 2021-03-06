import 'package:counter_spell_new/core.dart';

import 'package:screen/screen.dart';
import 'package:vibrate/vibrate.dart';


class CSSettings {

  void dispose(){
    this.wantVibrate.dispose();

    this.startingLife.dispose();
    this.minValue.dispose();
    this.maxValue.dispose();

    this.confirmDelay.dispose();

    this.scrollSensitivity.dispose();

    this.scroll1Static.dispose();
    this.scroll1StaticValue.dispose();
    this.scrollPreBoost.dispose();
    this.scrollPreBoostValue.dispose();
    this.scrollDynamicSpeed.dispose();
    this.scrollDynamicSpeedValue.dispose();

    this.alwaysOnDisplay.dispose();

    this.imageAlignments.dispose();
    this.imageGradientStart.dispose();
    this.imageGradientEnd.dispose();
    this.simpleImageOpacity.dispose();

    this.timeMode.dispose();

    this.lastPageBeforeArena.dispose();
    this.tutored.dispose();

    this.arenaSquadLayout.dispose();

    this.arenaScreenVerticalScroll.dispose();

    this.arenaHideNameWhenImages.dispose();
  }


  //===================================
  // Values
  final CSBloc parent;

  final PersistentVar<bool> wantVibrate;
  bool canVibrate;
  final PersistentVar<int> startingLife;
  final PersistentVar<int> minValue;
  final PersistentVar<int> maxValue;

  final PersistentVar<Duration> confirmDelay;

  final PersistentVar<double> scrollSensitivity;

  final PersistentVar<bool> scrollPreBoost;
  final PersistentVar<double> scrollPreBoostValue;

  final PersistentVar<bool> scroll1Static;
  final PersistentVar<double> scroll1StaticValue;

  final PersistentVar<bool> scrollDynamicSpeed;
  final PersistentVar<double> scrollDynamicSpeedValue;

  final PersistentVar<bool> alwaysOnDisplay;

  final PersistentVar<Map<String,double>> imageAlignments;
  final PersistentVar<double> imageGradientStart;
  final PersistentVar<double> imageGradientEnd;
  final PersistentVar<double> simpleImageOpacity;

  final PersistentVar<TimeMode> timeMode;

  final BlocVar<CSPage> lastPageBeforeArena;
  final PersistentVar<bool> tutored;

  final PersistentVar<bool> arenaSquadLayout;

  final PersistentVar<bool> arenaScreenVerticalScroll;

  final PersistentVar<bool> arenaHideNameWhenImages;

  final PersistentVar<bool> arenaFullScreen;

  //====================================
  // Default values
  static const double sensVal = 7.2;
  static const double sensSpeedVal = 0.4;
  static const double sensPreBoostVal= 2.0;
  static const double sens1StaticVal= 0.8;
  static const Duration confirmDelayVal = const Duration(milliseconds: 950);
  static const double defaultImageGradientEnd = 0.3;
  static const double defaultImageGradientStart = 0.65;
  static const double defaultSimpleImageOpacity = 0.65;


  //===================================
  // Constructor
  CSSettings(this.parent): 
    scrollSensitivity = PersistentVar<double>(
      key: "bloc_settings_blocvar_scrollsens",
      initVal: sensVal,
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    scrollDynamicSpeed = PersistentVar<bool>(
      key: "bloc_settings_blocvar_scrollDynamicSpeed",
      initVal: true,
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    scrollDynamicSpeedValue = PersistentVar<double>(
      key: "bloc_settings_blocvar_scrollDynamicSpeedValue",
      initVal: sensSpeedVal, //0.1 to 0.9
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    scrollPreBoost = PersistentVar<bool>(
      key: "bloc_settings_blocvar_scrollPreBoost",
      initVal: true,
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    scrollPreBoostValue = PersistentVar<double>(
      key: "bloc_settings_blocvar_scrollPreBoostValue",
      initVal: sensPreBoostVal, //1.1 to 3.5
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    scroll1Static = PersistentVar<bool>(
      key: "bloc_settings_blocvar_scroll1Static",
      initVal: true,
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    scroll1StaticValue = PersistentVar<double>(
      key: "bloc_settings_blocvar_scroll1StaticValue",
      initVal: sens1StaticVal, // 0.1 to 0.8
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    wantVibrate = PersistentVar<bool>(
      key: "bloc_settings_blocvar_wantvibrate",
      initVal: true,
      toJson: (b) => b,
      fromJson: (j) => j,
    ),
    startingLife = PersistentVar<int>(
      key: "bloc_settings_blocvar_startinglife",
      initVal: 40,
      toJson: (b) => b,
      fromJson: (j) => j,
    ),
    minValue = PersistentVar<int>(
      key: "bloc_settings_blocvar_minvalue",
      initVal: -999,
      toJson: (b) => b,
      fromJson: (j) => j,
    ),
    maxValue = PersistentVar<int>(
      key: "bloc_settings_blocvar_maxvalue",
      initVal: 9999,
      toJson: (b) => b,
      fromJson: (j) => j,
    ),
    confirmDelay = PersistentVar<Duration>(
      key: "bloc_settings_blocvar_confirmdelay",
      initVal: confirmDelayVal,
      toJson: (dur) => dur.inMilliseconds,
      fromJson: (json) => Duration(milliseconds: json),
    ),
    alwaysOnDisplay = PersistentVar<bool>(
      key: "bloc_settings_blocvar_alwaysOnDisplay",
      initVal: true,
      toJson: (b) => b,
      fromJson: (j) => j,
      onChanged: (bool b) => Screen.keepOn(b),
      readCallback: (bool b) => Screen.keepOn(b), 
    ),
    imageAlignments = PersistentVar<Map<String,double>>(
      key: "bloc_settings_blocvar_imageAlignments",
      initVal: <String,double>{},
      toJson: (map) => map,
      fromJson: (json) => <String,double>{
        for(final entry in (json as Map).entries)
          entry.key: entry.value,          
      },
    ),
    imageGradientStart = PersistentVar<double>(
      key: "bloc_settings_blocvar_imageGradientStart",
      initVal: defaultImageGradientStart,
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    imageGradientEnd = PersistentVar<double>(
      key: "bloc_settings_blocvar_imageGradientEnd",
      initVal: defaultImageGradientEnd,
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    simpleImageOpacity = PersistentVar<double>(
      key: "bloc_settings_blocvar_simpleImageOpacity",
      initVal: defaultSimpleImageOpacity,
      toJson: (d) => d,
      fromJson: (j) => j,
    ),
    timeMode = PersistentVar<TimeMode>(
      key: "bloc_settings_blocvar_timeMode",
      initVal: TimeMode.clock,
      toJson: (mode) => TimeModes.nameOf(mode),
      fromJson: (name) => TimeModes.fromName(name),
    ),
    tutored= PersistentVar<bool>(
      key: "bloc_settings_blocvar_tutorial_shown",
      initVal: false,
      toJson: (b) => b,
      fromJson: (j) => j,
      readCallback: (alreadyShown){
        if(!alreadyShown){
          Future.delayed(const Duration(seconds: 1)).then((_){
            parent.stage.showAlert(const AdvancedTutorial(), size: AdvancedTutorial.height);
            parent.settings.tutored.setDistinct(true);
          });
        }
      } 
    ),
    lastPageBeforeArena = PersistentVar<CSPage>(
      key: "bloc_settings_blocvar_lastPageBeforeSimpleScreen",
      initVal: CSPage.life,
      toJson: (page) => CSPages.nameOf(page),
      fromJson: (name) => CSPages.fromName(name),
    ),
    arenaSquadLayout= PersistentVar<bool>(
      key: "bloc_settings_blocvar_simpleSquadLayout",
      initVal: true,
      // toJson: (b) => b,
      // fromJson: (j) => j,
    ),
    arenaScreenVerticalScroll = PersistentVar<bool>(
      key: "bloc_settings_blocvar_simpleScreenVerticalScroll",
      initVal: false,
    ),
    arenaHideNameWhenImages = PersistentVar<bool>(
      key: "bloc_settings_blocvar_arenaHideNameWhenImages",
      initVal: false,
    ),
    arenaFullScreen = PersistentVar<bool>(
      key: "bloc_settings_blocvar_arenaFullScreen",
      initVal: true,
    )
  {
    Vibrate.canVibrate.then(
      (canIt) => canVibrate = canIt
    );
  }


  //===================================
  // Action


}