import 'package:flutter/material.dart';

class MyPopUpMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  // ignore: non_constant_identifier_names
  final Function OnClick;
  // ignore: non_constant_identifier_names
  MyPopUpMenuItem({@required this.OnClick, @required this.child})
      : super(child: child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopUpMenuItemState();
  }
}

class MyPopUpMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopUpMenuItem<T>> {
  @override
  void handleTap() {
    widget.OnClick();
  }
}
