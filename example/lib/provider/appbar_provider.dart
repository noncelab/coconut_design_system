import 'package:flutter/material.dart';

class AppbarProvider with ChangeNotifier {
  AppbarType _appbarType = AppbarType.home;
  bool _isAppIconVisible = true;
  bool _isLeadingVisible = true;
  bool _isSubLabelVisible = true;
  bool _isNextButtonVisible = false;
  bool _isActionButtonVisible = true;
  bool _isTitlePressable = false;
  bool _isClosable = false;

  AppbarType get appbarType => _appbarType;
  bool get isActionButtonVisible => _isActionButtonVisible;
  bool get isAppIconVisible => _isAppIconVisible;
  bool get isClosable => _isClosable;
  bool get isLeadingVisible => _isLeadingVisible;
  bool get isNextButtonVisible => _isNextButtonVisible;
  bool get isSubLabelVisible => _isSubLabelVisible;
  bool get isTitlePressable => _isTitlePressable;

  void toggleActionButtonVisible() {
    _isActionButtonVisible = !_isActionButtonVisible;
    notifyListeners();
  }

  void toggleAppbar() {
    _appbarType =
        _appbarType == AppbarType.home ? AppbarType.topNavi : AppbarType.home;
    notifyListeners();
  }

  void toggleAppIconVisible() {
    _isAppIconVisible = !_isAppIconVisible;
    notifyListeners();
  }

  void toggleClosable() {
    _isClosable = !_isClosable;
    notifyListeners();
  }

  void toggleContainer(ContainerType type) {
    notifyListeners();
  }

  void toggleLeadingVisible() {
    _isLeadingVisible = !_isLeadingVisible;
    notifyListeners();
  }

  void toggleNextButtonVisible() {
    _isNextButtonVisible = !_isNextButtonVisible;
    notifyListeners();
  }

  void toggleSubLabelVisible() {
    _isSubLabelVisible = !_isSubLabelVisible;
    notifyListeners();
  }

  void toggleTitlePressable() {
    _isTitlePressable = !_isTitlePressable;
    notifyListeners();
  }
}

enum AppbarType {
  home,
  topNavi,
}

enum ContainerType {
  ios,
  android,
  subwindow,
}
