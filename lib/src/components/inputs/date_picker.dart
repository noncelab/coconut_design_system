import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double _calendarDatePickerHeight = 346;

/// A Coconut-styled wrapper around Flutter's [CalendarDatePicker].
///
/// `CoconutDatePicker` keeps Flutter's built-in calendar behavior while exposing
/// the date picker theme values as individual parameters. It does not accept a
/// whole [ThemeData]; instead, each value is resolved locally and applied through
/// [DatePickerThemeData].
class CoconutDatePicker extends StatelessWidget {
  /// Creates a `CoconutDatePicker` widget.
  const CoconutDatePicker({
    super.key,
    required this.onDateChanged,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.currentDate,
    this.onDisplayedMonthChanged,
    this.initialCalendarMode = DatePickerMode.day,
    this.selectableDayPredicate,
    this.locale = const Locale('en'),
    this.width = 320,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.headerForegroundColor,
    this.headerHeadlineStyle,
    this.headerHelpStyle,
    this.modeToggleStyle,
    this.controlColor,
    this.weekdayStyle,
    this.dayStyle,
    this.dayForegroundColor,
    this.selectedDayForegroundColor,
    this.disabledDayForegroundColor,
    this.dayBackgroundColor,
    this.selectedDayBackgroundColor,
    this.dayOverlayColor,
    this.dayShape,
    this.todayForegroundColor,
    this.todayBackgroundColor,
    this.todayBorder,
    this.yearStyle,
    this.yearForegroundColor,
    this.selectedYearForegroundColor,
    this.disabledYearForegroundColor,
    this.yearBackgroundColor,
    this.selectedYearBackgroundColor,
    this.yearOverlayColor,
    this.showTimeSelector = false,
    this.selectedTime,
    this.onTimeChanged,
    this.timeLabel = 'Time',
    this.timeLabelStyle,
    this.timeTextStyle,
    this.amLabel = 'AM',
    this.pmLabel = 'PM',
    this.periodTextStyle,
    this.timeDividerColor,
    this.timeFieldBackgroundColor,
    this.periodFieldBackgroundColor,
    this.selectedPeriodBackgroundColor,
    this.selectedPeriodBorderColor,
    this.timeFieldTextColor,
    this.selectedPeriodTextColor,
    this.unselectedPeriodTextColor,
  });

  /// The initially selected date.
  final DateTime? initialDate;

  /// The first selectable date.
  final DateTime firstDate;

  /// The last selectable date.
  final DateTime lastDate;

  /// The date highlighted as today.
  final DateTime? currentDate;

  /// Called when the user selects a date.
  final ValueChanged<DateTime> onDateChanged;

  /// Called when the visible month changes.
  final ValueChanged<DateTime>? onDisplayedMonthChanged;

  /// The initially displayed picker mode.
  final DatePickerMode initialCalendarMode;

  /// Optional date enablement predicate.
  final SelectableDayPredicate? selectableDayPredicate;

  /// Locale used by the inner [CalendarDatePicker].
  ///
  /// This controls localized month, year, weekday, and semantic labels. The
  /// default is English.
  final Locale locale;

  /// Optional fixed picker width.
  final double width;

  /// Padding around the picker.
  final EdgeInsetsGeometry padding;

  /// Calendar background color.
  final Color? backgroundColor;

  /// Header background color.
  final Color? headerBackgroundColor;

  /// Header text and icon color.
  final Color? headerForegroundColor;

  /// Header headline text style.
  final TextStyle? headerHeadlineStyle;

  /// Header help text style.
  final TextStyle? headerHelpStyle;

  /// Month/year mode toggle text style.
  ///
  /// Flutter's [CalendarDatePicker] reads this from [TextTheme.titleSmall].
  final TextStyle? modeToggleStyle;

  /// Month/year mode toggle and month navigation icon color.
  ///
  /// Flutter applies 60% opacity to this color internally.
  final Color? controlColor;

  /// Weekday label text style.
  final TextStyle? weekdayStyle;

  /// Day label text style.
  final TextStyle? dayStyle;

  /// Default day label color.
  final Color? dayForegroundColor;

  /// Selected day label color.
  final Color? selectedDayForegroundColor;

  /// Disabled day label color.
  final Color? disabledDayForegroundColor;

  /// Default day background color.
  final Color? dayBackgroundColor;

  /// Selected day background color.
  final Color? selectedDayBackgroundColor;

  /// Day pressed, hovered, and focused overlay color.
  final Color? dayOverlayColor;

