// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
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
  String get localeName => 'zh_CN';

  static String m0(section) => "${Intl.select(section, {
            'destinyChild': '天命之子',
            'nikke': 'NIKKE：胜利女神',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "confirm": MessageLookupByLibrary.simpleMessage("确认"),
        "destinyChild": MessageLookupByLibrary.simpleMessage("天命之子"),
        "dialogTitleError": MessageLookupByLibrary.simpleMessage("错误"),
        "gameTitles": m0,
        "indexTitle": MessageLookupByLibrary.simpleMessage("游戏库"),
        "nikke": MessageLookupByLibrary.simpleMessage("NIKKE：胜利女神"),
        "reload": MessageLookupByLibrary.simpleMessage("重新加载"),
        "requestError": MessageLookupByLibrary.simpleMessage("请求错误"),
        "soulCarta": MessageLookupByLibrary.simpleMessage("魂卡"),
        "title": MessageLookupByLibrary.simpleMessage("Live2D Viewer"),
        "tooltipDevtool": MessageLookupByLibrary.simpleMessage("开发者面板"),
        "tooltipLoopPlay": MessageLookupByLibrary.simpleMessage("循环播放"),
        "tooltipPlayAndRecord": MessageLookupByLibrary.simpleMessage("播放并录制"),
        "tooltipShowActions": MessageLookupByLibrary.simpleMessage("行动列表"),
        "tooltipShowAnimation": MessageLookupByLibrary.simpleMessage("动画列表"),
        "tooltipShowSkins": MessageLookupByLibrary.simpleMessage("皮肤列表"),
        "tooltipSpeedPlay": MessageLookupByLibrary.simpleMessage("倍速播放"),
        "tooltipZoom": MessageLookupByLibrary.simpleMessage("缩放")
      };
}
