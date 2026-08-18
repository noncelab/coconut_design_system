# 🥥 Coconut Design System

The **Coconut Design System** is a modern, reusable UI component library for Flutter, developed by **Nonce Lab**. It provides a **consistent**, **customizable**, and **theme-aware** UI for building high-quality mobile applications.


## 🚀 Features
- **Reusable UI Components** – Buttons, Tooltips, Toasts, Bottom Sheets, etc.
- **Theme-Aware** – Supports **light & dark mode**.
- **Highly Customizable** – Easily change colors, fonts, sizes, etc.
- **Performance Optimized** – Built with **Flutter best practices**.
- **MIT Licensed** – Open-source, with Commons Clause.

---

## 📦 Installation

To use Coconut Design System in your Flutter project, add it as a dependency:

### 1️⃣ **Add the Package**
```sh
flutter pub add coconut_design_system
```
Or manually add it in your pubspec.yaml:
```
dependencies:
  coconut_design_system: latest_version
```

### 2️⃣ Import the Library
```
import 'package:coconut_design_system/coconut_design_system.dart';
```

---

## 📚 Usage Guide

### 🟢 Buttons
```
CoconutButton(
  text: "Click Me",
  onPressed: () {
    print("Button Clicked!");
  },
);
```
### 🟡 Toast Messages
```
CoconutToast.showToast(
  context: context,
  text: "This is a toast message!",
);
```
### 🔵 Bottom Sheet
```
showModalBottomSheet(
  context: context,
  builder: (context) => CoconutBottomSheet(
    appBar: AppBar(title: Text("Title")),
    body: Text("This is a bottom sheet."),
  ),
);
```
---
## 🎨 Theming & Customization

The Coconut Design System supports light and dark mode, and allows you to customize:
	•	Colors
	•	Typography
	•	Shapes & Borders
	•	Icons & Sizes

Example:
```
CoconutButton(
  text: "Custom Button",
  backgroundColor: Colors.purple,
  textColor: Colors.white,
);
```
---
## 🛠 Available Components
| Component                | Description                                      |
|-------------------------|--------------------------------------------------|
| ✅ **Buttons**          | Standard, Segmented, Underlined Buttons         |
| 🔔 **Toasts**           | Top & Bottom Toast Notifications                 |
| 📥 **Bottom Sheets**    | Modal & Fixed Bottom Sheets                      |
| 📌 **Tooltips**         | Fixed & Floating Tooltips                        |
| 📂 **Pulldowns**        | Custom Dropdown Menus                            |
| 🔄 **Indicators**       | Circular & Progress Indicators                   |
| 🔳 **Inputs**           | Checkbox, Chip, Pulldown, Stepper, Switch, TagChip, TextField |
| 📏 **Overlays**         | Popup, Pulldown Menu, Toast, Bubble Clipper      |
| 🎨 **Theme**            | Color Scheme, Typography, Data                   |
| 📑 **App Bar**          | Customizable App Bar & Buttons                   |
| 🖼 **Icons**            | Custom Icon Components                           |

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
