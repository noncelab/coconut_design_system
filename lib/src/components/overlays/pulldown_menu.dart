import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class CoconutPulldownMenuEntry {}

class CoconutPulldownMenuItem extends CoconutPulldownMenuEntry {
  final String title;
  final bool isDisabled;

  /// Whether to show a switch (toggle) widget on the right side of this item.
  final bool hasSwitch;

  /// The current value of the switch. Only used when [hasSwitch] is `true`.
  final bool switchValue;

  /// Callback function when the switch is toggled.
  final Function(bool value)? onSwitchChanged;

  CoconutPulldownMenuItem({
    required this.title,
    this.isDisabled = false,
    this.hasSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
  });
}

class CoconutPulldownMenuGroup extends CoconutPulldownMenuEntry {
  final String groupTitle;
  final List<CoconutPulldownMenuItem> items;

  CoconutPulldownMenuGroup({
    required this.groupTitle,
    required this.items,
  });
}

/// ## CoconutPulldownMenu
///
/// A flexible dropdown menu widget that supports both flat and grouped item structures.
///
/// This widget replaces the previous `buttons`-based version with a more extensible model using
/// `CoconutPulldownMenuItem` and `CoconutPulldownMenuGroup`. Group titles and dividers are supported.
///
/// ### Example:
/// ```dart
/// CoconutPulldownMenu(
///   entries: [
///     CoconutPulldownMenuItem(title: 'Item 1'),
///     CoconutPulldownMenuItem(title: 'Item 2', hasSwitch: true, switchValue: true),
///     CoconutPulldownMenuGroup(
///       groupTitle: 'Group Title',
///       items: [
///         CoconutPulldownMenuItem(title: 'Group Item 1'),
///         CoconutPulldownMenuItem(title: 'Group Item 2'),
///       ],
///     ),
///   ],
///   selectedIndex: 2,
///   onSelected: (index, title) {
///     print('Selected $index: $title');
///   },
///   onSwitchChanged: (index, value) {
///     print('Switch $index: $value');
///   },
/// )
/// ```
///
/// ### Deprecation Notice:
/// - `buttons` and `onTap` are deprecated and will be removed in version 1.0.0.
/// - Use `entries` and `onSelected` instead for improved flexibility.
class CoconutPulldownMenu extends StatelessWidget {
  /// The list of button labels displayed in the dropdown.
  @Deprecated('Use `entries` instead. This will be removed in version 1.0.0.')
  final List<String>? buttons;

  /// The list of items displayed in the dropdown.
  final List<CoconutPulldownMenuEntry> entries;

  /// The index list of thick divider between buttons.
  final List<int>? thickDividerIndexList;

  /// The index of the currently selected item (optional).
  final int? selectedIndex;

  /// Callback function when an item is tapped.
  @Deprecated('Use `onSelected` instead. This will be removed in version 1.0.0.')
  final Function(int)? onTap;

  /// Callback function when an item is tapped.
  final Function(int, String) onSelected;

  /// The margin around the dropdown menu (default: `EdgeInsets.zero`).
  final EdgeInsets margin;

  /// The padding inside each button (default: `EdgeInsets.symmetric(horizontal: 20)`).
  final EdgeInsets? buttonPadding;

  /// The height of each dropdown button (default: `44.0`).
  final double buttonHeight;

  /// The size of the checkmark icon for selected items (default: `24`).
  final double iconSize;

  /// The blur radius of the dropdown menu's shadow effect. (default: `12`)
  final double blurRadius;

  /// The border radius of the dropdown menu. (default: `8`)
  final double borderRadius;

  /// The spread radius of the dropdown menu's shadow effect. (default: `4`)
  final double spreadRadius;

  /// The height of divider between buttons. (default: `1`)
  final double? dividerHeight;

  /// The height of thick divider between buttons. (default: `5`)
  final double? thickDividerHeight;

  /// The text color of menu items.
  final Color? textColor;

  /// The background color of the menu.
  final Color? backgroundColor;

  /// The color of normal dividers between items.
  final Color? dividerColor;

  /// The color of the checkmark icon for selected items.
  final Color? iconColor;

  /// The color of the splash effect when an item is tapped.
  final Color? splashColor;

  /// The color of the shadow effect under the dropdown.
  final Color? shadowColor;

  final TextStyle? groupTitleStyle;
  final Color? groupTitleColor;
  final EdgeInsets? groupTitlePadding;
  final bool? isSelectedItemBold;

  /// Callback when a switch in a menu item is toggled.
  /// Provides the item index and the new switch value.
  final Function(int index, bool value)? onSwitchChanged;

  /// The active track color for the switch.
  final Color? switchActiveTrackColor;

