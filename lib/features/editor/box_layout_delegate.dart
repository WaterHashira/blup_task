import 'package:flutter/material.dart';

class BoxLayoutDelegate extends MultiChildLayoutDelegate {
  final double maxHeight;
  final double maxWidth;
  final Map<int, Offset> originalBoxMap;
  BoxLayoutDelegate(
      {required this.maxHeight,
      required this.maxWidth,
      required this.originalBoxMap});

  @override
  void performLayout(Size size) {
    List<int> boxIdList = originalBoxMap.keys.toList();
    for (int i = 0; i < boxIdList.length; i++) {
      layoutChild(boxIdList[i],
          BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight));
      positionChild(boxIdList[i], originalBoxMap[boxIdList[i]]!);
    }
  }

  //TODO: modify this method acc. to the implementtion needs
  @override
  bool shouldRelayout(BoxLayoutDelegate oldDelegate) {
    return (originalBoxMap != oldDelegate.originalBoxMap);
  }
}