  /// Day shape.
  final OutlinedBorder? dayShape;

  /// Today label color.
  final Color? todayForegroundColor;

  /// Today background color.
  final Color? todayBackgroundColor;

  /// Today border.
  final BorderSide? todayBorder;

  /// Year label text style.
  final TextStyle? yearStyle;

  /// Default year label color.
  final Color? yearForegroundColor;

  /// Selected year label color.
  final Color? selectedYearForegroundColor;

  /// Disabled year label color.
  final Color? disabledYearForegroundColor;

  /// Default year background color.
  final Color? yearBackgroundColor;

  /// Selected year background color.
  final Color? selectedYearBackgroundColor;

  /// Year pressed, hovered, and focused overlay color.
  final Color? yearOverlayColor;

  /// Whether to show the time selector below the calendar.
  final bool showTimeSelector;

  /// The currently selected time.
  final TimeOfDay? selectedTime;

  /// Called when the user edits the time value.
  final ValueChanged<TimeOfDay>? onTimeChanged;

  /// Label shown on the time selector row.
  final String timeLabel;

  /// Time selector label text style.
  final TextStyle? timeLabelStyle;

  /// Time value text style.
  final TextStyle? timeTextStyle;

  /// AM/PM text style.
  final TextStyle? periodTextStyle;

  /// Divider color above the time selector row.
  final Color? timeDividerColor;

  /// Time value field background color.
  final Color? timeFieldBackgroundColor;

  /// AM/PM segmented field background color.
  final Color? periodFieldBackgroundColor;

  /// Selected AM/PM segment background color.
  final Color? selectedPeriodBackgroundColor;

  /// Selected AM/PM segment border color.
  final Color? selectedPeriodBorderColor;

  /// Time value text color.
  final Color? timeFieldTextColor;

  /// Selected AM/PM text color.
  final Color? selectedPeriodTextColor;

  /// Unselected AM/PM text color.
  final Color? unselectedPeriodTextColor;

  final String amLabel;

  final String pmLabel;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final resolvedBackgroundColor = backgroundColor ?? CoconutColors.surface(brightness);
    final resolvedHeaderForegroundColor =
        headerForegroundColor ?? CoconutColors.onBlack(brightness);
    final resolvedControlColor = controlColor ?? CoconutColors.onBlack(brightness);
    final resolvedDayForegroundColor = dayForegroundColor ?? CoconutColors.onGray800(brightness);
    final resolvedSelectedDayForegroundColor =
        selectedDayForegroundColor ?? CoconutColors.onWhite(brightness);
    final resolvedDisabledDayForegroundColor =
        disabledDayForegroundColor ?? CoconutColors.onGray350(brightness);
    final resolvedSelectedDayBackgroundColor =
        selectedDayBackgroundColor ?? CoconutColors.onGray800(brightness);
    final resolvedTodayForegroundColor = todayForegroundColor ?? CoconutColors.onBlack(brightness);
    final resolvedYearForegroundColor = yearForegroundColor ?? CoconutColors.onGray800(brightness);
    final resolvedSelectedYearForegroundColor =
        selectedYearForegroundColor ?? CoconutColors.onWhite(brightness);
    final resolvedDisabledYearForegroundColor =
        disabledYearForegroundColor ?? CoconutColors.onGray350(brightness);
    final resolvedSelectedYearBackgroundColor =
        selectedYearBackgroundColor ?? CoconutColors.onBlack(brightness);
    final resolvedInitialDate = initialDate ?? currentDate ?? DateTime.now();

