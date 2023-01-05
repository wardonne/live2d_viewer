import 'package:flutter/material.dart';
import 'package:live2d_viewer/controllers/paginator_controller.dart';

class Paginator extends StatelessWidget {
  final PaginatorController _controller;
  final int startIndex;
  final int endIndex;

  const Paginator({
    super.key,
    required PaginatorController controller,
    required this.startIndex,
    required this.endIndex,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.caption!,
      child: IconTheme.merge(
        data: const IconThemeData(
          opacity: 0.54,
        ),
        child: SizedBox(
          height: 56,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              children: [
                Container(width: 32.0),
                Text(
                  localizations.pageRowsInfoTitle(
                    startIndex + 1,
                    endIndex + 1,
                    _controller.total,
                    false,
                  ),
                ),
                Container(width: 32.0),
                IconButton(
                  onPressed: startIndex <= 0 ? null : _controller.firstPage,
                  icon: const Icon(Icons.skip_previous),
                  padding: EdgeInsets.zero,
                  tooltip: localizations.firstPageTooltip,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  padding: EdgeInsets.zero,
                  tooltip: localizations.previousPageTooltip,
                  onPressed: startIndex <= 0 ? null : _controller.prePage,
                ),
                Container(width: 24.0),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  padding: EdgeInsets.zero,
                  tooltip: localizations.nextPageTooltip,
                  onPressed: !_controller.isNextPageAvailable()
                      ? null
                      : _controller.nextPage,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  padding: EdgeInsets.zero,
                  tooltip: localizations.lastPageTooltip,
                  onPressed: !_controller.isNextPageAvailable()
                      ? null
                      : _controller.lastPage,
                ),
                Container(width: 14.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
