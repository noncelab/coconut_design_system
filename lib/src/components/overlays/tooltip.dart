import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:coconut_design_system/src/components/overlays/bubble_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A customizable tooltip widget with different styles and placements.
///
/// This tooltip supports different types such as:
/// - **Placement Tooltip:** Appears at a specific location with a bubble clipper.
/// - **Fixed Tooltip:** A static tooltip with optional icons.
/// - **Fixed Closable Tooltip:** A fixed tooltip with a close button.
///
/// Example Usage:
/// ```dart
/// CoconutToolTip(
///   tooltipType: CoconutTooltipType.fixed,
///   richText: RichText(
///     text: TextSpan(text: "This is a tooltip."),
///   ),
/// )
/// ```
class CoconutToolTip extends StatefulWidget {
  /// Type of the tooltip (placement, fixed, or closable).
  final CoconutTooltipType tooltipType;

  /// Tooltip state that determines the icon and color scheme.
  final CoconutTooltipState tooltipState;

  /// - Deprecated: This parameter will be removed in version `0.9.0`.
  /// - Now automatically inferred from `CoconutTheme.brightness()`.
  @Deprecated(
      'This parameter will be removed in version 0.8. It is now inferred from CoconutTheme.brightness.')
  final Brightness? brightness;

  /// The text content inside the tooltip.
  final RichText richText;

  /// Whether to show an icon in the tooltip (default: `true`).
  final bool showIcon;

  /// The base background color of the tooltip. (default: 'tansparent', used in only **fixed** type).
  final Color? baseBackgroundColor;

  /// The background color of the tooltip.
  final Color? backgroundColor;

  /// The border color of the tooltip.
  final Color? borderColor;

  /// Callback function when the tooltip is closed.
  final VoidCallback? onTapRemove;

  /// The padding inside the tooltip.
  final EdgeInsets? padding;

  /// The width of the tooltip (required for placement type).
  final double? width;

  /// The position of the tooltip relative to the triggering element.
  final Offset iconPosition;

  /// The size of the triggering element.
  final Size iconSize;

  /// Whether the tooltip can be closed by tapping outside.
  final bool? isAvailableTapToClose;

  /// Whether the tooltip is positioned on the left or right.
  final bool isBubbleClipperSideLeft;

  /// Whether the tooltip is currently visible.
  final bool isPlacementTooltipVisible;

  /// Whether the tooltip should animate its appearance on the initial build.
  final bool animateOnBuild;

  /// The style of the title text.
  final TextStyle titleStyle;

  /// Creates an instance of `CoconutToolTip`.
  const CoconutToolTip({
    super.key,
    required this.tooltipType,
    required this.richText,
    this.brightness,
    this.tooltipState = CoconutTooltipState.info,
    this.isAvailableTapToClose = true,
    this.showIcon = true,
    this.baseBackgroundColor = Colors.transparent,
    this.backgroundColor,
    this.borderColor,
    this.onTapRemove,
    this.padding,
    this.isBubbleClipperSideLeft = true,
    this.isPlacementTooltipVisible = false,
    this.animateOnBuild = false,
    this.width,
    this.iconPosition = Offset.zero,
    this.iconSize = Size.zero,
    this.titleStyle = CoconutTypography.caption_10,
  }) : assert(tooltipType != CoconutTooltipType.placement || (width != null && onTapRemove != null),
            'When using CoconutTooltipType.placement, width and onTapRemove must not be null.');

  @override
  State<CoconutToolTip> createState() => _CoconutToolTipState();
}

/// Defines different tooltip states with corresponding icons and colors.
enum CoconutTooltipState {
  info('info', 4, 'packages/coconut_design_system/assets/svg/tooltip/info.svg'),
  normal('normal', 8, 'packages/coconut_design_system/assets/svg/tooltip/normal.svg'),
  success('success', 3, 'packages/coconut_design_system/assets/svg/tooltip/success.svg'),
  warning('warning', 2, 'packages/coconut_design_system/assets/svg/tooltip/warning.svg'),
  error('error', 5, 'packages/coconut_design_system/assets/svg/tooltip/error.svg');

  final String code;
  final int colorIndex;
  final String svgPath;
  const CoconutTooltipState(this.code, this.colorIndex, this.svgPath);

  /// Returns the tooltip state based on the provided code.
  factory CoconutTooltipState.getByCode(String code) {
    return CoconutTooltipState.values.firstWhere((value) => value.code == code);
  }
}

/// Specifies the different tooltip types.
enum CoconutTooltipType {
  placement,
  fixed,
  fixedClosable,
}

class _CoconutToolTipState extends State<CoconutToolTip> {
  bool _isVisibleAnimated = false;

  late Color _borderColor;
  late Color _backgroundColor;
  late EdgeInsets _padding;
  SvgPicture? _icon;

  late Color color;

  Brightness brightness = CoconutTheme.brightness();