    return Container(
      width: width,
      padding: padding,
      color: resolvedBackgroundColor,
      child: Material(
        color: Colors.transparent,
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  onSurface: resolvedControlColor,
                  primary: resolvedSelectedDayBackgroundColor,
                  onPrimary: resolvedSelectedDayForegroundColor,
                ),
            textTheme: Theme.of(context).textTheme.copyWith(
                  titleSmall: modeToggleStyle ?? CoconutTypography.body1_16,
                ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: resolvedBackgroundColor,
              headerBackgroundColor: headerBackgroundColor ?? resolvedBackgroundColor,
              headerForegroundColor: resolvedHeaderForegroundColor,
              headerHeadlineStyle: headerHeadlineStyle ?? CoconutTypography.body1_16,
              headerHelpStyle: headerHelpStyle ?? CoconutTypography.body3_12,
              weekdayStyle:
                  weekdayStyle ?? CoconutTypography.body2_14.setColor(CoconutColors.blueGray),
              dayStyle: dayStyle ?? CoconutTypography.body1_16,
              dayForegroundColor: _resolveColor(
                normal: resolvedDayForegroundColor,
                selected: resolvedSelectedDayForegroundColor,
                disabled: resolvedDisabledDayForegroundColor,
              ),
              dayBackgroundColor: _resolveColor(
                normal: dayBackgroundColor,
                selected: resolvedSelectedDayBackgroundColor,
              ),
              dayOverlayColor: _resolveOverlayColor(dayOverlayColor),
              dayShape: WidgetStateProperty.all<OutlinedBorder?>(
                dayShape ?? const CircleBorder(),
              ),
              todayForegroundColor: _resolveColor(
                normal: resolvedTodayForegroundColor,
                selected: resolvedSelectedDayForegroundColor,
                disabled: resolvedDisabledDayForegroundColor,
              ),
              todayBackgroundColor: _resolveColor(
                normal: todayBackgroundColor,
                selected: resolvedSelectedDayBackgroundColor,
              ),
              todayBorder: todayBorder ?? BorderSide.none,
              yearStyle: yearStyle ?? CoconutTypography.body2_14_Number,
              yearForegroundColor: _resolveColor(
                normal: resolvedYearForegroundColor,
                selected: resolvedSelectedYearForegroundColor,
                disabled: resolvedDisabledYearForegroundColor,
              ),
              yearBackgroundColor: _resolveColor(
                normal: yearBackgroundColor,
                selected: resolvedSelectedYearBackgroundColor,
              ),
              yearOverlayColor: _resolveOverlayColor(yearOverlayColor),
            ),
          ),
          child: Localizations.override(
            context: context,
            locale: locale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: _calendarDatePickerHeight,
                  child: CalendarDatePicker(
                    key: ValueKey<DateTime>(DateUtils.dateOnly(resolvedInitialDate)),
                    initialDate: resolvedInitialDate,
                    firstDate: firstDate,
                    lastDate: lastDate,
                    currentDate: currentDate,
                    onDateChanged: onDateChanged,
                    onDisplayedMonthChanged: onDisplayedMonthChanged,
                    initialCalendarMode: initialCalendarMode,
                    selectableDayPredicate: selectableDayPredicate,
                  ),
                ),
                if (showTimeSelector)
                  _CoconutDatePickerTimeSelector(
                    selectedTime: selectedTime ?? TimeOfDay.now(),
                    onTimeChanged: onTimeChanged,
                    label: timeLabel,
                    labelStyle: timeLabelStyle ??
                        CoconutTypography.body1_16.setColor(
                          CoconutColors.onGray800(brightness),
                        ),
                    timeTextStyle: timeTextStyle ??
                        CoconutTypography.body1_16.setColor(
                          timeFieldTextColor ?? CoconutColors.onGray800(brightness),
                        ),
                    periodTextStyle: periodTextStyle ?? CoconutTypography.body1_16,
                    dividerColor: timeDividerColor ?? CoconutColors.onGray200(brightness),
                    timeFieldBackgroundColor:
                        timeFieldBackgroundColor ?? CoconutColors.onGray150(brightness),
                    periodFieldBackgroundColor:
                        periodFieldBackgroundColor ?? CoconutColors.onGray150(brightness),
                    selectedPeriodBackgroundColor:
                        selectedPeriodBackgroundColor ?? CoconutColors.surface(brightness),
                    selectedPeriodBorderColor:
                        selectedPeriodBorderColor ?? CoconutColors.onGray300(brightness),
                    selectedPeriodTextColor:
                        selectedPeriodTextColor ?? CoconutColors.onGray800(brightness),
                    unselectedPeriodTextColor:
                        unselectedPeriodTextColor ?? CoconutColors.onGray800(brightness),
                    amLabel: amLabel,
                    pmLabel: pmLabel,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static WidgetStateProperty<Color?> _resolveColor({
    Color? normal,
    Color? selected,
    Color? disabled,
  }) {
    return WidgetStateProperty.resolveWith((states) {
      if (disabled != null && states.contains(WidgetState.disabled)) {
        return disabled;
      }
      if (selected != null && states.contains(WidgetState.selected)) {
        return selected;
      }
      return normal;
    });
  }

  static WidgetStateProperty<Color?>? _resolveOverlayColor(Color? color) {
    if (color == null) {
      return null;
    }

    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return color.withValues(alpha: 0.12);
      }
      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
        return color.withValues(alpha: 0.08);
      }
      return null;
    });
  }
}

