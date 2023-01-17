import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/locale.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/providers/locale_provider.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';
import 'package:provider/provider.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      showArrow: false,
      position: PreferredPosition.bottom,
      barrierColor: Colors.transparent,
      menuBuilder: () => Container(
        width: 100,
        decoration: const BoxDecoration(
          color: Styles.popupBackgrounColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: S.delegate.supportedLocales
              .map((locale) => ContainerButton(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.all(5.0),
                    backgroundColor: Colors.transparent,
                    hoverBackgroundColor: Styles.hoverBackgroundColor,
                    child: Center(
                      child: Text(
                        LocaleConstants.locales[locale.toLanguageTag()] ??
                            locale.toLanguageTag(),
                      ),
                    ),
                    onClick: () {
                      Provider.of<LocaleProvider>(context, listen: false)
                          .changeLocale(locale);
                    },
                  ))
              .toList(),
        ),
      ),
      pressType: PressType.singleClick,
      child: const Icon(Icons.language),
    );
  }
}
