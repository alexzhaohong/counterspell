import 'package:counter_spell_new/core.dart';

const String _multiTitle = "No multi selection";
const String _multi1 = "You'll just have to scroll on one player at a time";

const String _partnerTitle = "Select the right partner";
const String _partner1 = "tap on the person icon to split the commander into two partners";
const String _partner2 = "tap again on the player to switch between partners A and B";

class CastInfo extends StatelessWidget {
  const CastInfo();
  static const height = 2 * (InfoTitle.height + 14.0) + 3 * PieceOfInfo.height + AlertDrag.height - 14.0;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        physics: Stage.of(context).panelScrollPhysics(),
        child: Container(
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const InfoSection(
                first: true,
                icon: const Icon(McIcons.gesture_swipe_horizontal),
                title: _multiTitle,
                info: [
                  _multi1,
                ],
              ),
              const InfoSection(
                last: true,
                icon: const Icon(McIcons.account_multiple_outline),
                title: _partnerTitle,
                info: [
                  _partner1,
                  _partner2,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