class _CalendarDatePickerScrollBehavior extends MaterialScrollBehavior {
  const _CalendarDatePickerScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const _CalendarDatePickerScrollPhysics();
  }
}

class _CalendarDatePickerScrollPhysics extends ClampingScrollPhysics {
  const _CalendarDatePickerScrollPhysics({super.parent});

  @override
  _CalendarDatePickerScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _CalendarDatePickerScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    if (position.axis == Axis.vertical) {
      return false;
    }
    return super.shouldAcceptUserOffset(position);
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (position.axis == Axis.vertical) {
      return 0;
    }
    return super.applyPhysicsToUserOffset(position, offset);
  }
}

class _CoconutDatePickerTimeSelector extends StatefulWidget {
  const _CoconutDatePickerTimeSelector({
    required this.selectedTime,
    required this.label,
    required this.labelStyle,
    required this.timeTextStyle,
    required this.periodTextStyle,
    required this.dividerColor,
    required this.timeFieldBackgroundColor,
    required this.periodFieldBackgroundColor,
    required this.selectedPeriodBackgroundColor,
    required this.selectedPeriodBorderColor,
    required this.selectedPeriodTextColor,
    required this.unselectedPeriodTextColor,
    this.onTimeChanged,
    this.amLabel = 'AM',
    this.pmLabel = 'PM',
  });

  final TimeOfDay selectedTime;
  final String label;
  final TextStyle labelStyle;
  final TextStyle timeTextStyle;
  final TextStyle periodTextStyle;
  final Color dividerColor;
  final Color timeFieldBackgroundColor;
  final Color periodFieldBackgroundColor;
  final Color selectedPeriodBackgroundColor;
  final Color selectedPeriodBorderColor;
  final Color selectedPeriodTextColor;
  final Color unselectedPeriodTextColor;
  final ValueChanged<TimeOfDay>? onTimeChanged;
  final String amLabel;
  final String pmLabel;

  @override
  State<_CoconutDatePickerTimeSelector> createState() => _CoconutDatePickerTimeSelectorState();
}

class _CoconutDatePickerTimeSelectorState extends State<_CoconutDatePickerTimeSelector> {
  late final TextEditingController _hourController;
  late final TextEditingController _minuteController;
  late final FocusNode _hourFocusNode;
  late final FocusNode _minuteFocusNode;
  bool _isMovingFromHourToMinute = false;
  bool _isMovingFromMinuteToHour = false;

  bool get _isAm => widget.selectedTime.hour < 12;

  @override
  void initState() {
    super.initState();
    _hourController = TextEditingController(text: _formattedHour);
    _minuteController = TextEditingController(text: _formattedMinute);
    _hourFocusNode = FocusNode();
    _minuteFocusNode = FocusNode();
    _hourFocusNode.addListener(_handleHourFocusChange);
    _minuteFocusNode.addListener(_handleMinuteFocusChange);
  }

