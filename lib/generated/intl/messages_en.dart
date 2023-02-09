// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(section) => "${Intl.select(section, {
            'destinyChild': 'Destiny Child',
            'nikke': 'GODDESS OF VICTORY: NIKKE',
            'girlFrontline': 'Girls\' Frontline',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "child": MessageLookupByLibrary.simpleMessage("Child"),
        "confirm": MessageLookupByLibrary.simpleMessage("confirm"),
        "destinyChild": MessageLookupByLibrary.simpleMessage("Destiny Child"),
        "dialogTitleError": MessageLookupByLibrary.simpleMessage("Error"),
        "forceReload": MessageLookupByLibrary.simpleMessage("Force reload"),
        "gameTitles": m0,
        "girlFrontline":
            MessageLookupByLibrary.simpleMessage("Girls\' Frontline"),
        "indexTitle": MessageLookupByLibrary.simpleMessage("Games"),
        "nikke":
            MessageLookupByLibrary.simpleMessage("GODDESS OF VICTORY: NIKKE"),
        "reload": MessageLookupByLibrary.simpleMessage("reload"),
        "requestError": MessageLookupByLibrary.simpleMessage("Request Error"),
        "soulCarta": MessageLookupByLibrary.simpleMessage("Soul Carta"),
        "title": MessageLookupByLibrary.simpleMessage("Live2D Viewer"),
        "tooltipDevtool": MessageLookupByLibrary.simpleMessage("Devtool"),
        "tooltipLoopPlay":
            MessageLookupByLibrary.simpleMessage("Loop Playback"),
        "tooltipPlayAndRecord":
            MessageLookupByLibrary.simpleMessage("Play & Record"),
        "tooltipShowActions": MessageLookupByLibrary.simpleMessage("Actions"),
        "tooltipShowAnimation":
            MessageLookupByLibrary.simpleMessage("Animations"),
        "tooltipShowExpressions":
            MessageLookupByLibrary.simpleMessage("Expressions"),
        "tooltipShowMotions": MessageLookupByLibrary.simpleMessage("Motions"),
        "tooltipShowSkins": MessageLookupByLibrary.simpleMessage("Clothes"),
        "tooltipSnapshot": MessageLookupByLibrary.simpleMessage("Snapshot"),
        "tooltipSnapshotWithExpession":
            MessageLookupByLibrary.simpleMessage("Set expression & snapshot"),
        "tooltipSpeedPlay": MessageLookupByLibrary.simpleMessage("Speed"),
        "tooltipSpringSkin":
            MessageLookupByLibrary.simpleMessage("Spring skin"),
        "tooltipZoom": MessageLookupByLibrary.simpleMessage("Zoom")
      };
}
