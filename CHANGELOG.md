# 📜 CHANGELOG  

All notable changes to the **Coconut Design System** will be documented in this file.  
This project follows **[Semantic Versioning](https://semver.org/)**.

---

## **[0.7.2] - 2025-04-15**

### ✨ New Features
- **`CoconutAppBar`**
  - Explicitly set `SystemUiOverlayStyle` for light mode to ensure consistent status bar appearance.

### 🛠 Fixes & Improvements
- **`CoconutTextField`**
  - `activeColor` is now applied only when the field is focused, improving border color behavior.

- **`CoconutButton`**
  - Fixed text alignment by wrapping label with `Center` to ensure both vertical and horizontal centering.

- **`CoconutTypography`**
  - Set default line height for better text layout consistency.

---

## **[0.7.1] - 2025-04-02**

### ✨ New Features
- **`CoconutAppBar`**
  - Added `titlePadding` parameter to allow custom padding around the title.

---

## **[0.7.0] - 2025-03-28**

### ✨ New Features
- **`CoconutAppBar`**
  - Added `height` and `expandedHeight` properties.
  - Added `bottomWidget` and `preferredSizeHeight` to `buildHomeAppbar`.

- **`CoconutPulldownMenu`**
  - Added `buttonHeight` and `buttonPadding` parameters.
  - Support for customizing dropdown shadow via `blurRadius` and `spreadRadius`.

- **`CoconutPopup`**
  - Added `centerDescription` parameter.
  - Added `ClipRRect` and press effect.
  - Separated padding into `titlePadding` and `descriptionPadding`.
  - Added customizable `TextStyle` for title, description, and buttons.

- **`CoconutTextField`**
  - Added `padding`, `height`, `textAlign`, `textInputAction`, `isLengthVisible`, and `fontFamily` parameters.

- **`CoconutChip`**
  - Removed `child` property.
  - Added:
    - `label`, `labelFontFamily`, `labelSize`, `labelColor`
    - `isSelected`, `hasOpacity`, `selectedBorderWidth`, `minWidth`

### 🛠 Fixes & Improvements
- **`CoconutAppBar`**
  - Fixed alignment issue in `buildHomeAppbar`.

- **`CoconutTextField`**
  - Fixed border color logic.
  - Unified error handling: replaced `isVisibleErrorText` with `isError`.

- **`CoconutUnderlinedButton`**
  - Fixed underline occupying entire screen width.
  - Enabled touch detection in padding area.

- **`CoconutChip`**
  - Changed `isSelected` to be nullable.

- **`CoconutPulldown`**
  - Refactored: Removed `dividerIndex` and `dividerPointColor`, added `dividerHeight` and `borderRadius`.

- **`CoconutPopup`**
  - Adjusted button press opacity effect.

- **General**
  - Removed unnecessary `Container` usage in widget tree.

---

## **[0.6.0] - 2025-02-25**  

### ✨ New Features  
- **Added `CoconutFrostedAppBar`** – A frosted glass effect app bar with adaptive status bar icon color.  
- **Added `keys` property to `CoconutSegmentedControl`** – Allows better state management by using `GlobalKey`.  

### 🛠 Fixes & Improvements  
- **`CoconutTooltip`**
  - Fixed **opacity transition issue** in tooltip animations.  
  - Added **`baseBackgroundColor` support** for fixed tooltips.  

- **`CoconutTextField`**
  - Modified behavior to **prevent disposal of `FocusNode` and `TextEditingController`** in `dispose`, considering external injection.  

- **`CoconutToast`**
  - General bug fixes and stability improvements.  

- **`CoconutBottomSheet`**
  - Fixed unintended UI behavior.  

- **`CoconutAppBar`**
  - **Removed `hasRightIcon` parameter** – Now the app bar automatically determines if a right icon is needed.  
  - Refactored `buildWithNext` to **derive brightness from `Theme.of(context)`** instead of using a default parameter.  

---

## **[0.5.0] - 2025-02-14**  

### 🎉 New Features  
- ✨ **Added `CoconutButton`** – Standard, Outlined, and Underlined Button components.  
- ✨ **Added `CoconutSegmentedControl`** – A segmented button control for tab-based selections.  
- ✨ **Added `CoconutAppBar`** – Customizable app bar with buttons and title support.  
- ✨ **Added `CoconutAppBarButton`** – A button component for use within `CoconutAppBar`.  
- ✨ **Added `CoconutTooltip`** – Provides fixed and floating tooltips.  
- ✨ **Added `CoconutToast`** – Supports top and bottom toast notifications.  
- ✨ **Added `CoconutPopup`** – A customizable popup dialog with title and description.  
- ✨ **Added `CoconutPulldown`** – A dropdown menu for selecting options.  
- ✨ **Added `CoconutPulldownMenu`** – A list-based pulldown menu for selections.  
- ✨ **Added `CoconutCheckbox`** – Custom checkbox UI component.  
- ✨ **Added `CoconutSwitch`** – A toggle switch component.  
- ✨ **Added `CoconutStepper`** – A stepper UI for navigation flows.  
- ✨ **Added `CoconutChip`** – A chip-style UI component.  
- ✨ **Added `CoconutTagChip`** – A tag-style chip for filtering and selection.  
- ✨ **Added `CoconutTextField`** – A themed text field component.  
- ✨ **Added `CoconutBottomSheet`** – Supports modal and fixed bottom sheets.  
- ✨ **Added `CoconutBubbleClipper`** – Custom clippers for tooltips and speech bubbles.  
- ✨ **Added `CoconutProgressIndicator`** – Animated progress bar indicator.  
- ✨ **Added `CoconutCircularIndicator`** – Lottie-based animated circular indicator.  
- ✨ **Added `CoconutIcon`** – Custom icon component for consistent theming.  
- ✨ **Added `CoconutColorScheme`** – Centralized color management.  
- ✨ **Added `CoconutTypography`** – Standardized text styles and font settings.  
- ✨ **Added `CoconutLayout`** – Layout-based spacing and size management.  
- ✨ **Added `CoconutSizes`** – Predefined size values for spacing and UI components.  
- ✨ **Added `CoconutStyles`** – Common UI styles and border radius settings.  
---