  @override
  void didUpdateWidget(covariant _CoconutDatePickerTimeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTime != widget.selectedTime) {
      if (!_hourFocusNode.hasFocus) {
        _hourController.text = _formattedHour;
      }
      if (!_minuteFocusNode.hasFocus) {
        _minuteController.text = _formattedMinute;
      }
    }
  }

  @override
  void dispose() {
    _hourFocusNode.removeListener(_handleHourFocusChange);
    _minuteFocusNode.removeListener(_handleMinuteFocusChange);
    _hourController.dispose();
    _minuteController.dispose();
    _hourFocusNode.dispose();
    _minuteFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: widget.dividerColor,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    widget.label,
                    style: widget.labelStyle,
                  ),
                ),
              ),
              Container(
                width: 90,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.timeFieldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _TimeInputField(
                      controller: _hourController,
                      focusNode: _hourFocusNode,
                      enabled: widget.onTimeChanged != null,
                      textStyle: widget.timeTextStyle,
                      minValue: 1,
                      maxValue: 12,
                      onChanged: _handleHourChanged,
                      onKeyEvent: _handleHourKeyEvent,
                    ),
                    Text(
                      ' : ',
                      style: widget.timeTextStyle,
                    ),
                    _TimeInputField(
                      controller: _minuteController,
                      focusNode: _minuteFocusNode,
                      enabled: widget.onTimeChanged != null,
                      textStyle: widget.timeTextStyle,
                      minValue: 0,
                      maxValue: 59,
                      onBackspaceWhenEmpty: _handleMinuteBackspaceWhenEmpty,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 120,
                height: 44,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: widget.periodFieldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _PeriodSegmentedControl(
                  isAm: _isAm,
                  textStyle: widget.periodTextStyle,
                  selectedBackgroundColor: widget.selectedPeriodBackgroundColor,
                  selectedBorderColor: widget.selectedPeriodBorderColor,
                  selectedTextColor: widget.selectedPeriodTextColor,
                  unselectedTextColor: widget.unselectedPeriodTextColor,
                  amLabel: widget.amLabel,
                  pmLabel: widget.pmLabel,
                  onChanged:
                      widget.onTimeChanged == null ? null : (isAm) => _updatePeriod(isAm: isAm),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int get _selectedHour {
    final hour = widget.selectedTime.hourOfPeriod;
    return hour == 0 ? 12 : hour;
  }

  String get _formattedHour => _selectedHour.toString().padLeft(2, '0');

  String get _formattedMinute => widget.selectedTime.minute.toString().padLeft(2, '0');

  void _emitTime() {
    if (!mounted) {
      return;
    }

    final hourOfPeriod = _parseHour(_hourController.text);
    final minute = _parseMinute(_minuteController.text);
    final hour = _to24Hour(hourOfPeriod: hourOfPeriod, isAm: _isAm);
    widget.onTimeChanged?.call(TimeOfDay(hour: hour, minute: minute));
  }

  void _handleHourFocusChange() {
    if (_hourFocusNode.hasFocus) {
      _moveCursorToEnd(_hourController);
    } else {
      _normalizeHour();
      if (_isMovingFromHourToMinute) {
        _isMovingFromHourToMinute = false;
      } else if (!_minuteFocusNode.hasFocus && _minuteController.text.isEmpty) {
        _normalizeMinute();
      }
    }
  }

  void _handleMinuteFocusChange() {
    if (_minuteFocusNode.hasFocus) {
      _moveCursorToEnd(_minuteController);
    } else {
      if (_isMovingFromMinuteToHour) {
        _isMovingFromMinuteToHour = false;
        return;
      }
      _normalizeMinute();
    }
  }

  void _moveCursorToEnd(TextEditingController controller) {
    controller.selection = TextSelection.collapsed(
      offset: controller.text.length,
    );
  }

  void _handleHourChanged(String value) {
    if (value.length != 2 || _minuteFocusNode.hasFocus) {
      return;
    }

    _isMovingFromHourToMinute = true;
    _minuteFocusNode.requestFocus();
  }

  KeyEventResult _handleHourKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent || _hourController.text.length != 1 || _minuteFocusNode.hasFocus) {
      return KeyEventResult.ignored;
    }

    final hourPrefix = int.tryParse(_hourController.text);
    final nextDigit = _digitFromKey(event.logicalKey);
    if (hourPrefix == null || hourPrefix < 2 || nextDigit == null) {
      return KeyEventResult.ignored;
    }

    _isMovingFromHourToMinute = true;
    _minuteController.value = TextEditingValue(
      text: nextDigit,
      selection: TextSelection.collapsed(offset: nextDigit.length),
    );
    _minuteFocusNode.requestFocus();
    return KeyEventResult.handled;
  }

  String? _digitFromKey(LogicalKeyboardKey key) {
    if (key.keyLabel.length == 1 && int.tryParse(key.keyLabel) != null) {
      return key.keyLabel;
    }
    return null;
  }

  KeyEventResult _handleMinuteBackspaceWhenEmpty() {
    if (!mounted || _minuteController.text.isNotEmpty) {
      return KeyEventResult.ignored;
    }

    _isMovingFromMinuteToHour = true;
    _hourFocusNode.requestFocus();
    _removeLastHourDigit();
    return KeyEventResult.handled;
  }

  void _removeLastHourDigit() {
    final hourText = _hourController.text;
    if (hourText.isEmpty) {
      return;
    }

    final nextText = hourText.substring(0, hourText.length - 1);
    _hourController.value = TextEditingValue(
      text: nextText,
      selection: TextSelection.collapsed(offset: nextText.length),
    );
  }

  void _normalizeHour() {
    if (!mounted) {
      return;
    }

    final hour = _parseHour(_hourController.text);
    _hourController.text = hour.toString().padLeft(2, '0');
    _emitTime();
  }

  void _normalizeMinute() {
    if (!mounted) {
      return;
    }

    final minute = _parseMinute(_minuteController.text);
    _minuteController.text = minute.toString().padLeft(2, '0');
    _emitTime();
  }

  int _parseHour(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null) {
      return _selectedHour;
    }
    return parsed.clamp(1, 12);
  }

  int _parseMinute(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null) {
      return widget.selectedTime.minute;
    }
    return parsed.clamp(0, 59);
  }

  void _updatePeriod({required bool isAm}) {
    if (isAm == _isAm) {
      return;
    }

    final hourOfPeriod = _parseHour(_hourController.text);
    final minute = _parseMinute(_minuteController.text);
    final nextHour = _to24Hour(hourOfPeriod: hourOfPeriod, isAm: isAm);
    widget.onTimeChanged?.call(TimeOfDay(hour: nextHour, minute: minute));
  }

  int _to24Hour({required int hourOfPeriod, required bool isAm}) {
    if (isAm) {
      return hourOfPeriod == 12 ? 0 : hourOfPeriod;
    }
    return hourOfPeriod == 12 ? 12 : hourOfPeriod + 12;
  }
}