  /// The inactive track color for the switch.
  final Color? switchInactiveTrackColor;

  /// The thumb color for the switch.
  final Color? switchThumbColor;

  /// Creates an instance of `CoconutPulldownMenu`.
  const CoconutPulldownMenu({
    super.key,
    this.buttons,
    required this.entries,
    this.onTap,
    required this.onSelected,
    this.selectedIndex,
    this.margin = EdgeInsets.zero,
    this.buttonPadding,
    this.buttonHeight = 44,
    this.blurRadius = 16,
    this.spreadRadius = 1,
    this.borderRadius = 16,
    this.iconSize = 24,
    this.dividerHeight = 1,
    this.thickDividerHeight = 5,
    this.thickDividerIndexList,
    this.textColor,
    this.backgroundColor,
    this.dividerColor,
    this.iconColor,
    this.splashColor,
    this.shadowColor,
    this.groupTitleColor,
    this.groupTitlePadding,
    this.groupTitleStyle,
    this.isSelectedItemBold = false,
    this.onSwitchChanged,
    this.switchActiveTrackColor,
    this.switchInactiveTrackColor,
    this.switchThumbColor,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = CoconutTheme.brightness();
    final List<_IndexedEntry> flattenedEntries = [];
    int runningIndex = 0;
    int groupCount = 0;
    for (final entry in entries) {
      if (entry is CoconutPulldownMenuGroup) {
        groupCount++;
        flattenedEntries.add(_IndexedEntry(entry.groupTitle, -1)); // indicator for group title
        for (final item in entry.items) {
          flattenedEntries.add(_IndexedEntry(item.title, runningIndex++,
              isDisabled: item.isDisabled, hasSwitch: item.hasSwitch, switchValue: item.switchValue));
        }
      } else if (entry is CoconutPulldownMenuItem) {
        flattenedEntries.add(_IndexedEntry(entry.title, runningIndex++,
            isDisabled: entry.isDisabled, hasSwitch: entry.hasSwitch, switchValue: entry.switchValue));
      }
    }

    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        margin: margin,
        constraints: const BoxConstraints(minWidth: 152), // Minimum width for dropdown
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? CoconutColors.pulldownMenuShadowColor(brightness),
              spreadRadius: spreadRadius,
              blurRadius: blurRadius,
              offset: Offset.zero,
            ),
          ],
        ),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(flattenedEntries.length, (index) {
              final element = flattenedEntries[index];
              final divider = _buildDivider(
                index: element.index,
                totalLength: flattenedEntries.length,
                groupCount: groupCount,
                brightness: brightness,
                thickDividerIndices: thickDividerIndexList,
                dividerHeight: dividerHeight ?? 1,
                thickDividerHeight: thickDividerHeight ?? 5,
                overrideColor: dividerColor,
              );

              if (element.index == -1) {
                return Column(
                  children: [
                    Container(
                      padding: groupTitlePadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: index == 0
                            ? BorderRadius.only(
                                topLeft: Radius.circular(borderRadius),
                                topRight: Radius.circular(borderRadius),
                              )
                            : null,
                        color: backgroundColor ?? CoconutColors.onGray100(brightness),
                      ),
                      child: Text(
                        element.title,
                        style: groupTitleStyle ??
                            CoconutTypography.body3_12.copyWith(
                              color: groupTitleColor ?? CoconutColors.onGray500(brightness),
                            ),
                      ),
                    ),
                    if (divider != null) ...{
                      divider,
                    }
                  ],
                );
              }
              return _button(element.title, element.index, element.isDisabled, element.hasSwitch, element.switchValue,
                  flattenedEntries.length, groupCount, borderRadius, brightness);
            }),
          ),
        ),
      ),
    );
  }

  Widget? _buildDivider({
    required int index,
    required int totalLength,
    required int groupCount,
    required Brightness brightness,
    List<int>? thickDividerIndices,
    double dividerHeight = 1,
    double thickDividerHeight = 5,
    Color? overrideColor,
  }) {
    final isThick = thickDividerIndices?.contains(index) ?? false;
    final isLast = index >= totalLength - 1 - groupCount;
    final shouldShow = isThick || !isLast;

    if (!shouldShow) return null;

    return Container(
      height: isThick ? thickDividerHeight : dividerHeight,
      color: overrideColor ?? CoconutColors.pulldownMenuDividerColor(brightness),
    );
  }

  /// Builds a single dropdown button item.
  Widget _button(
    String title,
    int index,
    bool isDisabled,
    bool hasSwitch,
    bool switchValue,
    int flattenedEntryListLenght,
    int groupCount,
    double borderRadius,
    Brightness brightness,
  ) {
    final isBottomRounded = index ==
        entries
                .map((e) => e is CoconutPulldownMenuItem
                    ? 1
                    : e is CoconutPulldownMenuGroup
                        ? e.items.length
                        : 0)
                .fold(0, (a, b) => a + b) -
            1;

    final isTopRounded = index == 0 && entries[index] is! CoconutPulldownMenuGroup;

    final divider = _buildDivider(
        index: index,
        totalLength: flattenedEntryListLenght,
        groupCount: groupCount,
        brightness: brightness,
        thickDividerIndices: thickDividerIndexList,
        dividerHeight: dividerHeight ?? 1,
        thickDividerHeight: thickDividerHeight ?? 5,
        overrideColor: dividerColor);

    return Column(
      children: [
        Material(
          color: backgroundColor ?? CoconutColors.onGray100(brightness),
          shape: RoundedRectangleBorder(
            borderRadius: _getBorderRadius(
              borderRadius,
              brightness,
              isBottomRounded: isBottomRounded,
              isTopRounded: isTopRounded,
            ),
          ),
          child: InkWell(
            onTap: isDisabled
                ? null
                : () {
                    if (hasSwitch) {
                      onSwitchChanged?.call(index, !switchValue);
                      final item = _findItemByIndex(index);
                      item?.onSwitchChanged?.call(!switchValue);
                    } else {
                      onSelected.call(index, title);
                    }
                  },
            borderRadius: _getBorderRadius(
              borderRadius,
              brightness,
              isBottomRounded: isBottomRounded,
              isTopRounded: isTopRounded,
            ),
            splashColor: splashColor ?? CoconutColors.onGray200(brightness),
            highlightColor: Colors.transparent,
            child: Container(
              height: buttonHeight,
              padding: buttonPadding ?? const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: _getBorderRadius(
                  borderRadius,
                  brightness,
                  isBottomRounded: isBottomRounded,
                  isTopRounded: isTopRounded,
                ),
              ),
              child: Row(
                children: [
                  /// Button Label
                  Text(
                    title,
                    style: CoconutTypography.body2_14.copyWith(
                      color: isDisabled
                          ? CoconutColors.onGray350(brightness)
                          : textColor ?? CoconutColors.onBlack(brightness),
                      fontWeight: isSelectedItemBold != null && isSelectedItemBold!
                          ? selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal
                          : null,
                    ),
                  ),

                  const SizedBox(width: 16),
                  const Spacer(),

                  /// Switch or Checkmark Icon
                  if (hasSwitch)
                    IgnorePointer(
                      child: CoconutSwitch(
                        isOn: switchValue,
                        onChanged: (_) {},
                        activeColor: switchActiveTrackColor,
                        thumbColor: switchThumbColor,
                        trackColor: switchInactiveTrackColor,
                        scale: 0.6,
                      ),
                    )
                  else
                    Visibility(
                      visible: selectedIndex == index,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      maintainInteractivity: true,
                      child: SvgPicture.asset(
                        'packages/coconut_design_system/assets/svg/pulldown_check.svg',
                        width: iconSize,
                        height: iconSize,
                        colorFilter: ColorFilter.mode(
                          iconColor ?? CoconutColors.onBlack(brightness),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (divider != null) ...{
          divider,
        }
      ],
    );
  }

  /// Finds the [CoconutPulldownMenuItem] corresponding to the given flattened [index].
  CoconutPulldownMenuItem? _findItemByIndex(int index) {
    int runningIndex = 0;
    for (final entry in entries) {
      if (entry is CoconutPulldownMenuGroup) {
        for (final item in entry.items) {
          if (runningIndex == index) return item;
          runningIndex++;
        }
      } else if (entry is CoconutPulldownMenuItem) {
        if (runningIndex == index) return entry;
        runningIndex++;
      }
    }
    return null;
  }

  /// Determines the border radius for the first and last items.
  BorderRadius _getBorderRadius(double borderRadius, Brightness brightness,
      {bool isTopRounded = false, bool isBottomRounded = false}) {
    return BorderRadius.only(
      topLeft: isTopRounded ? Radius.circular(borderRadius) : const Radius.circular(0),
      topRight: isTopRounded ? Radius.circular(borderRadius) : const Radius.circular(0),
      bottomLeft: isBottomRounded ? Radius.circular(borderRadius) : const Radius.circular(0),
      bottomRight: isBottomRounded ? Radius.circular(borderRadius) : const Radius.circular(0),
    );
  }
}

class _IndexedEntry {
  final String title;
  final int index;
  final bool isDisabled;
  final bool hasSwitch;
  final bool switchValue;
  _IndexedEntry(this.title, this.index, {this.isDisabled = false, this.hasSwitch = false, this.switchValue = false});
}
