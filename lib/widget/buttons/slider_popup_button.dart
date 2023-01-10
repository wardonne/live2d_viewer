import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';

class SliderPopupButton extends StatelessWidget {
  final Widget child;
  final double value;
  final double max;
  final double min;
  final int? divisions;
  final String? label;
  final void Function(double)? onChange;
  final void Function(double)? onChangeStart;
  final void Function(double)? onChangeEnd;
  final SliderThemeData? themeData;
  final Offset? offset;

  const SliderPopupButton({
    super.key,
    required this.value,
    required this.max,
    required this.min,
    this.divisions,
    this.label,
    this.onChange,
    this.onChangeEnd,
    this.onChangeStart,
    this.themeData,
    this.offset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final sliderValue = ValueNotifier(value);
    return CustomPopupMenu(
      showArrow: false,
      barrierColor: Colors.transparent,
      menuBuilder: () {
        return Container(
          width: 150,
          height: 25,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            color: Color(0xFF4C4C4C),
          ),
          child: ValueListenableBuilder(
            valueListenable: sliderValue,
            builder: (context, value, child) {
              Widget slider = Slider(
                value: value,
                max: max,
                min: min,
                onChanged: (value) {
                  sliderValue.value = value;
                  if (onChange != null) onChange!(value);
                },
                onChangeEnd: onChangeEnd,
                onChangeStart: onChangeStart,
              );
              if (themeData != null) {
                slider = SliderTheme(data: themeData!, child: slider);
              }
              return slider;
            },
          ),
        );
      },
      pressType: PressType.singleClick,
      child: child,
    );
  }
}
