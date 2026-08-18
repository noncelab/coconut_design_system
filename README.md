# 🥥 Coconut Design System

The **Coconut Design System** is a reusable UI component library for Flutter, developed by **Nonce Lab**. It provides consistent, customizable, and theme-aware components for building mobile applications.

## 🚀 Features

- **Reusable UI Components** – Buttons, inputs, overlays, indicators, and more.
- **Theme-Aware** – Supports light and dark modes.
- **Customizable** – Configure colors, typography, sizing, and component behavior.
- **Animations** – Includes reusable entrance, exit, shake, slide, typewriter, and zoom animations.
- **MIT Licensed** – Open source under the MIT License.

---

## 📦 Installation

To use Coconut Design System in your Flutter project, add it as a dependency:

### 1️⃣ Add the package

```sh
flutter pub add coconut_design_system
```

Or manually add it in your pubspec.yaml:

```yaml
dependencies:
  coconut_design_system: latest_version
```

### 2️⃣ Import the library

```dart
import 'package:coconut_design_system/coconut_design_system.dart';
```

---

## 📚 Usage Guide

### 🟢 Buttons

```dart
CoconutButton(
  text: 'Click Me',
  onPressed: () {
    print('Button Clicked!');
  },
);
```

### 🟡 Toast Messages

```dart
CoconutToast.showToast(
  context: context,
  text: 'This is a toast message!',
);
```

### 🔵 Bottom Sheet

```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (context) => CoconutBottomSheet(
    appBar: AppBar(title: const Text('Title')),
    body: const Text('This is a bottom sheet.'),
  ),
);
```

---

## 🎨 Theming & Customization

The Coconut Design System supports light and dark mode, and allows you to customize:

- Colors
- Typography
- Shapes and borders
- Icons and sizes

Example:

```dart
CoconutButton(
  text: 'Custom Button',
  onPressed: () {},
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
);
```

---

## 🛠 Available Components

| Category | Components |
|----------|------------|
| **Buttons & controls** | Button, Underlined Button, Segmented Control |
| **Inputs** | Checkbox, Chip, Date Picker, Option Picker, Pulldown, Stepper, Switch, Tag Chip, Text Field |
| **Overlays** | Bottom Sheet, Popup, Pulldown Menu, Toast, Tooltip |
| **Indicators** | Circular Indicator, Progress Indicator |
| **Navigation** | App Bar, Frosted App Bar, App Bar Button |
| **Icons** | Custom icon component |
| **Animations** | Bounce, Character Fade, Fade, Scale, Shake, Slide, Typewriter, Zoom |
| **Theme & styling** | Colors, layout, sizes, styles, theme, typography |

---

## 🤝 Contributing

We welcome contributions! If you’d like to improve the **Coconut Design System**, follow these steps:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b new-feature`)
3. **Commit your changes** (`git commit -m "Add new feature"`)
4. **Push to the branch** (`git push origin new-feature`)
5. **Submit a Pull Request!** 🚀

---

## 🛠 Support & Feedback

For **issues, feature requests, or feedback**, feel free to:

- Open an issue on **[GitHub](https://github.com/noncelab/coconut_design_system/issues)**
- Contact us at **hello@noncelab.com**

---

## ⭐ Star & Follow

If you like this project, please **star** the repo and **follow** us for updates! 🚀✨

---

## License

Reference [LICENSE](LICENSE)
