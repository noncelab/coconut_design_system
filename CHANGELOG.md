# 📜 CHANGELOG  

All notable changes to the **Coconut Design System** will be documented in this file.  
This project follows **[Semantic Versioning](https://semver.org/)**.
---

## **[0.9.3] - 2025-08-22**

### ✨ Features

- **AppBar**
  - Set `statusBarColor` to transparent in Android `SystemUiOverlayStyle`.

- **TextField**
  - Added `textScaler` to `CoconutTextField` description text.

### 🛠 Fixes

- Applied `FittedBox` to `CoconutTextField` placeholder and `CoconutButton` text for proper scaling.

---

## **[0.9.2] - 2025-08-07**

### ✨ Features

- **TextField**
  - Added `autocorrect` and `enableSuggestions` options.
  - Added `onEditingComplete` callback to `CoconutTextField`.

- **AppBar**
  - Applied `systemOverlayStyle` to `buildHomeAppbar` based on platform and brightness.

---

## **[0.9.1] - 2025-07-18**

### ✨ Features

- **Colors**
  - Added `gray750` to `CoconutColors`.

- **Layout**
  - Added `spacing_150` to `CoconutLayout`.

- **AppBar**
  - Added `customTitle` attribute.
  - Removed `HitTestBehavior.translucent` from `GestureDetector` on `customTitle`.
  - Made `title` attribute optional.

- **TextField**
  - Added `fontWeight` and `borderRadius` attributes.
  - Added `enableInteractiveSelection`.

- **Tooltip**
  - Added `borderRadius` attribute.

- **Switch**
  - Added support for `trackColor` and `scale`.
  - Applied minimum size constraints.

- **Animation**
  - Introduced `CoconutShakeAnimation` widget for reusable shake effects.

### 🛠 Fixes

- **TextField**
  - Fixed `onChanged` not triggering when `controller.text` changes.
  - Prevented multiple listener calls when text is unchanged.

- **Switch**
  - Ensured minimum size application to `CoconutSwitch`.

---

## **[0.9.0] - 2025-06-17**

### ✨ Features
- **`CoconutColors`**
  - Added `warningText`, `borderGray`, `borderLightGray`, `oceanBlue`, `whiteLilac`, `searchbarBackground`, `searchbarHint`, `searchbarText`, `cyanBlue`, `secondaryText`, `gray850`, `warningYellow`, `warningYellowBackground`.
- **Styles**
  - Introduced `CoconutBorder`, `CoconutPadding`, `CoconutBoxDecoration` utility classes for standardized styling.
- **`CoconutToast`**
  - Added support for replacing an existing toast.

### 🛠 Fixes
- **Color**
  - Fixed typo in color name: `borderLightgray` → `borderLightGray`.
- **`CoconutTextField`**
  - Fixed placeholder text to always initialize regardless of prefix presence.
- **`CoconutAppBar`**
  - Fixed platform-specific `systemOverlayStyle` handling for accurate status bar icon brightness.
  - Replaced `null` with an empty `Container` as `flexibleSpace` fallback to avoid rendering issues.

### ♻️ Refactor
- Simplified `home-appbar-icon` layout and padding logic.

---

## **[0.8.0] - 2025-05-09**

### ⚠️ Breaking Changes
- **`CoconutPulldownMenu`**
  - Replaced `buttons` and `onTap` with `entries` and `onSelected`.
  - `entries` is now **required**.
  - Introduced `CoconutPulldownMenuGroup` to support grouped items.
  - Deprecated `buttons` and `onTap`. Backward compatibility maintained temporarily.
  - ⚠️ Update your implementations to use the new `entries` model.
  - Improved divider and border handling for dynamic structures.

### ✨ Features
- **`CoconutToolTip`**
  - Added support for optional custom icons.
  - Adjusted icon alignment dynamically based on `richText` line count.
- **`CoconutTextField`**
  - Placeholder now stays top-aligned and toggles visibility with focus.
  - Counter color logic refined and placeholder ignores pointer events.
  - Placeholder text height now aligns with input text height.
  - Added demo `svg` asset for `obscureText` mode.
- **`CoconutToast`**
  - New method: `showWarningToast()` with warning color and icon.
  - Icon alignment now adjusts based on `richText` line count.

### 🛠 Fixes
- **`CoconutPulldownMenu`**
  - Default horizontal padding corrected to `20`.
  - Top border radius now applied correctly when the first item is not a group.
- **`CoconutTextField`**
  - Placeholder behavior and layout improved as above.
- **`CoconutAppBar` / `CoconutPopup`**
  - `buildWithNext`'s `toolbarHeight` adjusted for bottom app bars.
  - Fixed leading icon padding and popup dialog radius mismatch.
- **`CoconutToast`**
  - Fixed iOS dark background issue by setting `MaterialType.transparency`.

### ♻️ Refactor
- Renamed toast icon asset: `circle_info.svg` → `info_circle.svg`.
- Adjusted icon sizing and alignment within toast components.

---

## **[0.7.4] - 2025-04-17**

### ✨ Features
- **`CoconutTextField`**
  - Added `textInputFormatter` parameter.

---

## **[0.7.3] - 2025-04-16**

### ✨ Features
- Added `CoconutFrostedAppBar`, a new `PreferredSizeWidget` variant with blur background, scroll-based title opacity, and dynamic background color adjustment based on scroll.
- Added support for automatic `line-height` (`height`) scaling based on font size via `applyVariation()`.
  - Headings (`≥ 24px`): `1.2`
  - Body text and captions (`< 24px`): `1.4`

### ♻️ Refactor
- Unified theming logic by removing `brightness` parameters and using `Theme.of(context).brightness` internally.
- Simplified AppBar button icon rendering using shared asset logic.
- Extracted and renamed internal AppBar builder functions for clarity and modularity:
  - `build()` – general AppBar with optional back/close icon, sublabel, etc.
  - `buildHomeAppbar()` – sliver-based AppBar optimized for home layouts.
  - `buildWithNext()` – AppBar variant with a trailing "Next" action button.

### 💄 UI Improvements
- Consistent spacing, padding, and icon sizing across all AppBar types.
- Added support for `PreferredSize bottomWidget` and `EdgeInsets appBarInnerMargin` in `buildHomeAppbar` for dynamic layout flexibility.

### 🧼 Cleanup
- Improved documentation with usage examples and detailed parameter descriptions.
- Removed unnecessary keys and parameters like `faucetIconKey` for simplification.
- All predefined `TextStyle` entries in `CoconutTypography` now include consistent `height` values for better vertical rhythm and layout consistency.

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
