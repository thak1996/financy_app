import 'package:financy_app/app/shared/extensions/page_controller.ext.dart';
import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatefulWidget {
  final PageController controller;
  final Color? selectedItemColor;
  final List<CustomBottomAppBarItem> children;
  const BottomAppBarWidget({
    super.key,
    this.selectedItemColor,
    required this.children,
    required this.controller,
  }) : assert(children.length == 5, 'children.length must be 5');

  @override
  State<BottomAppBarWidget> createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handlePageChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handlePageChange);
    super.dispose();
  }

  void _handlePageChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomAppBar(
      color: theme.bottomAppBarTheme.color,
      elevation: 4,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            widget.children.map((item) {
              bool currentItem;

              currentItem =
                  widget.children.indexOf(item) ==
                  widget.controller.selectedBottomAppBarItemIndex;
              return Builder(
                builder: (context) {
                  return Expanded(
                    key: item.key,
                    child:
                        item.isEmpty
                            ? SizedBox.shrink()
                            : IconButton(
                              onPressed: () {
                                item.onPressed?.call();
                                widget.controller.setBottomAppBarItemIndex =
                                    widget.children.indexOf(item);
                              },
                              icon: Icon(
                                currentItem
                                    ? item.primaryIcon
                                    : item.secondaryIcon,
                                color:
                                    currentItem
                                        ? (widget.selectedItemColor ??
                                            theme.colorScheme.primary)
                                        : theme.colorScheme.onSurfaceVariant,
                              ),
                              splashRadius: 24,
                              iconSize: 24,
                            ),
                  );
                },
              );
            }).toList(),
      ),
    );
  }
}

class CustomBottomAppBarItem {
  final Key? key;
  final String? label;
  final IconData? primaryIcon;
  final IconData? secondaryIcon;
  final VoidCallback? onPressed;
  final bool isEmpty;

  CustomBottomAppBarItem({
    this.key,
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  }) : isEmpty = false;

  CustomBottomAppBarItem.empty({
    this.key,
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  }) : isEmpty = true;
}