  @override
  Widget build(BuildContext context) {
    switch (widget.tooltipType) {
      case CoconutTooltipType.placement:
        {
          return Visibility(
            visible: widget.isPlacementTooltipVisible,
            child: AnimatedOpacity(
              opacity: widget.animateOnBuild
                  ? _isVisibleAnimated
                      ? 1.0
                      : 0.0
                  : 1.0,
              duration: const Duration(milliseconds: 1000),
              child: GestureDetector(
                onTap: () {
                  if (widget.onTapRemove != null) {
                    widget.onTapRemove!();
                  }
                },
                child: ClipPath(
                  clipper: widget.isBubbleClipperSideLeft
                      ? LeftTriangleBubbleClipper()
                      : RightTriangleBubbleClipper(),
                  child: Container(
                    padding: _padding,
                    color: _backgroundColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: widget.richText,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      case CoconutTooltipType.fixed:
        {
          return Stack(
            children: [
              // Base background color layer (only for fixed tooltips)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.baseBackgroundColor,
                    borderRadius: BorderRadius.circular(CoconutStyles.radius_250),
                  ),
                ),
              ),
              // Actual tooltip content
              Container(
                padding: _padding,
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(CoconutStyles.radius_250),
                  border: Border.all(width: 1, color: _borderColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.showIcon)
                      Container(
                        padding: const EdgeInsets.only(right: 8),
                        child: _icon,
                      ),
                    Expanded(child: widget.richText),
                  ],
                ),
              ),
            ],
          );
        }
      case CoconutTooltipType.fixedClosable:
        {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                    minHeight: Sizes.size60, minWidth: widget.width ?? constraints.maxWidth),
                decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(CoconutStyles.radius_250),
                    border: Border.all(width: 1, color: _borderColor)),
                child: Stack(
                  children: [
                    Padding(
                      padding: _padding,
                      child: widget.richText,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        iconSize: 16,
                        onPressed: widget.onTapRemove,
                        icon: SvgPicture.asset(
                          'packages/coconut_design_system/assets/svg/close.svg',
                          colorFilter: ColorFilter.mode(
                              CoconutColors.onPrimary(brightness), BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    }
  }

  @override
  void didUpdateWidget(covariant CoconutToolTip oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.brightness != oldWidget.brightness) {
      setState(() {
        initColors();
      });
    }

    if (widget.isBubbleClipperSideLeft != oldWidget.isBubbleClipperSideLeft) {
      setState(() {});
    }

    if (widget.isPlacementTooltipVisible != oldWidget.isPlacementTooltipVisible) {
      if (widget.isPlacementTooltipVisible) {
        _showTooltip();
      } else {
        _hideTooltip();
      }
    }
  }

  void _showTooltip() {
    setState(() {
      _isVisibleAnimated = true;
    });
  }

  void _hideTooltip() {
    setState(() {
      _isVisibleAnimated = false;
    });
  }

  /// Initializes tooltip colors based on the theme and type.
  void initColors() {
    _borderColor = widget.borderColor ??
        (widget.tooltipType == CoconutTooltipType.fixedClosable
            ? _getBorderColorForBrighness()
            : CoconutColors.onPrimary(brightness));
    _backgroundColor = widget.backgroundColor ??
        (widget.tooltipType == CoconutTooltipType.fixedClosable ||
                widget.tooltipType == CoconutTooltipType.placement
            ? _getBackgroundColorForBrighness()
            : CoconutColors.surface(brightness));

    color = CoconutColors.colorPalette[widget.tooltipState.colorIndex];

    if (widget.tooltipType == CoconutTooltipType.fixed) {
      _borderColor = widget.borderColor ?? color.withOpacity(0.7);
      _backgroundColor = widget.backgroundColor ??
          CoconutColors.backgroundColorPaletteLight[widget.tooltipState.colorIndex]
              .withOpacity(0.18);
    }
  }

  @override
  void initState() {
    super.initState();
    initColors();

    if (widget.tooltipType == CoconutTooltipType.fixed) {
      _icon = SvgPicture.asset(widget.tooltipState.svgPath,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn), width: 18);
      _padding = widget.padding ?? const EdgeInsets.all(CoconutLayout.defaultPadding);
    } else if (widget.tooltipType == CoconutTooltipType.fixedClosable) {
      _padding = widget.padding ?? const EdgeInsets.all(Sizes.size12);
    } else {
      _padding = widget.padding ?? const EdgeInsets.only(top: 25, left: 18, right: 18, bottom: 10);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.isPlacementTooltipVisible) {
          _showTooltip();
        }
      });
    }
  }

  Color _getBackgroundColorForBrighness() {
    switch (widget.brightness) {
      case Brightness.dark:
        return CoconutColors.gray800;

      default:
        return CoconutColors.gray200;
    }
  }

  Color _getBorderColorForBrighness() {
    switch (widget.brightness) {
      case Brightness.dark:
        return CoconutColors.gray800;

      default:
        return CoconutColors.gray200;
    }
  }
}