class _TimeInputField extends StatelessWidget {
  const _TimeInputField({
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.textStyle,
    required this.minValue,
    required this.maxValue,
    this.onChanged,
    this.onKeyEvent,
    this.onBackspaceWhenEmpty,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final TextStyle textStyle;
  final int minValue;
  final int maxValue;
  final ValueChanged<String>? onChanged;
  final KeyEventResult Function(KeyEvent event)? onKeyEvent;
  final KeyEventResult Function()? onBackspaceWhenEmpty;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: Focus(
        onKeyEvent: (node, event) {
          final result = onKeyEvent?.call(event);
          if (result == KeyEventResult.handled) {
            return KeyEventResult.handled;
          }

          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty) {
            return onBackspaceWhenEmpty?.call() ?? KeyEventResult.ignored;
          }
          return KeyEventResult.ignored;
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
            _RangeTextInputFormatter(
              minValue: minValue,
              maxValue: maxValue,
            ),
          ],
          style: textStyle,
          cursorColor: textStyle.color,
          decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            counterText: '',
          ),
          onChanged: onChanged,
          onTapOutside: (_) {
            focusNode.unfocus();
          },
        ),
      ),
    );
  }
}

class _RangeTextInputFormatter extends TextInputFormatter {
  const _RangeTextInputFormatter({
    required this.minValue,
    required this.maxValue,
  });

  final int minValue;
  final int maxValue;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final parsed = int.tryParse(newValue.text);
    if (parsed == null) {
      return oldValue;
    }

    if (newValue.text.length == 1) {
      return newValue;
    }

    if (parsed >= minValue && parsed <= maxValue) {
      return newValue;
    }

    return oldValue;
  }
}

class _PeriodSegmentedControl extends StatelessWidget {
  const _PeriodSegmentedControl({
    required this.isAm,
    required this.textStyle,
    required this.selectedBackgroundColor,
    required this.selectedBorderColor,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    this.onChanged,
    required this.amLabel,
    required this.pmLabel,
  });

  final bool isAm;
  final TextStyle textStyle;
  final Color selectedBackgroundColor;
  final Color selectedBorderColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final ValueChanged<bool>? onChanged;
  final String amLabel;
  final String pmLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / 2;

          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                left: isAm ? 0 : segmentWidth,
                top: 0,
                bottom: 0,
                width: segmentWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: selectedBackgroundColor,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: selectedBorderColor),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _PeriodSegment(
                      label: amLabel,
                      isSelected: isAm,
                      textStyle: textStyle,
                      selectedTextColor: selectedTextColor,
                      unselectedTextColor: unselectedTextColor,
                      onTap: onChanged == null ? null : () => onChanged!(true),
                    ),
                  ),
                  Expanded(
                    child: _PeriodSegment(
                      label: pmLabel,
                      isSelected: !isAm,
                      textStyle: textStyle,
                      selectedTextColor: selectedTextColor,
                      unselectedTextColor: unselectedTextColor,
                      onTap: onChanged == null ? null : () => onChanged!(false),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PeriodSegment extends StatelessWidget {
  const _PeriodSegment({
    required this.label,
    required this.isSelected,
    required this.textStyle,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    this.onTap,
  });

  final String label;
  final bool isSelected;
  final TextStyle textStyle;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(7),
        child: Center(
          child: Text(
            label,
            style: textStyle.setColor(
              isSelected ? selectedTextColor : unselectedTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
