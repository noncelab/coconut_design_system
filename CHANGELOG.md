# 📜 CHANGELOG  

All notable changes to the **Coconut Design System** will be documented in this file.  
This project follows **[Semantic Versioning](https://semver.org/)**.

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
